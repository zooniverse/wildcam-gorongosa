Reflux = require 'reflux'
counterpart = require 'counterpart'
{api} = require '../api/client'
classificationActions = require '../actions/classification-actions'
projectStore = require './project-store'
config = require '../lib/config'

module.exports = Reflux.createStore
  listenables: classificationActions

  data: null

  init: ->
    @listenTo projectStore, @getWorkflow

  # getWorkflow: (@project = null) ->
  #   unless @project
  #     return throw new Error 'cannot fetch workflows for project'
  #
  #   api.type('workflows').get projectConfig.workflowId
  #     .then (@workflow) =>
  #       @getNextSubject()

  # getNextSubject: ->
  #   query =
  #     workflow_id: @workflow.id
  #     sort: 'queued'
  #
  #   api.type('subjects').get query
  #     .then (subjects) =>
  #       if subjects.length is 0
  #         # handle empty subjects array
  #         return
  #
  #       randomInt = Math.floor(Math.random() * subjects.length)
  #       subject = subjects[randomInt]
  #       @createNewClassification @workflow, subject

  onCreate: (workflow, subject) ->
    classification = api.type('classifications').create
      annotations: []
      metadata:
        workflow_version: workflow.version
        started_at: (new Date).toISOString()
        user_agent: navigator.userAgent
        user_language: counterpart.getLocale()
        utc_offset: ((new Date).getTimezoneOffset() * 60).toString()
      links:
        project: config.projectId
        workflow: config.workflowId
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
