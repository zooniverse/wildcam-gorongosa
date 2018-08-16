Reflux = require 'reflux'
api = require 'panoptes-client/lib/api-client'
classifierActions = require '../actions/classifier-actions'
workflowStore = require './workflow-store'

module.exports = Reflux.createStore
  subjects: []
  subject: null

  init: ->
    @listenTo workflowStore, @changeWorkflow
    @listenTo classifierActions.moveToNextSubject, @next

  getInitialState: ->
    @subjects
    @subject

  next: ->
    if @subjects.length == 0
      query =
        workflow_id: workflowStore.data.id
        page_size: 100  #Increases subjects in queue, so users will have a larger variety of photos when workflow is fully classified/retired.

        #Context: in Feb 2018, HHMI-aligned teachers attempted to use WildCam
        #Gorongosa for their classrooms but found that the app kept serving the
        #same 10 images; this is the result of Panoptes (by design) serving the
        #default 10 subjects when the workflow is fully classified/retired. By
        #increasing the number of subjects to 100 (order is randomised), we
        #mask the repetition of subjects for classroom users.
        #This workaround is requested by HHMI themselves.
        #(@shaun 20180214)

      api.get('/subjects/queued', query)
        .then (subjects) =>
          return unless subjects.length > 0
          @subjects = subjects
        .then =>
          @loadSubjectImage()
    else
      @loadSubjectImage()

  loadSubjectImage: ->
    @subject = @subjects.shift()
    
    #Fix: some image locations are erroneously tagged as images/png; this workaround ensures standardisation. (-shaun 20171205)
    if @subject.locations[0]['image/png']? and not @subject.locations[0]['image/jpeg']?
      @subject.locations[0]['image/jpeg'] = @subject.locations[0]['image/png']
    
    @generateHttpsUrl()
    image = new Image()
    image.src = @subject.locations[0]['image/jpeg']
    image.onload = =>
      @subject.srcWidth = image.naturalWidth
      @trigger @subject

  generateHttpsUrl: ->
    # If it's not an https url, we replace the s3 domain name with a secure one
    url = @subject.locations[0]['image/jpeg']
    if url.substr(0, 5) != 'https'
      filename = url.replace /https?:\/\/[^\/]+/i, ''
      @subject.locations[0]['image/jpeg'] = 'https://zooniverse-export.s3.amazonaws.com' + filename

  changeWorkflow: ->
    @subject = null
    @subjects.length = 0
    @trigger @subject
    @next()
