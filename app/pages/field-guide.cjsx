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
      <h1>Field Guide</h1>
      <Link to="field-guide-entry" params={{entryName: 'honeybadger'}}>Test Honey Badger link</Link>
      <RouteHandler {...@props} />
    </div>
