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
    api.type('projects').get(projectConfig.projectId)
      .then (@data) =>
        @trigger @data

  getLaunchedProjects: ->
    query =
      launch_approved: true
      page_size: 35

    api.type('projects').get(query)
      .then (projects) -> projects
