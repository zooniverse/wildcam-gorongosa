Reflux = require 'reflux'

classificationStore = require '../stores/classification-store'

module.exports = Reflux.createStore
  listenables: [
    require '../actions/classifier-actions'
    require '../actions/task-actions'
  ]

  data:
    showingSummary: false
    shownTutorial: false
    tutorialIsOpen: false
    choiceInProgress: false

  getInitialState: ->
    @data

  onDisplayTutorial: ->
    @data.tutorialIsOpen = true
    @trigger @data

  onReviewTutorial: ->
    @data.tutorialIsOpen = true
    @data.shownTutorial = false
    @trigger @data

  onCloseTutorial: ->
    @data.tutorialIsOpen = false
    @data.shownTutorial = true
    @trigger @data

  onFinishClassification: ->
    classificationStore.finish()
    @data.showingSummary = true
    @trigger @data

  onMoveToNextSubject: ->
    @data.showingSummary = false
    @trigger @data
