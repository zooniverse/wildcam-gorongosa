Reflux = require 'reflux'

module.exports = Reflux.createStore
  listenables: require '../actions/classifier-actions'

  data:
    showingSummary: false
    shownTutorial: false
    tutorialIsOpen: false

  getInitialState: ->
    @data

  onDisplayTutorial: ->
    @data.tutorialIsOpen = true
    @trigger @data

  onCloseTutorial: ->
    @data.tutorialIsOpen = false
    @data.shownTutorial = true
    @trigger @data

  onFinishClassification: ->
    @data.showingSummary = true
    @trigger @data

  onMoveToNextSubject: ->
    @data.showingSummary = false
    @trigger @data
