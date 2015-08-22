React = require 'react/addons'
Router = require 'react-router'
{api} = client = require './api/client'

Main = require './main'
routes = require './routes'

Router.run routes, (Root) ->
  React.render <Root />, document.getElementById("app")

window.React = React
window.api = api
