Reflux = require 'reflux'
projectConfig = require '../lib/config'
subjectStore = require '../stores/subject-store'
classifierActions = require '../actions/classifier-actions'
{api} = require '../api/client'

module.exports = Reflux.createStore
  init: ->
    @listenTo subjectStore, @getFavorites
    @listenTo classifierActions.moveToNextSubject, @getSubjectInCollection

  getInitialState: ->
    @favorited

  getFavorites: ->
    query =
      project_id: projectConfig.projectId
      favorite: true

    api.type('collections').get(query)
      .then ([favorites]) =>
        @favorites = if favorites? then favorites else null
        @getSubjectInCollection(@favorites)

  getSubjectInCollection: (favorites) ->
    @subjectID = subjectStore.data.id
    if favorites?
      favorites.get('subjects', id: @subjectID)
        .then ([subject]) =>
          @favorited = subject?
          @trigger @favorited

  createFavorites: ->
    project = projectConfig.projectId
    display_name = "Favorites #{project}"
    subjects = [@subjectID]
    favorite = true

    links = {subjects}
    links.project = project
    collection = {favorite, display_name, links}

    api.type('collections').create(collection).save().then =>
      @favorited = true
      @trigger @favorited

  removeSubjectFrom: ->
    @favorites.removeLink('subjects', [@subjectID.toString()]).then =>
      @favorited = false
      @trigger @favorited

  addSubjectTo: ->
    @favorites.addLink('subjects', [@subjectID.toString()]).then =>
      @favorited = true
      @trigger @favorited

  toggleFavorite: ->
    if not @favorites?
      @createFavorites()
    else if @favorited
      @removeSubjectFrom()
    else
      @addSubjectTo()
