React = require 'react/addons'

counterpart = require 'counterpart'
Translate = require 'react-translate-component'
LoadingIndicator = require '../components/loading-indicator'
SlideTutorial = require '../components/slide-tutorial'
Task = require '../tasks/survey'

Reflux = require 'reflux'
classifyStore = require '../stores/classify-store'
classifyActions = require '../actions/classify-actions'

Summary = require '../partials/summary'

module.exports = React.createClass
  displayName: "Classify"
  mixins: [Reflux.listenTo(classifyStore, 'onClassificationData')]

  getInitialState: ->
    classificationData: classifyStore.data
    tutorialIsOpen: false
    onSummary: false

  componentDidMount: ->
    # Check specifically for null because setting prop as null if no user is returned. Avoids loading tutorial for the split second the props are undefined.
    # For logged in users with zero classifications, they will have null userPrefs
    # if !@props.user? || !@props.userPreferences
    #   @toggleTutorial()

  componentWillReceiveProps: (nextProps) ->
    # if nextProps.userPreferences?.activity_count is 0 or nextProps.userPreferences is null
    #   @toggleTutorial()
    # else if nextProps.user is null
    #   @toggleTutorial()

  toggleTutorial: ->
    @setState tutorialIsOpen: !@state.tutorialIsOpen

  onClassificationData: (data) ->
    @setState
      classificationData: data
      onSummary: false

  onChangeTask: ->
    console.log arguments

  onClickFinish: ->
    classifyActions.finishClassification()

    @setState
      onSummary: true

  onClickNextImage: ->
    classifyActions.getNextSubject()

  render: ->
    <div className="classify-page">
      {if @state.tutorialIsOpen
        <SlideTutorial closeTutorial={@toggleTutorial} tutorialIsOpen={@state.tutorialIsOpen} />}

      <div className="classification">
        <section className="subject">
          {if @state.classificationData?.classification?
            <img src={@state.classificationData.subject?.locations[0]['image/jpeg']} />
          else
            <div className="loading-indicator-container">
              <LoadingIndicator />
            </div>}
        </section>

        <section className="task-container">
          {if @state.classificationData
            if @state.onSummary
              <div>
                <Summary annotations={@state.classificationData.classification.annotations} />
                <div className="workflow-buttons-container">
                  <button type="button" className="action-button" onClick={@onClickNextImage}>Next Image</button>
                </div>
              </div>
            else
              <div>
                <Task
                  {...@props}
                  task={@state.classificationData.workflow.tasks['T1']}
                  annotation={@state.classificationData.classification.annotations}
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
