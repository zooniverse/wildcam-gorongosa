Reflux = require 'reflux'
{api} = require '../api/client'
config = require '../lib/config'
classifierActions = require '../actions/classifier-actions'

module.exports = Reflux.createStore
  data: null

  init: ->
    @next()
    @listenTo classifierActions.moveToNextSubject, @next

  next: ->
    query =
      workflow_id: config.workflowId
      sort: 'queued'

    api.type('subjects').get query
      .then (subjects) =>
        return unless subjects.length > 0

        randomInt = Math.floor(Math.random() * subjects.length)
        @data = subjects[randomInt]

        @trigger @data
