React = require 'react/addons'
UserStore = require '../stores/user-store'
ZooniverseLogo = require './zooniverse-logo'

Translate = require 'react-translate-component'
counterpart = require 'counterpart'

counterpart.registerTranslations 'en',
  loginBar:
    signIn: 'Sign in'

module.exports = React.createClass
  displayName: 'LoginBar'

  render: ->
    <div className="login-bar">
      <a className="main-header-link" href={UserStore.signInUrl()}><Translate content="loginBar.signIn" /></a>
    </div>
