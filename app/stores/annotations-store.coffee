Reflux = require 'reflux'
annotationActions = require '../actions/annotation-actions'

module.exports = Reflux.createStore
  listenables: annotationActions

  data: []

  init: ->
    @create()

  create: ->
    @data = []
    @trigger @data

  update: (key) ->
    for annotation, i in @data
      if annotation.key is key
        @data[i] = annotation
        break

    @trigger @data

  clear: ->
    @data = []
    @trigger @data
