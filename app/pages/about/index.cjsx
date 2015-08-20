React = require 'react'
Router = {Link, RouteHandler} = require 'react-router'

subPages = [
  require './default'
  require './team'
  require './organizations'
]

coolImages = [
  'assets/about/cool-image-1.jpg'
  'assets/about/cool-image-2.jpg'
  'assets/about/cool-image-3.jpg'
]

module.exports = React.createClass
  displayName: 'AboutContainer'
  mixins: [Router.State]

  getCurrentSubPageDisplayName: ->
    routeContext = @getRoutes()
    routeContext[routeContext.length - 1].handler.displayName

  render: ->
    # Really shouldn't hardcode the depth here
    routeContext = @getRoutes()
    currentContext = routeContext[routeContext.length - 2]
    subPagesLinks = currentContext.childRoutes.map (childRoute, i) ->
      <Link key={i} to={childRoute.name}>{childRoute.handler.displayName}</Link>

    subPageDisplayName = @getCurrentSubPageDisplayName()

    randomIndex = Math.floor Math.random() * coolImages.length
    heroStyle = backgroundImage: "url(#{ coolImages[0] })"

    <div className="secondary-page">
      <div className="secondary-page-hero" style={heroStyle}>
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
    </div>
