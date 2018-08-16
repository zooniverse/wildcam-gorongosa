React = require 'react/addons'
Router = require 'react-router'
{api, oauth, PANOPTES_APP_ID} = client = require './api/client'

Main = require './main'
routes = require './routes'

appActions = require './actions/app-actions'
require './stores/app-store' # Needs to be required somewhere

oauth.init(PANOPTES_APP_ID)
  .then (response) ->
    Router.run routes, (Root, state) ->
      appActions.routeChange state
      React.render <Root />, document.getElementById('app')

window.React = React
window.api = api
