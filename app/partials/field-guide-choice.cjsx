React = require 'react'
Reflux = require 'reflux'
_ = require 'lodash'

workflowStore = require '../stores/workflow-store'

module.exports = React.createClass
  displayName: 'FieldGuideEntry'
  mixins: [Reflux.connect(workflowStore, 'workflow')]

  getInitialState: ->
    workflow: workflowStore.data

  # Flakey
  getKeyFromUrlPath: (choice) ->
    choice.replace(/[aeiouy]/g, '').toUpperCase()

  render: ->
    unless @state.workflow
      return <div></div>

    try
      localChoice = require "../lib/field-guide-content/#{ @props.params.choice }"

    key = @getKeyFromUrlPath @props.params.choice

    task = @state.workflow.tasks[@state.workflow.first_task]
    choice = @state.workflow.tasks[@state.workflow.first_task].choices[key]

    if localChoice && choice
      Object.assign choice, localChoice
    else
      return <div></div>

    <div className="field-guide-entry">
      <div className="field-guide-entry-title"><h1>{choice.label}</h1></div>
      <div
        className="field-guide-entry-content"
        dangerouslySetInnerHTML={{__html: choice.content()}}
      />

      <h3>Trail Camera Images</h3>
      <div className="field-guide-entry-gallery">
        {choice.images.map (image, i) ->
          src = "https://thumbnails.zooniverse.org/400x300/#{ task.images[image].replace(/.*?:\/\//g, '') }"
          <div key={i} className="field-guide-entry-gallery-image"><img src={src} alt={choice.label} /></div>}
      </div>
    </div>
