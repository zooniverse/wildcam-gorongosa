Reflux = require 'reflux'
classifierActions = require '../actions/classifier-actions'

module.exports = Reflux.createStore
  listenables: classifierActions

  data: []

  onMoveToNextSubject: ->
    @_clear()

  _clear: ->
    @data = []
    @trigger @data
