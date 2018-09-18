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
        page_size: 10  #Panotes's /subjects/queued will return same default subjects when workflow is 100% classified/retired.
        #10 is default, increase to 100 if users (e.g. HHMI teachers) request to see more varied subjects for demonstrating to classrooms.

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
      
    #Due to potential human error, we cannot always be certain that the uploaded
    #Subjects will have the expected MIME type of 'image/jpeg', so we have to
    #compensate. (@shaun 20180918)
    mimeType = 'image/jpeg'
    if @state?.subject?.locations?[0]?
      mimeType = Object.keys(@state.subject.locations[0])[0]
    
    @generateHttpsUrl(mimeType)
    image = new Image()
    image.src = @subject.locations[0][mimeType]
    image.onload = =>
      @subject.srcWidth = image.naturalWidth
      @trigger @subject

  generateHttpsUrl: (mimeType) ->
    # If it's not an https url, we replace the s3 domain name with a secure one
    url = @subject.locations[0][mimeType]
    if url.substr(0, 5) != 'https'
      filename = url.replace /https?:\/\/[^\/]+/i, ''
      @subject.locations[0][mimeType] = 'https://zooniverse-export.s3.amazonaws.com' + filename

  changeWorkflow: ->
    @subject = null
    @subjects.length = 0
    @trigger @subject
    @next()
