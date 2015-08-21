React = require 'react'
counterpart = require 'counterpart'
Translate = require 'react-translate-component'

counterpart.registerTranslations 'en',
  notFoundPage:
    header: 'Page Not Found'
    text: 'Sorry, the page you were looking for was not found. Try one of the links above.'

module.exports = React.createClass
  statics:
    willTransitionTo: (transition, query, params) ->
      if transition.path.charAt(transition.path.length - 1) == '/'
        newPath = transition.path.slice 0, transition.path.length - 1
        transition.redirect newPath, query, params
      else if transition.path.indexOf('access_token') > -1 # Catches login token redirect
        transition.redirect '/'

  render: ->
    <div className="secondary-page">
      <Translate component="h1" content="notFoundPage.header" />
      <Translate component="p" content="notFoundPage.text" />
    </div>
