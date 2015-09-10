Reflux = require 'reflux'
projectConfig = require '../lib/config'
userStore = require '../stores/user-store'
{api} = require '../api/client'

module.exports = Reflux.createStore
  data: null

  init: ->
    @listenTo userStore, @getProject

  getInitialState: ->
    @data

  getProject: ->
    query = now: Date.now()

    api.type('projects').get(projectConfig.projectId, query)
      .then (@data) =>
        @trigger @data

  getLaunchedProjects: ->
    query =
      launch_approved: true
      page_size: 35

    api.type('projects').get(query)
      .then (projects) -> projects
