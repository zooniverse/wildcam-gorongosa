Reflux = require 'reflu'
config = require '../lib/config'
subjectActions = require '../actions/subject-actions'

module.exports = Reflux.createStore
  listenables: subjectActions

  data: null

  init: ->
    @onNext()

  onNext: ->
    query =
      workflow_id: config.workflowId
      sort: 'queued'

    api.type('subjects').get query
      .then (subjects) =>
        return unless subjects.length > 0

        randomInt = Math.floor(Math.random() * subjects.length)
        @data = subjects[randomInt]

        @trigger @data
