React = require 'react'
Reflux = require 'reflux'
RefluxPromise = require 'reflux-promise'
{RouteHandler} = require 'react-router'

userStore = require './stores/user-store'

MainHeader = require './partials/main-header'
MainFooter = require './partials/main-footer'

Reflux.use(RefluxPromise(window.Promise))

module.exports = React.createClass
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
