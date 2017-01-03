React = require 'react'

module.exports = React.createClass
  displayName: 'Education'

  render: ->
    <div className="education-page">
      <h2>Wildcam Labs</h2>
      <p>WildCam Labs is a new feature of the WildCam Gorongosa platform, which allows educators and students to ask ecological questions and filter the trail camera data to answer these questions. The data can be downloaded as a spreadsheet to analyze and draw conclusions. You can access the lab <a href="https://lab.wildcamgorongosa.org/">here</a> to start exploring. Additional educational resources focused on Gorongosa National Park are available from HHMI BioInteractive (below).</p>

      <h2>Gorongosa as a Case Study</h2>
      <p>Gorongosa National Park is one of the most diverse ecosystems in the world and is undergoing a large-scale restoration effort following decades of war in Mozambique. Park managers and scientists are working together to better understand the ecology of the park and to protect the Gorongosa ecosystem and its wildlife. This ongoing effort is an ideal case study to teach concepts in ecology and conservation biology in the classroom.</p>
      <p>HHMI BioInteractive has developed free educational resources, which are aligned to national curriculum standards, that educators can use to teach concepts in ecology, conservation, social science, and inquiry-based science practices. Visit the BioInteractive website to explore a variety of Gorongosa resources, including films, interactives, and hands-on activities.</p>
      <p><b><a href="http://www.biointeractive.org/gorongosa"  target="_blank">Explore Resources</a></b></p>

      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/3a2d0008-f612-4caf-a47f-c874eb1de69f.jpeg" alt="Resources grid" />
    </div>
