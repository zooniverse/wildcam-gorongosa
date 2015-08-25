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
        Gorongosa National Park in Mozambique, one of the world’s most diverse ecosystems, was once devastated by decades of civil war. Now, thanks to an international effort, the park is finally coming back to life—and we need you to help document this incredible recovery. Join us in exploring photos of exotic, endangered, and beautiful African wildlife to help save Gorongosa for good!
      '''
    learnMore: 'Learn More'
    getStarted: 'Get Started!'
    callToAction:
      header: '''Ready to get involved?'''
      button: '''Get Started'''

module.exports = React.createClass
  displayName: "Home"

  render: ->
    <div className="home-page">
      <section className="home-hero">
        <div className="home-hero-background" />
        <div className="home-content-container">
          <img src="assets/logo-white.png" className="logo" alt="WildCam Gorongosa" />
          <Translate component="div" className="tagline" content="homePage.hero.tagline" />
          <Translate component="div" className="overview" content="homePage.hero.overview" />

          <Link to="classify" className="home-call-to-action-button"><Translate content="homePage.getStarted" /></Link>
          <Link to="about" className="home-call-to-action-button ghost-button"><Translate content="homePage.learnMore" /></Link>
        </div>
      </section>
      <ProjectMetadata />
    </div>
