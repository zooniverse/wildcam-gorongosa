Reflux = require 'reflux'

classifierActions = require '../actions/classifier-actions'
taskActions = require '../actions/task-actions'

module.exports = Reflux.createStore
  listenables: [classifierActions, taskActions]

  data:
    choice: ''
    filters: {}

  getInitialState: ->
    @data

  _clearFilters: ->
    @data.filters = {}

  _clearSelection: ->
    @data.choice = ''

  # Listenables
  onAddFilter: (characteristicID, valueID) ->
    @data.filters[characteristicID] = valueID
    @trigger @data

  onRemoveFilter: (characteristicID) ->
    delete @data.filters[characteristicID]
    @trigger @data

  onClearFilters: ->
    @_clearFilters()
    @trigger @data

  onSelectChoice: (choiceID) ->
    @data.choice = choiceID
    @trigger @data

  onClearSelection: ->
    @_clearSelection()
    @trigger @data

  onAnnotate: ->
    @_clearSelection()
    @_clearFilters()
    @trigger @data
