React = require 'react'
Reflux = require 'reflux'

assignmentsStore = require '../stores/assignments-store'
workflowActions = require '../actions/workflow-actions'

module.exports = React.createClass
  displayName: 'EducationBar'
  mixins: [
    Reflux.connect assignmentsStore, 'assignments'
  ]

  changeWorkflow: (event) ->
    workflowId = event.target.value || null
    workflowActions.setWorkflow workflowId

  renderEducationBar: ->
    <div className="education-bar">
      <h4>Wildcam Labs</h4>
      <p>You're working on:</p>
      <select onChange={ @changeWorkflow }>
        <option value="">No assignment</option>
        { @state.assignments.assignments.map (assignment) ->
          <option key={ assignment.id } value={ assignment.attributes.workflow_id }>
            { assignment.attributes.name }
          </option>
        }
      </select>
    </div>

  render: ->
    if @state.assignments.active
      @renderEducationBar()
    else
      null
