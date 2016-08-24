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
      {@renderMyClassificationsCount()}
    </div>

  render: ->
    if @state.assignments.active
      @renderEducationBar()
    else
      null

  renderMyClassificationsCount: ->
    htmlCounter = null
    if @state.assignments.activeAssignment && @state.assignments.activeAssignment.id != '0'
      classificationTarget = parseInt(@state.assignments.activeAssignment.classificationTarget)
      classificationTarget = 0 if isNaN(classificationTarget)
      myClassificationCount = @state.assignments.activeAssignment.myClassificationCount
      
      if classificationTarget isnt 0 and myClassificationCount < classificationTarget
        htmlCounter =
          <div className="my-classifications">
            <label>Progress:</label>
            <span>{myClassificationCount} / {classificationTarget}</span>
          </div>
      else
        htmlCounter =
          <div className="my-classifications done">You're done!</div>
    
    return htmlCounter
