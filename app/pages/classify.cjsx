React = require 'react/addons'
Reflux = require 'reflux'
counterpart = require 'counterpart'
Translate = require 'react-translate-component'

LoadingIndicator = require '../components/loading-indicator'
SlideTutorial = require '../components/slide-tutorial'

annotationsStore = require '../stores/annotations-store'
classificationStore = require '../stores/classification-store'
subjectStore = require '../stores/subject-store'
workflowStore = require '../stores/workflow-store'

annotationActions = require '../actions/annotation-actions'
classifierActions = require '../actions/classifier-actions'

Task = require '../tasks/survey'
Summary = require '../tasks/survey/summary'

module.exports = React.createClass
  displayName: "Classify"
  mixins: [
    Reflux.connect(annotationsStore, 'annotations')
    Reflux.connect(classificationStore, 'classification')
    Reflux.connect(subjectStore, 'subject')
    Reflux.connect workflowStore, 'workflow'
  ]

  getInitialState: ->
    annotations: annotationsStore.data
    classification: classificationStore.data
    workflow: workflowStore.data
    subject: subjectStore.data
    tutorialIsOpen: false
    onSummary: false

  componentDidMount: ->
    # Check specifically for null because setting prop as null if no user is returned. Avoids loading tutorial for the split second the props are undefined.
    # For logged in users with zero classifications, they will have null userPrefs
    if @props.user is null || @props.userPreferences is null
      @toggleTutorial()

  componentWillReceiveProps: (nextProps) ->
    if nextProps.userPreferences?.activity_count is 0 or nextProps.userPreferences is null
      @toggleTutorial()
    else if nextProps.user is null
      @toggleTutorial()

  componentWillUpdate: (nextProps, nextState) ->
    if nextState.subject isnt @state.subject
      annotationActions.clear()

  toggleTutorial: ->
    @setState tutorialIsOpen: !@state.tutorialIsOpen

  onClassificationData: (data) ->
    @setState onSummary: false

  onChangeTask: ->
    console.log 'task changed', arguments

  onClickFinish: ->
    classifierActions.finishClassification()

    @setState onSummary: true

  onClickNextImage: ->
    classifierActions.moveToNextSubject()

    @setState onSummary: false

  onClickMetadata: ->
    console.log 'clicky'

  render: ->
    <div className="classify-page">
      {if @state.tutorialIsOpen
        <SlideTutorial closeTutorial={@toggleTutorial} tutorialIsOpen={@state.tutorialIsOpen} />}

      <div className="classification">
        <section className="subject">
          <p className="classifier-tagline">You're now tracking the wildlife of Gorongosa National Park</p>
          {if @state.subject
            <img src={@state.subject.locations[0]['image/jpeg']} />
          else
            <div className="loading-indicator-container">
              <LoadingIndicator />
            </div>}
          <div className="subject-toolbar">
            <button className="metadata-button" type="button" onClick={@onClickMetadata}><i className="fa fa-info"></i></button>
          </div>
        </section>

        <section className="task-container">
          {if @state.subject && @state.classification && @state.annotations && @state.workflow
            if @state.onSummary
              <div>
                <Summary annotations={@state.annotations} task={@state.workflow.tasks[@state.workflow.first_task]} expanded={true} />
                <div className="workflow-buttons-container">
                  <button type="button" className="action-button" onClick={@onClickNextImage}>Next Image</button>
                </div>
              </div>
            else
              <div className="survey-task-container">
                <Task
                  {...@props}
                  task={@state.workflow.tasks[@state.workflow.first_task]}
                  annotation={@state.annotations}
                  onChange={@onChangeTask}
                />

                <div className="workflow-buttons-container">
                  <button type="button" className="action-button" onClick={@onClickFinish}>Finish</button>
                </div>
              </div>
          else
            <div className="loading-indicator-container">
              <LoadingIndicator />
            </div>}
        </section>
      </div>
    </div>
