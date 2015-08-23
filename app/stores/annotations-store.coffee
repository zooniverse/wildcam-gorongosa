Reflux = require 'reflux'
classifierActions = require '../actions/classifier-actions'

module.exports = Reflux.createStore
  listenables: classifierActions

  data: []

  getInitialState: ->
    @data

  onAnnotate: (annotation) ->
    @data.push annotation
    @trigger @data

  onMoveToNextSubject: ->
    @_clear()

  _clear: ->
    @data = []
    @trigger @data
