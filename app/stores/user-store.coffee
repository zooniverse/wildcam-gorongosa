Reflux = require 'reflux'
oauth = require 'panoptes-client/lib/oauth'
projectConfig = require '../lib/config'
userActions = require '../actions/user-actions'

# checkStatus = (response) ->
#   if response.status >= 200 && response.status < 300
#     return response
#   else
#     error = new Error response.statusText
#     error.response = response
#     throw error

# parseJson = (response) ->
#   response.json()

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
    # if token = @_tokenExists()
    #   @_setToken token

    @getUser()

  getInitialState: ->
    @userData

  getUser: ->
    # token = @_getToken()

    oauth.checkCurrent()
      .then (user) =>
        @getUserClassificationCount(user)
      .catch (error) =>
        @userData = null
        @trigger @userData

    # fetch(api.root + '/me', {
    #   method: 'GET'
    #   headers:
    #     'Authorization': 'Bearer ' + token
    #     'Accept': 'Accept: application/vnd.api+json; version=1'
    #   })
    #   .then checkStatus
    #   .then parseJson
    #   .then (data) =>
    #     @getUserClassificationCount(data.users[0])
    #   .catch (error) =>
    #     @userData = null
    #     @trigger @userData

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
    # oauth.signIn(window.location.origin)

  onSignOut: ->
    # @_removeToken()
    # @getUser()
    oauth.signOut().then(() -> @getUser())

  _computeRedirectURL: (window) ->
    { location } = window;
    location.origin || "#{location.protocol}//#{location.hostname}:#{location.port}"
  # _tokenExists: ->
  #   extractToken(window.location.hash) || localStorage.getItem('bearer_token')

  # _getToken: ->
  #   token = null
  #   token ?= localStorage.getItem 'bearer_token'
  #   token ?= extractToken window.location.hash

  #   token

  # _setToken: (token) ->
  #   api.headers['Authorization'] = 'Bearer ' + token
  #   localStorage.setItem 'bearer_token', token

  # _removeToken: ->
  #   api.headers['Authorization'] = null
  #   localStorage.removeItem 'bearer_token'
