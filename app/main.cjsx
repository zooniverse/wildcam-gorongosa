React = require 'react/addons'
Router = require 'react-router'
{Route, RouteHandler, DefaultRoute, NotFoundRoute, Link} = require 'react-router'
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

    <div className="main">
      <MainHeader user={user} />
      <RouteHandler user={user} userPreferences={@state.userData?.projectPreferences} />
      <MainFooter />
    </div>

routes =
  <Route name="root" path="/" handler={Main}>
    <DefaultRoute handler={require './pages/home'} />
    <Route name="classify" path="classify" handler={require './pages/classify'} />
    <Route name="about-page-controller" path="about" handler={require './pages/about'}>
      <DefaultRoute name="about" handler={require './pages/about/default'} />
      <Route name="team" path="team" handler={require './pages/about/team'} />
      <Route name="organizations" path="organizations" handler={require './pages/about/organizations'} />
    </Route>
    <Route name="field-guide" path="field-guide" handler={require './pages/field-guide'}>
      <Route name="field-guide-choice" path=":choice" handler={require './partials/field-guide-choice'} />
    </Route>

    <NotFoundRoute handler={require './pages/not-found'} />
  </Route>

Router.run routes, (Root) ->
  React.render <Root />, document.getElementById("app")

window.React = React
window.api = api
