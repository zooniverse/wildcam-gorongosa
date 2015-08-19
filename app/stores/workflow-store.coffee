Reflux = require 'reflux'
config = require '../lib/config'
workflowActions = require '../action/workflow-actions'

module.exports = Reflux.createStore
  listenables: workflowActions
  data: null

  getWorkflow: ->
    api.type('workflows').get config.workflowId
      .then (@data) =>
        @trigger @data
