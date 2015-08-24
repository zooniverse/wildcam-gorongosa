React = require 'react'
Summary = require './summary'
Chooser = require './chooser'
Choice = require './choice'
AnnotationView = require './annotation-view'

module.exports = React.createClass
  displayName: 'SurveyTask'

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
      annotation.value.length >= (task.required ? 0) and not annotation._choiceInProgress

  getDefaultProps: ->
    task: null
    annotation: null
    onChange: Function.prototype

  getInitialState: ->
    filters: {}
    selectedChoiceID: ''

  handleFilter: (characteristicID, valueID) ->
    if valueID?
      @state.filters[characteristicID] = valueID
    else
      delete @state.filters[characteristicID]
    @setState filters: @state.filters

  handleChoice: (choiceID) ->
    @props.annotation._choiceInProgress = true
    @setState selectedChoiceID: choiceID
    @props.onChange()

  clearFilters: ->
    @setState filters: {}

  clearSelection: ->
    @props.annotation._choiceInProgress = false
    @setState selectedChoiceID: ''
    @props.onChange()

  handleAnnotation: (choice, answers, e) ->
    filters = JSON.parse JSON.stringify @state.filters

    @props.annotation.push {task: @props.task.type, value: []} if @props.annotation.length is 0
    @props.annotation[0].value ?= []
    @props.annotation[0].value.push {choice, answers, filters}
    @props.onChange e

    @clearFilters()
    @clearSelection()

  render: ->
    <div className="survey-task">
      {if @state.selectedChoiceID is ''
        <Chooser task={@props.task} filters={@state.filters} onFilter={@handleFilter} onChoose={@handleChoice} annotation={@props.annotation} />
      else
        <Choice task={@props.task} choiceID={@state.selectedChoiceID} onSwitch={@handleChoice} onCancel={@clearSelection} onConfirm={@handleAnnotation} />}
    </div>
