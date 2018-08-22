Reflux = require 'reflux'
api = require 'panoptes-client/lib/api-client'
oauth = require 'panoptes-client/lib/oauth'
projectConfig = require '../lib/config'
userActions = require '../actions/user-actions'
{ env } = require '../api/config'

extractToken = (hash) -> 
  if hash.indexOf('assignment') > -1
    match = hash.match(/classify\/assignment-(\d+)\/access_token=([\w\-\.]+)/)
    if !!match && match[2] 
      assignmentPath = '/classify/assignment-' + match[1]
      window.location.hash = assignmentPath
      match[2]
    else
      null
  else
    match = hash.match(/access_token=([\w\-\.]+)/) 
    if !!match && match[1]
      match[1]
    else
      null
  

module.exports = Reflux.createStore
  listenables: userActions

  init: ->
    @getUser()

  getInitialState: ->
    @userData

  getUser: ->
    oauth.checkCurrent()
      .then (user) =>
        @getUserClassificationCount(user)
      .catch (error) =>
        @userData = null
        @trigger @userData

  getUserClassificationCount: (user, _page = 1) ->
    query =
      user_id: user.id
      project_id: projectConfig.projectId
      page: _page
    api.type('project_preferences').get(query).then ([projectPreferences]) =>
      @createStore(user, projectPreferences)

  getUserAvatar: (user) ->
    query:
      user_id: user.id
    api.type('users').get(user.id).get('avatar')
      .then ([avatar]) ->
        avatar
      .catch (error) ->
        avatar = null
        avatar

  createStore: (user, projectPreferences) ->
    @userData =
      user: if user? then user else null
      projectPreferences: if projectPreferences? then projectPreferences else null
    @trigger @userData

  doSignIn: (location = null) ->
    oauth.signIn(@_computeRedirectURL(window))

  onSignOut: ->
    oauth.signOut().then(() => @createStore(null, null))

  _computeRedirectURL: (window) ->
    { location } = window

    if env is 'staging' or env is 'development'
      "#{location.protocol}//#{location.hostname}:#{location.port}"
    else if env is 'production' and location.origin.indexOf('local.zooniverse.org') > -1
      "#{location.protocol}//#{location.hostname}:#{location.port}?env=production"
    else
      location.origin
