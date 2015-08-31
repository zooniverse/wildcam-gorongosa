React = require 'react'
ZooniverseLogo = require '../../partials/zooniverse-logo'

module.exports = React.createClass
  displayName: 'Organizations'

  render: ->
    <div>
      <p>WildCam Gorongosa is a collaboration between the Gorongosa Restoration Project, Howard Hughes Medical Institute’s BioInteractive, and the Zooniverse.</p>

      <div className="organizations">
        <div className="organization">
          <h3>Gorongosa Restoration Project</h3>
          <div className="organization-content">
            <div className="organization-logo"><img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/acd96793-dc11-4630-b47d-0a1ba173e045.png" /></div>
            <p>The Gorongosa Restoration Project is a nonprofit organization that, in partnership with the government of Mozambique, is working to manage and restore Gorongosa National Park. The restoration project focuses on conservation, scientific research, community development, and ecotourism to sustain Gorongosa as a flagship national park for future generations.<br/><a href="http://www.gorongosa.org" target="_blank">Visit Site</a></p>
          </div>
        </div>
        <div className="organization">
          <h3>HHMI | BioInteractive</h3>
          <div className="organization-content">
            <div className="organization-logo"><img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/300e042a-aeb8-4610-a77c-ffb4f315c250.png" /></div>
            <p>The Howard Hughes Medical Institute is a nonprofit organization whose mission is to advance biomedical research and science education. The HHMI BioInteractive website provides free multimedia resources to science educators and students. They include multimedia interactive resources, such as apps, animations, videos, click and learns, and virtual labs.<br/><a href="http://www.biointeractive.org" target="_blank">Visit Site</a></p>
          </div>
        </div>
        <div className="organization">
          <h3>Zooniverse</h3>
          <div className="organization-content">
            <div className="organization-logo"><ZooniverseLogo width="100%" height="100%" /></div>
            <p>The Zooniverse and the suite of projects it contains is produced, maintained, and developed by the Citizen Science Alliance (CSA). The member institutions of the CSA work with many academic and other partners around the world to produce projects that use the efforts and ability of volunteers to help scientists and researchers deal with the flood of data that confronts them.</p>
          </div>
        </div>
      </div>
    </div>
