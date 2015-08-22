React = require 'react'
Router = {DefaultRoute, Route, NotFoundRoute} = require 'react-router'

module.exports =
  <Route name="root" path="/" handler={require './main'}>
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
