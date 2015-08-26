Reflux = require 'reflux'
counterpart = require 'counterpart'
{api} = require '../api/client'
config = require '../lib/config'

classifierActions = require '../actions/classifier-actions'

annotationsStore = require './annotations-store'
projectStore = require './project-store'
subjectStore = require './subject-store'
workflowStore = require './workflow-store'

module.exports = Reflux.createStore
  data: null

  init: ->
    @listenTo workflowStore, @onReceiveData
    @listenTo subjectStore, @onReceiveData

  onReceiveData: ->
    if workflowStore.data and subjectStore.data
      @create()

  create: ->
    @data = api.type('classifications').create
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

    @trigger @data

  finish: ->
    annotations = _.map annotationsStore.data, (annotation) ->
      task: 'survey'
      value: annotation

    upsert =
      annotations: annotations
      completed: true
      'metadata.finished_at': (new Date).toISOString()
      'metadata.viewport':
        width: innerWidth
        height: innerHeight

    @data.update upsert
      .save()
      .then (classification) ->
        console.log 'classification saved', classification
        classification.destroy()
      .catch (error) ->
        console.error 'error saving c', error
