Reflux = require 'reflux'
{api} = require '../api/client'
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
