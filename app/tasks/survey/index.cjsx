React = require 'react'
Reflux = require 'reflux'

Summary = require './summary'
Chooser = require './chooser'
Choice = require './choice'
AnnotationView = require './annotation-view'

classifierActions = require '../../actions/classifier-actions'
taskActions = require '../../actions/task-actions'

taskStore = require '../../stores/task-store'

module.exports = React.createClass
  displayName: 'SurveyTask'
  mixins: [
    Reflux.connect taskStore
  ]

  statics:
    Summary: Summary
    AfterSubject: AnnotationView

    getDefaultTask: ->
      type: 'survey'
      characteristicsOrder: []
      characteristics: {}
      choicesOrder: []
      choices: {}
      questionsOrder: []
      questions: {}
      images: {}

    getTaskText: (task) ->
      "Survey of #{task.choicesOrder.length} choices"

    getDefaultAnnotation: ->
      value: []

    isAnnotationComplete: (task, annotation) ->
      # Booleans compare to numbers as expected: true = 1, false = 0.
      annotation.value.length >= (task.required ? 0) and not @props.choiceInProgress

  getDefaultProps: ->
    annotations: null
    onChange: Function.prototype
    choiceInProgress: false
    filters: {}

  handleFilter: (characteristicID, valueID) ->
    if valueID?
      taskActions.addFilter characteristicID, valueID
    else
      taskActions.removeFilter characteristicID

  handleChoice: (choiceID) ->
    taskActions.selectChoice choiceID

  removeChoice: (choiceID) ->
    classifierActions.removeAnnotation choiceID

  clearFilters: ->
    taskActions.clearFilters()

  clearSelection: ->
    taskActions.clearSelection()

  handleAnnotation: (choice, answers, e) ->
    filters = JSON.parse JSON.stringify @state.filters

    classifierActions.annotate {choice, answers, filters}

  render: ->
    <div className="survey-task">
      {if @state.choice is ''
        <Chooser task={@props.task} filters={@state.filters} onFilter={@handleFilter} onChoose={@handleChoice} onRemoveChoice={@removeChoice} annotations={@props.annotations} />
      else
        existingAnnotation = _.find(@props.annotations, 'choice', @state.choice) || {}
        <Choice task={@props.task} choiceID={@state.choice} onSwitch={@handleChoice} onCancel={@clearSelection} onConfirm={@handleAnnotation} annotation={existingAnnotation} />}
    </div>
