React = require 'react'
Router = {Link} = require 'react-router'

module.exports = React.createClass
  displayName: 'About'

  render: ->
    <div className="about-default-page">
      <h1>Gorongosa National Park</h1>
      <img className="map-image" src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/f43274ed-3b7a-47ac-8003-4d80461e8f98.png" style={maxWidth: 500} />

      <p>Located at the southern end of the East African Rift Valley, Gorongosa National Park in Mozambique has an amazing diversity of ecosystems and wildlife. The park is home to large animals like lions, antelopes, and elephants, and small creatures like birds, reptiles, and insects. Two decades of war, ending in the 1992, decimated the populations of many of Gorongosa’s large animals, but thanks to a large-scale conservation effort, many are now rebounding. Our scientists are working to discover which animal species are still in Gorongosa and track their recovery.</p>

      <h2>Using Trail Cameras to Study Wildlife</h2>
      <iframe width="710" height="400" src="https://www.youtube.com/embed/JAQE7f3QIqo" frameBorder="0" allowFullScreen></iframe>
      <p>Our trail cameras are a window into the diversity of wildlife across Gorongosa National Park. We have deployed a growing array of trail cameras around the park that use motion sensors to snap photos when an animal moves in front of them. Our scientists use these photos to study which animals are present, where they live, how they interact with one another, and to locate and track rare species. Trail cameras are an important tool for use in both wildlife research and conservation.</p>

      <div className="about-section">
        <h2>Help Us Collect Data</h2>
        <img className="float-left" src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/8ca550a3-dcd6-4372-9cbe-21c25106a77c.png" />
        <p>We have collected hundreds of thousands of photos (and counting), and we need your help to identify all the animals in these photos! The identifications that you record will build a data set that scientists can use to better understand which animals exist in Gorongosa, where they are, how they behave, and how the ecosystem is responding to restoration efforts. This information helps us monitor the park’s recovery and identify key challenges. Ready to get started?</p>
        <Link to="classify"><button type="button">Start Identifying</button></Link>
      </div>

      <div className="about-section">
        <h2>In the Classroom</h2>
        <img className="float-right" src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/4f2fa356-7494-4b49-9e9b-30f9228ca431.png"/>
        <p>HHMI BioInteractive has developed free educational resources using Gorongosa National Park as a case study in conservation biology and ecology. Educators can use these multimedia interactive resources, which are aligned to national curriculum standards, to teach concepts in ecology, conservation, social science, and inquiry-based science practices.</p>
        <a href="http://www.biointeractive.org/gorongosa" target="_blank"><button type="button">Explore Resources</button></a>
      </div>


      <h1>Lion Research</h1>

      <h2>Gorongosa Lion Project</h2>
      <iframe width="710" height="400" src="https://www.youtube.com/embed/VPP_COhvzn0" frameBorder="0" allowFullScreen></iframe>

      <p>The trail camera initiative started as a study led by the Gorongosa Lion Project, a team of conservationists from Mozambique and around the world whose goal is to understand the status and recovery of the lion population after the devastating years of war in Mozambique. We are conducting the first formal large carnivore research and conservation initiative in the park since the 1970s, and our first priority is to identify and track each lion and map the prides and coalitions that they belong to. Our research also includes studying the structure and dynamics of these prides and coalitions, reproduction and mortality, diet, genetics, disease exposure, and human impacts (including illegal hunting and habitat encroachment). By closely studying Gorongosa’s lion population, we can help forge effective conservation strategies for their long-term survival.</p>

      <p>One of our research tools is an array of over 50 trail cameras that capture photos of animals as they walk by. We use the data from these cameras to identify new lions, track their movement, and study the other species that interact with lions across the park. The cameras have also proved useful for identifying other animals in Gorongosa, including new elephants and species that have not been seen in Gorongosa in decades, such as hyenas and jackals.</p>

      <h2>Trail Cameras</h2>
      <iframe width="710" height="400" src="https://www.youtube.com/embed/CoXVC3o3Da8" frameBorder="0" allowFullScreen></iframe>

      <p>We have over 50 trail cameras spread across the park, some in very remote places. Part of our job is to regularly check on these cameras to make sure they are still working, change their batteries, and replace the memory cards that store thousands of images. We use helicopters to access cameras in very remote places, like the limestone gorges in the far northwestern region of the park. Sometimes we have to replace cameras that have been destroyed by elephants or flooded by swollen rivers. Once we get the photos back to camp, we check that the pictures were taken properly and we upload them to WildCam Gorongosa for you to identify.</p>
    </div>
