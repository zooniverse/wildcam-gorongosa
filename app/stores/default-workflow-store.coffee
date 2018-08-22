Reflux = require 'reflux'
api = require 'panoptes-client/lib/api-client'
config = require '../lib/config'

module.exports = Reflux.createStore
  data: null

  init: ->
    api.type('workflows').get(config.workflowId)
      .then (@data) =>
        @trigger @data

  getInitialState: ->
    @data