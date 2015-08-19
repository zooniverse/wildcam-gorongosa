React = require 'react'
{Link} = require 'react-router'
counterpart = require 'counterpart'
Translate = require 'react-translate-component'
userActions = require '../actions/user-actions'
userStore = require '../stores/user-store'

counterpart.registerTranslations 'en',
  accountMenu:
    profile: 'Profile'
    settings: 'Settings'
    signOut: 'Sign Out'
    collections: 'Collections'
    close: 'Close'

module.exports = React.createClass
  displayName: 'AccountBar'

  getInitialState: ->
    avatar: null

  componentDidMount: ->
    if @props.user?
      userStore.getUserAvatar(@props.user).then (avatar) =>
        @setState avatar: avatar.src if avatar

  componentWillReceiveProps: (nextProps) ->
    if nextProps.user is null
      @setState avatar: null

  handleSignOutClick: ->
    userActions.signOut()

  render: ->
    <div className="account-bar">
      <div className="account-info">
        <span className="display-name"><strong>{@props.user.display_name}</strong></span>
        <img className="account-avatar" src={if @state.avatar? then @state.avatar else './assets/simple-avatar.jpg'} alt="user avatar" />
      </div>
      <button className="secret-button sign-out-button" type="button" onClick={@handleSignOutClick}>
        <Translate content="accountMenu.signOut" />
      </button>
    </div>
