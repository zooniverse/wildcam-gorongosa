Reflux = require 'reflux'
_ = require 'underscore'
counterpart = require 'counterpart'
{api} = require '../api/client'
classifyActions = require '../actions/classify-actions'
projectStore = require './project-store'
projectConfig = require '../lib/project-config'

ClassifyStore = Reflux.createStore
  listenables: classifyActions

  init: ->
    @listenTo projectStore, @getWorkflow

  getInitialState: ->
    @data

  getWorkflow: (@project = null) ->
    unless @project
      return throw new Error 'cannot fetch workflows for project'

    api.type('workflows').get projectConfig.workflowId
      .then (@workflow) =>
        @getNextSubject()

  getNextSubject: ->
    query =
      workflow_id: @workflow.id
      sort: 'queued'

    api.type('subjects').get query
      .then (subjects) =>
        if subjects.length is 0
          # handle empty subjects array
          return

        randomInt = Math.floor(Math.random() * subjects.length)
        subject = subjects[randomInt]
        @createNewClassification @workflow, subject

  createNewClassification: (workflow, subject) ->
    classification = api.type('classifications').create
      annotations: []
      metadata:
        workflow_version: workflow.version
        started_at: (new Date).toISOString()
        user_agent: navigator.userAgent
        user_language: counterpart.getLocale()
        utc_offset: ((new Date).getTimezoneOffset() * 60).toString()
      links:
        project: @project.id
        workflow: workflow.id
        subjects: [subject.id]

    classification._workflow = workflow
    classification._subjects = [subject]

    @createStore(workflow, classification, subject)

  createStore: (workflow, classification, subject) ->
    @data =
      workflow: workflow
      subject: subject
      classification: classification

    @trigger @data

  finishClassification: ->
    upsert =
      completed: true
      'metadata.finished_at': (new Date).toISOString()
      'metadata.viewport':
        width: innerWidth
        height: innerHeight

    @data?.classification
      .update upsert
      .save()
      .then (classification) ->
        classification.destroy()
      .catch (error) ->
        console.error 'error saving c'

module.exports = ClassifyStore
