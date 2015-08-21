React = require 'react'
Reflux = require 'reflux'
{Link, Navigation, RouteHandler, State} = require 'react-router'
RouterState = State
_ = require 'lodash'

workflowStore = require '../stores/workflow-store'

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
      <div className="secondary-page-content">
        <div className="secondary-page-container">
          <nav>
            <Link className="entry-link" to="field-guide-choice" params={{choice: 'honeybadger'}}>Test Honey Badger link</Link>
            <Link className="entry-link" to="field-guide-choice" params={{choice: 'baboon'}}>Test Baboon link</Link>
          </nav>

          <RouteHandler {...@props} />
        </div>
      </div>
    </div>
