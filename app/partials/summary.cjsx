React = require 'react'
Reflux = require 'reflux'

ProjectStore = require '../stores/project-store'

module.exports = React.createClass
  displayName: 'Summary'
  mixins: [Reflux.connect(ProjectStore, 'projectData')]

  render: ->
    task = @props.workflow.tasks[@props.workflow.first_task]
    <div className="classification-task-summary">
      <div className="classification-task-summary-annotations">
        <h3>Species Identified</h3>
        <ul className="classification-task-summary-annotations-list">
          {for annotation in @props.annotations
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
            <li>
              {annotation.answers["HWMN"]} {plural}:
              <ul className="classification-task-summary-annotations-behaviors-list">
                {for behaviorKey, behavior  of annotation.answers["WHTBHVRSDS"]
                  <li>{task.questions["WHTBHVRSDS"].answers[behavior].label}</li>
              }</ul>
            </li>
        }</ul>
      </div>
      <a href="https://www.zooniverse.org/#/projects/#{@state.projectData.slug}/talk/subjects/#{@props.subject.id}" className="discuss-link" target="_blank">
        Discuss
      </a>
    </div>