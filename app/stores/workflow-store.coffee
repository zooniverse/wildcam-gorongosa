Reflux = require 'reflux'
{api} = require '../api/client'
workflowActions = require '../actions/workflow-actions'
assignmentStore = require './assignments-store'
projectStore = require './project-store'

module.exports = Reflux.createStore
  listenables: workflowActions
  data: null

  init: ->
    assignmentStore.listen (assignmentData) =>
      if assignmentData.activeAssignment
        @setWorkflow assignmentData.activeAssignment.workflowId
      else
        @listenTo projectStore, @getDefaultWorkflow

  getInitialState: ->
    @data

  getDefaultWorkflow: (projectData) ->
    @setWorkflow projectData.configuration.default_workflow

  setWorkflow: (newWorkflowId) ->
    if !@data or @data.id isnt newWorkflowId
      api.type('workflows').get newWorkflowId
        .then (@data) =>
          console.warn "Workflow set to #{newWorkflowId}"
          @trigger @data

