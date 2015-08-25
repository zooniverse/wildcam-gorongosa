React = require 'react'
Reflux = require 'reflux'
{Link, Navigation, RouteHandler, State} = require 'react-router'
RouterState = State
_ = require 'lodash'

ProjectMetadata = require '../partials/project-metadata'

workflowStore = require '../stores/workflow-store'

fieldGuideContent = require '../lib/field-guide-content'
CATEGORIES = ['all'].concat _.keys fieldGuideContent

module.exports = React.createClass
  displayName: 'FieldGuide'
  mixins: [Reflux.connect(workflowStore, 'workflow')]

  render: ->
    <div className="secondary-page">
      <div className="secondary-page-hero">
        <div className="secondary-page-container">
          <div className="secondary-page-hero-title">Field Guide</div>
        </div>
      </div>
      <div className="secondary-page-menu">
        <div className="secondary-page-container">
          {for category, i in CATEGORIES
            <Link key={i} to="field-guide" query={{filter: category}}>{_.capitalize category}</Link>}
        </div>
      </div>
      <div className="secondary-page-content">
        <div className="secondary-page-container">
          <RouteHandler {...@props} workflow={@state.workflow} />
        </div>
      </div>
      <ProjectMetadata />
    </div>
