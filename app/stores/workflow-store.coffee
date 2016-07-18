Reflux = require 'reflux'
{api} = require '../api/client'
config = require '../lib/config'
workflowActions = require '../actions/workflow-actions'

module.exports = Reflux.createStore
  listenables: workflowActions
  data: null

  init: ->
    @onSetWorkflow()

  getInitialState: ->
    @data

  onSetWorkflow: (workflowId = config.workflowId) ->
    api.type('workflows').get workflowId
      .then (@data) =>
        @trigger @data
