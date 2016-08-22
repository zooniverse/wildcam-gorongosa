Reflux = require 'reflux'
{api} = require '../api/client'
config = require '../lib/config'



module.exports = Reflux.createStore
  data: null

  init: ->
    api.type('workflows').get(config.workflowId)
      .then (@data) =>
        console.warn "Default workflow #{@data.id}"
        @trigger @data

  getInitialState: ->
    @data