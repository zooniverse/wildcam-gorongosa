React = require 'react'
Reflux = require 'reflux'

ProjectStore = require '../stores/project-store'

module.exports = React.createClass
  displayName: 'Summary'
  mixins: [Reflux.connect(ProjectStore, 'projectData')]

  render: ->
    task = @props.workflow.tasks[@props.workflow.first_task]
    <div className="task-summary">
      <div className="task-summary-annotations">
        <h3 className="task-summary-header">Your Classification Summary</h3>
        <ul className="task-summary-annotations-list">
          {for annotation, i in @props.annotations
            species = task.choices[annotation.choice].label
            plural = 
              if annotation.answers["HWMN"] > 1
                switch species
                  when "Buffalo" then "#{species}"
                  when "Hippopotamus" then "#{species}es"
                  when "Lion (male)"
                    "Lions (male)"
                  when "Lion (female)"
                    "Lions (female)"
                  when "Lion (cub)" then "Lions (cub)"
                  else 
                    "#{species}s"
              else
                species
            <li key={i} className="task-summary-annotations-list-item">
              <span className="item-species">{plural}</span><span className="item-number">{annotation.answers["HWMN"]}</span>
            </li>
        }</ul>
      </div>
      <div className="task-summary-call-to-action">
        <p className="call-to-action">
          Want to discuss this with other volunteers?
        </p>
        <a href="https://www.zooniverse.org/#/projects/#{@state.projectData.slug}/talk/subjects/#{@props.subject.id}" className="discuss-link" target="_blank">
          Discuss on Talk
        </a>
      </div>
      <div className="task-summary-tip">
        <p>Ready to move on?</p>
      </div>
    </div>