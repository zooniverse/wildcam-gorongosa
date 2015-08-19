Reflux = require 'reflux'
counterpart = require 'counterpart'
{api} = require '../api/client'
config = require '../lib/config'

classifierActions = require '../actions/classifier-actions'

projectStore = require './project-store'
workflowStore = require './workflow-store'
subjectStore = require './subject-store'

module.exports = Reflux.createStore
  data: null

  init: ->
    @listenTo classifierActions.finishClassification, @finish
    @listenTo workflowStore, @onReceiveData
    @listenTo subjectStore, @onReceiveData

  onReceiveData: ->
    if workflowStore.data and subjectStore.data
      @create()

  create: ->
    classification = api.type('classifications').create
      metadata:
        workflow_version: workflowStore.data.version
        started_at: (new Date).toISOString()
        user_agent: navigator.userAgent
        user_language: counterpart.getLocale()
        utc_offset: ((new Date).getTimezoneOffset() * 60).toString()
      links:
        project: config.projectId
        workflow: config.workflowId
        subjects: [subjectStore.data.id]

    # classification._workflow = workflowStore.data
    # classification._subjects = [subjectStore.data]

    @trigger @data

  finish: ->
    upsert =
      annotations: annotationsStore.data
      completed: true
      'metadata.finished_at': (new Date).toISOString()
      'metadata.viewport':
        width: innerWidth
        height: innerHeight

    @data.update upsert
      .save()
      .then (classification) ->
        classification.destroy()
      .catch (error) ->
        console.error 'error saving c', error
