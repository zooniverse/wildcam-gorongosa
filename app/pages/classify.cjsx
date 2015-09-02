React = require 'react/addons'
Reflux = require 'reflux'
counterpart = require 'counterpart'
Translate = require 'react-translate-component'
{Markdown} = require 'markdownz'
alert = require '../lib/alert'

ProjectMetadata = require '../partials/project-metadata'
LoadingIndicator = require '../components/loading-indicator'
SlideTutorial = require '../components/slide-tutorial'
FavoritesButton = require '../components/favorites-button'

annotationsStore = require '../stores/annotations-store'
classifierStore = require '../stores/classifier-store'
subjectStore = require '../stores/subject-store'
workflowStore = require '../stores/workflow-store'
taskStore = require '../stores/task-store'

classifierActions = require '../actions/classifier-actions'

Task = require '../tasks/survey'
Summary = require '../partials/summary'

module.exports = React.createClass
  displayName: "Classify"
  mixins: [
    Reflux.connect annotationsStore, 'annotations'
    Reflux.connect classifierStore
    Reflux.connect taskStore
    Reflux.connect subjectStore, 'subject'
    Reflux.connect workflowStore, 'workflow'
  ]

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

  onClickFinish: ->
    classifierActions.finishClassification()

  onClickNextImage: ->
    classifierActions.moveToNextSubject()

  onClickMetadata: ->
    alert <div className="metadata-dialog-container">
      <header className="metadata-dialog-label" style={textAlign: 'center'}>Subject metadata</header>
      <hr />
      <table className="standard-table">
        {for key, value of @state.subject?.metadata
          <tr key={key}>
            <th>{key}</th>
            <Markdown tag="td" content={value} inline />
          </tr>}
      </table>
    </div>

  onClickTutorial: ->
    classifierActions.reviewTutorial()

  render: ->
    <div className="classify-page">
      {if @state.tutorialIsOpen and not @state.shownTutorial
        <SlideTutorial closeTutorial={@closeTutorial} tutorialIsOpen={@state.tutorialIsOpen} />}

      <div className="classification" style={if @state.subject?.srcWidth <= 666 then maxWidth: "1200px"}>
        <section className="subject">
          <p className="classifier-tagline">You're now tracking the wildlife of Gorongosa National Park</p>
          {if @state.subject
            <img src={@state.subject.locations[0]['image/jpeg']} />
          else
            <div className="loading-indicator-container">
              <LoadingIndicator />
            </div>}
          <div ref="subjectToolBar" className="subject-toolbar" style={maxWidth: @state.subject?.srcWidth}>
            <FavoritesButton user={@props.user} />
            <button className="tutorial-button" title="Tutorial" type="button" onClick={@onClickTutorial}><i className="fa fa-question"></i></button>
            <button className="metadata-button" title="Metadata" type="button" onClick={@onClickMetadata}><i className="fa fa-info"></i></button>
          </div>
        </section>

        <section className="task-container">
          {if @state.subject and @state.annotations and @state.workflow
            if @state.showingSummary
              <div className="task-summary-container">
                <Summary annotations={@state.annotations} workflow={@state.workflow} subject={@state.subject} />
                <div className="workflow-buttons-container">
                  <button type="button" className="action-button" onClick={@onClickNextImage}>Next Image</button>
                </div>
              </div>
            else
              <div className="survey-task-container">
                <Task
                  {...@props}
                  task={@state.workflow.tasks[@state.workflow.first_task]}
                  annotations={@state.annotations}
                  filters={@state.filters}
                  choice={@state.choice}
                />

                {if @state.choice is ''
                  finishDisabledCondition = @state.annotations.length is 0
                  <div ref="workflowButtonsContainer" className="workflow-buttons-container">
                    <button type="button" className="action-button" disabled={finishDisabledCondition} onClick={@onClickFinish}>Done</button>
                  </div>}
              </div>
          else
            <div className="loading-indicator-container">
              <LoadingIndicator />
            </div>}
        </section>
      </div>
      <ProjectMetadata />
    </div>
