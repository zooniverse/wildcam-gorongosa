React = require 'react'
counterpart = require 'counterpart'
Translate = require 'react-translate-component'
{Markdown} = require 'markdownz'
{Link} = require 'react-router'

ProjectMetadata = require '../partials/project-metadata'

counterpart.registerTranslations 'en',
  homePage:
    hero:
      tagline: 'Help contribute to an amazing wildlife comeback story!'
      overview: '''
      Gorongosa National Park in Mozambique was once among the most diverse places on earth, until decades of war decimated the park’s large animal populations. Now, an international conservation effort is working to restore the park’s wildlife— we need you to help document this incredible recovery. Join us in identifying Gorongosa’s animals in trail camera photos and become part of our conservation team!
      '''
    learnMore: 'Learn More'
    getStarted: 'Get Started!'
    callToAction:
      header: '''Ready to get involved?'''
      button: '''Get Started'''
    organizationCredit: 'WildCam Gorongosa was made in partnership with the Howard Hughes Medical Institute Biointeractive Initiative'

module.exports = React.createClass
  displayName: "Home"

  render: ->
    <div className="home-page">
      <section className="home-hero">
        <div className="home-hero-background" />
        <div className="home-content-container">
          <img src="assets/logo-white.png" className="logo" alt="WildCam Gorongosa" />
          <Translate component="div" className="tagline" content="homePage.hero.tagline" />

          <Link to="classify" className="home-call-to-action-button"><Translate content="homePage.getStarted" /></Link>
          <Link to="about" className="home-call-to-action-button ghost-button"><Translate content="homePage.learnMore" /></Link>

          <Translate component="div" className="overview" content="homePage.hero.overview" />
        </div>
      </section>
      <ProjectMetadata />
      <section className="home-organization-credit">
        <div className="home-organization-credit-container">
          <img className="hhmi-logo" src="./assets/hhmi-logo-long.png" alt="HHMI BioInteractive" />
          <Translate className="hhmi-credit" component="p" content="homePage.organizationCredit" />
        </div>
      </section>
    </div>
