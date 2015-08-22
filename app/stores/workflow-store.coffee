Reflux = require 'reflux'
{api} = require '../api/client'
config = require '../lib/config'

module.exports = Reflux.createStore
  data: null

  init: ->
    api.type('workflows').get(config.workflowId).then (@data) =>
      @trigger @data

  getInitialState: ->
    @data
