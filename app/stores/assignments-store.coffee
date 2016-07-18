Reflux = require 'reflux'

workflowActions = require '../actions/workflow-actions'
userActions = require '../actions/user-actions'
userStore = require './user-store'
{api} = require '../api/client'

module.exports = Reflux.createStore
  listenables: userActions
  data:
    assignments: []
    active: false

  init: ->
    userStore.listen (userData) =>
      if userData
        @_fetchAssignments userData.user

  getInitialState: ->
    @data

  onSignOut: ->
    @data =
      assignments: []
      active: false
    @trigger @data
    workflowActions.setWorkflow()

  _fetchAssignments: (user) ->
    fetch 'https://education-api.zooniverse.org/assignments/',
      method: 'GET',
      mode: 'cors',
      headers: new Headers
        'Authorization': api.headers.Authorization,
        'Content-Type': 'application/json'
    .then (response) ->
      response.json()
    .then (json) =>
      if json.data.length
        @data.active = true
        @data.assignments = json.data
    .catch (err) =>
      console.error 'Error fetching assignments', err

