React = require 'react'
Router = {Link, RouteHandler} = require 'react-router'
_ = require 'lodash'

ProjectMetadata = require '../../partials/project-metadata'

module.exports = React.createClass
  displayName: 'AboutPageController'
  mixins: [Router.State]

  getCurrentSubPageDisplayName: ->
    routeContext = @getRoutes()
    routeContext[routeContext.length - 1].handler.displayName

  getCurrentRoute: ->
    _.find @getRoutes(), (route) =>
      @.constructor is route.handler

  render: ->
    subPagesLinks = @getCurrentRoute().childRoutes.map (childRoute, i) ->
      <Link key={i} to={childRoute.name}>{childRoute.handler.displayName}</Link>

    subPageDisplayName = @getCurrentSubPageDisplayName()

    <div className="secondary-page">
      <div className="secondary-page-hero">
        <div className="secondary-page-container">
          <div className="secondary-page-hero-title">{subPageDisplayName}</div>
        </div>
      </div>
      <div className="secondary-page-menu">
        <div className="secondary-page-container">
          {subPagesLinks}
        </div>
      </div>
      <div className="secondary-page-content">
        <div className="secondary-page-container">
          <RouteHandler {...@props} />
        </div>
      </div>
      <ProjectMetadata />
    </div>
