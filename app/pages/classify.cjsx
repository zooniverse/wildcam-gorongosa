React = require 'react/addons'
Reflux = require 'reflux'
counterpart = require 'counterpart'
Translate = require 'react-translate-component'

LoadingIndicator = require '../components/loading-indicator'
SlideTutorial = require '../components/slide-tutorial'

annotationsStore = require '../stores/annotations-store'
classifierStore = require '../stores/classifier-store'
subjectStore = require '../stores/subject-store'
workflowStore = require '../stores/workflow-store'

classifierActions = require '../actions/classifier-actions'

Task = require '../tasks/survey'
Summary = require '../tasks/survey/summary'

module.exports = React.createClass
  displayName: "Classify"
  mixins: [
    Reflux.connect annotationsStore, 'annotations'
    Reflux.connect classifierStore
    Reflux.connect subjectStore, 'subject'
    Reflux.connect workflowStore, 'workflow'
  ]

  getInitialState: ->
    annotations: annotationsStore.data
    workflow: workflowStore.data
    subject: subjectStore.data
    showingSummary: classifierStore.data.showingSummary
    shownTutorial: classifierStore.data.shownTutorial
    tutorialIsOpen: classifierStore.data.tutorialIsOpen

  componentDidMount: ->
    # Check specifically for null because setting prop as null if no user is returned. Avoids loading tutorial for the split second the props are undefined.
    # For logged in users with zero classifications, they will have null userPrefs
    if @props.user is null || @props.userPreferences is null
      classifierActions.displayTutorial()

  componentWillReceiveProps: (nextProps) ->
    if nextProps.userPreferences?.activity_count is 0 or nextProps.userPreferences is null
      classifierActions.displayTutorial()
    else if nextProps.user is null
      classifierActions.displayTutorial()

  closeTutorial: ->
    classifierActions.closeTutorial()

  onChangeTask: ->
    if @state.annotations._choiceInProgress? and @state.annotations._choiceInProgress is true
      React.findDOMNode(@refs.workflowButtonsContainer).style.display = 'none'
    else
      React.findDOMNode(@refs.workflowButtonsContainer).style.display = 'flex'

  onClickFinish: ->
    classifierActions.finishClassification()

  onClickNextImage: ->
    classifierActions.moveToNextSubject()

  onClickMetadata: ->
    console.log 'clicky'

  render: ->
    <div className="classify-page">
      {if @state.tutorialIsOpen and not @state.shownTutorial
        <SlideTutorial closeTutorial={@closeTutorial} tutorialIsOpen={@state.tutorialIsOpen} />}

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
          {if @state.subject and @state.annotations and @state.workflow
            if @state.showingSummary
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

                <div ref="workflowButtonsContainer" className="workflow-buttons-container">
                  <button type="button" className="action-button" onClick={@onClickFinish}>Done</button>
                </div>
              </div>
          else
            <div className="loading-indicator-container">
              <LoadingIndicator />
            </div>}
        </section>
      </div>
      <div className="metadata-container">
        <p>metadata placeholder</p>
      </div>
    </div>
