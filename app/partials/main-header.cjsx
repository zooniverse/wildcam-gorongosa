React = require 'react/addons'
ZooniverseLogo = require './zooniverse-logo'
LoginBar = require './login-bar'
AccountBar = require './account-bar'
Translate = require 'react-translate-component'
counterpart = require 'counterpart'
{Link} = require 'react-router'

counterpart.registerTranslations 'en',
  mainHeader:
    title: 'WildCam Gorongosa'
    links:
      about: 'About'
      classify: 'Start'
      fieldGuide: 'Field Guide'
      talk: 'Talk'
      blog: 'Blog'

module.exports = React.createClass
  displayName: 'MainHeader'

  componentDidMount: ->
    if window.innerWidth <= 768
      window.onhashchange = @onHashChange

  onHashChange: ->
    mainHeaderNav = React.findDOMNode(@refs.mainHeaderNav)

    if mainHeaderNav.classList.contains 'show-menu'
      @toggleMenu()

  toggleMenu: ->
    mainHeaderNav = React.findDOMNode(@refs.mainHeaderNav)
    mobileButtonIcon = React.findDOMNode(@refs.mobileButtonIcon)
    mobileMenuButton = React.findDOMNode(@refs.mobileMenuButton)
    closeButtonTitle = React.findDOMNode(@refs.closeButtonTitle)

    mainHeaderNav.classList.toggle 'show-menu'

    if mainHeaderNav.classList.contains 'show-menu'
      mobileButtonIcon.src = "./assets/ex-icon.svg"
      mobileMenuButton.classList.add 'close-button'
      closeButtonTitle.style.display = 'inline-block'
    else
      mobileButtonIcon.src = "./assets/mobile-menu.svg"
      mobileMenuButton.classList.remove 'close-button'
      closeButtonTitle.style.display = 'none'

    return null # to get rid of the annoying react warning

  render: ->
    <header className="main-header">
      <div className="main-header-title-container">
        <Link className="main-header-title-link" to="root">
          <img className="main-header-logo" src="assets/small-logo.png" />
        </Link>
      </div>
      <nav ref="mainHeaderNav" className="main-header-nav">
        <div className="main-header-nav-link-container">
          <Link to="classify" className="main-header-link"><Translate content="mainHeader.links.classify" /></Link>
          <Link to="about" className="main-header-link"><Translate content="mainHeader.links.about" /></Link>
          <Link to="field-guide" className="main-header-link"><Translate content="mainHeader.links.fieldGuide" /></Link>
          <a className="main-header-link" href="https://www.zooniverse.org/#/projects/zooniverse/wildcam-gorongosa/talk" target="_blank"><Translate content="mainHeader.links.talk" /></a>
          <a className="main-header-link" href="http://blog.wildcamgorongosa.org" target="_blank"><Translate content="mainHeader.links.blog" /></a>
        </div>
        {if @props.user
          <AccountBar user={@props.user} />
        else
          <LoginBar project={@props.project} />}
      </nav>
      <span ref="closeButtonTitle" className="close-button-title"><Translate content="accountMenu.close"/></span>
      <button ref="mobileMenuButton" className="mobile-menu-button" type="button" onClick={@toggleMenu}>
        <img ref="mobileButtonIcon" className="menu-icon" src="./assets/mobile-menu.svg" alt="menu" />
      </button>
    </header>
