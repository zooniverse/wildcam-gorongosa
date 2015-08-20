Reflux = require 'reflux'
{api} = require '../api/client'
config = require '../lib/config'
workflowActions = require '../actions/workflow-actions'

module.exports = Reflux.createStore
  listenables: workflowActions
  data: null

  init: ->
    api.type('workflows').get config.workflowId
      .then (@data) =>
        window.workflow = @data # for debugging purposes
        @trigger @data
