Reflux = require 'reflux'
{api} = require '../api/client'
config = require '../lib/config'
classifierActions = require '../actions/classifier-actions'

module.exports = Reflux.createStore
  data: null

  init: ->
    @next()
    @listenTo classifierActions.moveToNextSubject, @next

  getInitialState: ->
    @data

  next: ->
    query =
      workflow_id: config.workflowId
      sort: 'queued'

    api.type('subjects').get query
      .then (subjects) =>
        return unless subjects.length > 0

        randomInt = Math.floor(Math.random() * subjects.length)
        @data = subjects[randomInt]

      .then => 
          image = new Image()
          image.src = @data.locations[0]["image/jpeg"]
          image.onload = =>
            @data.srcWidth = image.naturalWidth
            @trigger @data

