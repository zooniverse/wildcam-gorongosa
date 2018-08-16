React = require 'react/addons'
Router = require 'react-router'
{ config } = require './api/config'

oauth = require 'panoptes-client/lib/oauth'
# client = require 'panoptes-client/lib/api-client'
# {api, oauth, PANOPTES_APP_ID} = client = require './api/client'

Main = require './main'
routes = require './routes'

appActions = require './actions/app-actions'
require './stores/app-store' # Needs to be required somewhere

oauth.init(config.panoptesAppId)
  .then (response) ->
    Router.run routes, (Root, state) ->
      appActions.routeChange state
      React.render <Root />, document.getElementById('app')

window.React = React
# window.api = client
