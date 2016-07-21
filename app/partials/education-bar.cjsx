React = require 'react'
Reflux = require 'reflux'

assignmentsStore = require '../stores/assignments-store'
assignmentActions = require '../actions/assignment-actions'

module.exports = React.createClass
  displayName: 'EducationBar'
  mixins: [
    Reflux.connect assignmentsStore, 'assignments'
  ]

  changeAssignment: (event) ->
    assignmentActions.setAssignment event.target.value

  renderEducationBar: ->
    <div className="education-bar">
      <h4>Wildcam Labs</h4>
      <p>You're working on:</p>
      <select onChange={ @changeAssignment } value={ @state.assignments.activeAssignment.id }>
        { @state.assignments.assignments.map (assignment) =>
          <option key={ assignment.id } value={ assignment.id }>
            { assignment.name }
          </option>
        }
      </select>
    </div>

  render: ->
    if @state.assignments.active
      @renderEducationBar()
    else
      null
