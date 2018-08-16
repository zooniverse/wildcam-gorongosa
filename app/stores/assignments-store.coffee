_ = require 'lodash'
Reflux = require 'reflux'

workflowActions = require '../actions/workflow-actions'
userActions = require '../actions/user-actions'
assignmentActions = require '../actions/assignment-actions'
userStore = require './user-store'
api = require 'panoptes-client/lib/api-client'
config = require '../lib/config'

module.exports = Reflux.createStore
  listenables: assignmentActions
  data:
    assignments: [
      id: '0',
      name: 'No assignment'
      workflowId: config.workflowId
      classificationTarget: ''
      myClassificationCount: 0
    ]
    activeAssignment: false
    active: undefined

  init: ->
    userStore.listen (userData) =>
      if userData?
        @_fetchAssignments userData.user
      else if userData is null
        newState = _.assign {}, @data, active: false
        @data = newState
        @trigger @data

  getInitialState: ->
    @data

  onSetAssignment: (newAssignmentId = '0') ->
    if !@data.activeAssignment or !@data.activeAssignment.id isnt newAssignmentId
      newState = _.assign {}, @data
      newState.activeAssignment = newState.assignments.find (assignment) =>
        assignment.id is newAssignmentId

      if newState.activeAssignment
        console.warn "Setting assignment to #{newAssignmentId}"
        @data = newState
        @trigger @data
        
  onIncrementClassificationProgress: () ->
    newState = _.assign {}, @data
    if newState.activeAssignment
      newState.activeAssignment.myClassificationCount++
  
  _getClassificationCount: (assignment, studentData) ->
    studentAssignments = assignment.relationships.student_assignments.data
    studentUsers = assignment.relationships.student_users.data
    classifications = 0
    studentAssignments.forEach (studentAssignmentsItem) ->
      studentDataByAssignment = studentData.find((item) ->
        item.id == studentAssignmentsItem.id
      )
      studentUsers.forEach (studentUsersItem) ->
        if studentUsersItem.id == studentDataByAssignment.attributes.student_user_id.toString()
          classifications = studentDataByAssignment.attributes.classifications_count
        return
      return
    classifications
  
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
        newState = _.assign {}, @data
        newState.active = true
        newState.assignments = newState.assignments.concat json.data.map (assignment) =>
          id: assignment.id
          workflowId: assignment.attributes.workflow_id
          name: assignment.attributes.name
          classificationTarget: assignment.attributes.metadata.classifications_target ? ''
          myClassificationCount: @_getClassificationCount(assignment, json.included)  
        @data = newState
        @trigger @data
        console.info 'assignments', @data
    .catch (err) =>
      @data.active = false
      console.error 'Error fetching assignments', err

