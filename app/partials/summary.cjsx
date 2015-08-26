React = require 'react'
Reflux = require 'reflux'

ProjectStore = require '../stores/project-store'

module.exports = React.createClass
  displayName: 'Summary'
  mixins: [Reflux.connect(ProjectStore, 'projectData')]

  render: ->
    <div className="classification-task-summary">
      <a href="https://www.zooniverse.org/#/projects/#{@state.projectData.slug}/talk/subjects/#{@props.subject.id}" className="discuss-link" target="_blank">
        Discuss
      </a>
    </div>