React = require 'react/addons'
Router = require 'react-router'
{Route, RouteHandler, DefaultRoute, Link} = require 'react-router'
Reflux = require 'reflux'
projectConfig = require './lib/config'
{api} = client = require './api/client'

projectStore = require './stores/project-store'
userStore = require './stores/user-store'

MainHeader = require './partials/main-header'
MainFooter = require './partials/main-footer'

Main = React.createClass
  displayName: "Main"
  mixins: [Reflux.connect(userStore, 'userData')]

  getIntitalState:
    project: null

  render: ->
    user = unless @state.userData is null then @state.userData?.user else null
    userPreferences = unless @state.userData is null then @state.userData?.projectPreferences else null

    <div className="main">
      <MainHeader user={user} />
      <RouteHandler user={user} userPreferences={@state.userData?.projectPreferences} />
      <MainFooter />
    </div>

routes =
  <Route name="root" path="/" handler={Main}>
    <DefaultRoute handler={require './pages/home'} />
    <Route name="classify" path="classify" handler={require './pages/classify'} />
    <Route name="about" path="about" handler={require './pages/about'} />
    <Route name="field-guide" path="field-guide" handler={require './pages/field-guide'}>
      <Route name="field-guide-entry" path=":entryName" handler={require './partials/field-guide-entry'} />
    </Route>
  </Route>

Router.run routes, (Handler) ->
  React.render <Handler />, document.getElementById("app")

window.React = React
window.api = api
