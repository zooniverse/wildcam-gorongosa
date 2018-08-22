React = require 'react/addons'

UserStore = require '../stores/user-store'
ZooniverseLogo = require './zooniverse-logo'

Translate = require 'react-translate-component'
counterpart = require 'counterpart'

counterpart.registerTranslations 'en',
  loginBar:
    signIn: 'Sign in/Sign Up'

module.exports = React.createClass
  displayName: 'LoginBar'

  render: ->
    <div className="login-bar">
      <a className="main-header-link" href="#" onClick={UserStore.doSignIn}><Translate content="loginBar.signIn" /></a>
    </div>
