Reflux = require 'reflux'
{api} = require '../api/client'
workflowActions = require '../actions/workflow-actions'
assignmentStore = require './assignments-store'

module.exports = Reflux.createStore
  listenables: workflowActions
  data: null

  init: ->
    assignmentStore.listen (assignmentData) =>
      if assignmentData.activeAssignment
        @setWorkflow assignmentData.activeAssignment.workflowId

  getInitialState: ->
    @data

  setWorkflow: (newWorkflowId) ->
    if !@data or @data.id isnt newWorkflowId
      api.type('workflows').get newWorkflowId
        .then (@data) =>
          console.warn "Assignment workflow #{newWorkflowId}"
          @trigger @data

