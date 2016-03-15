Reflux = require 'reflux'
{api} = require '../api/client'
config = require '../lib/config'
classifierActions = require '../actions/classifier-actions'

module.exports = Reflux.createStore
  subjects: []
  subject: null

  init: ->
    @next()
    @listenTo classifierActions.moveToNextSubject, @next

  getInitialState: ->
    @subjects
    @subject

  next: ->
    if @subjects.length == 0
      query =
        workflow_id: config.workflowId
        sort: 'queued'

      api.type('subjects').get query
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
