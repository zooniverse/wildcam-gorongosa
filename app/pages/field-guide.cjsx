React = require 'react'
Reflux = require 'reflux'
{Link, RouteHandler} = require 'react-router'
workflowStore = require '../stores/workflow-store'

module.exports = React.createClass
  displayName: 'FieldGuide'
  mixins: [Reflux.connect(workflowStore, 'workflow')]

  render: ->
    <div className="secondary-page">
      <h1>starting the field guide</h1>
      <Link to="field-guide-entry" params={{entryName: 'lion'}}>Test Link</Link>
      <RouteHandler {...@props} />
    </div>
