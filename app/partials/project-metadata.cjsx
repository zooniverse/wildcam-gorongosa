React = require 'react'
Reflux = require 'reflux'
Translate = require 'react-translate-component'
counterpart = require 'counterpart'
{Markdown} = require 'markdownz'

LoadingIndicator = require '../components/loading-indicator'

ProjectStore = require '../stores/project-store'

counterpart.registerTranslations 'en',
  projectMetadata:
    table:
      statistics: 'statistics'
      activeVolunteers: 'Active Volunteers'
      classifications: 'Classifications'
      imagesTotal: 'Images Total'
      complete: 'Complete'

module.exports = React.createClass
  displayName: 'ProjectMetadata'
  mixins: [Reflux.connect(ProjectStore, 'projectData')]

  render: ->
    <div className="project-metadata">
      <h3 className="project-metadata-header"><span className="project-name">Wildcam Gorongosa</span> <Translate content="projectMetadata.table.statistics" /></h3>
      {if @state.projectData
        <div className="project-metadata-container">
          <section className="project-metadata-section">
            <p className="project-metadata-number">{@state.projectData.classifiers_count}</p>
            <h4 className="project-metadata-section-header"><Translate content="projectMetadata.table.activeVolunteers" /></h4>
          </section>
          <section className="project-metadata-section">
            <p className="project-metadata-number">{@state.projectData.classifications_count}</p>
            <h4 className="project-metadata-section-header"><Translate content="projectMetadata.table.classifications" /></h4>
          </section>
          <section className="project-metadata-section">
            <p className="project-metadata-number">{@state.projectData.subjects_count}</p>
            <h4 className="project-metadata-section-header"><Translate content="projectMetadata.table.imagesTotal" /></h4>
          </section>
          <section className="project-metadata-section">
            <p className="project-metadata-number">{(@state.projectData.retired_subjects_count/@state.projectData.subjects_count) * 100}%</p>
            <h4 className="project-metadata-section-header"><Translate content="projectMetadata.table.complete" /></h4>
          </section>
        </div>
      else
        <LoadingIndicator />}
    </div>