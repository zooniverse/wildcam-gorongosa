Reflux = require 'reflux'

module.exports = Reflux.createStore
  listenables: require '../actions/classifier-actions'

  data:
    showingSummary: false
    shownTutorial: false

  onFinishClassification: ->
    @data.showingSummary = true
    @trigger @data

  onMoveToNextSubject: ->
    @data.showingSummary = false
    @trigger @data
