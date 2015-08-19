React = require 'react'
counterpart = require 'counterpart'
{Markdown} = require 'markdownz'

counterpart.registerTranslations 'en',
  aboutPage:
    content: '''
      ## Why is this project important?

      Scientists know relatively little about the behavior of many North American bat species in their native environments. That is because bat behaviors are really hard to study in the wild. Bats tend to be small, active at night when it is hard for us to see them, and easily disturbed when they are in their roosts.

      Studying bat behaviors in the wild is becoming easier thanks to improvements in technology. Infrared and near infrared cameras are now able to remotely record bat behaviors in and around bat roosts. However, one study can produce thousands of hours of video. Someone has to watch all those videos and identify the behaviors.

      This study helps scientists by involving the public in the scientific process. Lots of eyes can watch the videos faster than just one or two scientists. By working together, the videos can be processed faster and we can learn more about the bats' behaviors. Plus, because so little is known about bat behaviors in the wild, participants watching the videos may discover new behaviors.

      ## About the videos

      The bats in the videos are lesser long-nosed bats (Leptonycteris curasoae). Lesser long-nosed bats are an endangered bat that feeds on nectar and pollen of many southwestern cacti species, including agave. Lesser long-nosed bats migrate between Mexico and southern Arizona and New Mexico. Their migration follows the blooms of the cacti that they pollinate.

      Every year, scientists pick two consecutive nights in each of several months to conduct simultaneous population counts of the bats. The videos were recorded during those population counts. The videos feature an old mine that is located in Arizona and is a fall roosting site for the lesser long-nosed bats.

      A large, 6-sided gate surrounds the entrance to the mine. Six cameras, one for each side of the gate, were set up to record the bats as they entered and exited the mine. Infrared lights were also placed around the mine to provide extra light for the cameras. (Infrared light doesn't disturb the bats.) The cameras recorded video from sunup to sundown.

      Scientists used night vision goggles to count the bats using the mine at the same time that the cameras were recording the videos. The videos were originally used to check the accuracy of the scientists' population counts. Now, we want to use those same videos to study the bats' behaviors as they fly around the roost.
    '''

module.exports = React.createClass
  displayName: 'AboutPage'

  render: ->
    <div className="secondary-page">
      <h1>About WildCam Gorongosa</h1>
      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/e57ac0ee-211c-46b0-ae1f-7409d9bfa54b.png" />

      <h2>Gorongosa National Park</h2>
      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/f43274ed-3b7a-47ac-8003-4d80461e8f98.png" />

      <p>Located at the southern end of the East African Rift Valley, Gorongosa National Park in Mozambique has an amazing diversity of ecosystems and wildlife. The park is home to large animals like lions, antelopes, and elephants, and small creatures like birds, reptiles, and insects. Two decades of war, ending in the 1992, decimated the populations of many of Gorongosa’s large animals, but thanks to a large-scale conservation effort, many are now rebounding. Our scientists are working to discover which animal species are still in Gorongosa and track their recovery.</p>

      <h2>Using Trail Cameras to Study Wildlife</h2>
      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/bf58b7f1-6829-4272-9df2-bed12479d193.jpeg" />
      <p>Our trail cameras are a window into the diversity of wildlife across Gorongosa National Park. We have deployed a growing array of trail cameras around the park that use motion sensors to snap photos when an animal moves in front of them. Our scientists use these photos to study which animals are present, where they live, how they interact with one another, and to locate and track rare species. Trail cameras are a new and important tool for use in both wildlife research and conservation.</p>

      <h2>Help Us Collect Data</h2>
      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/8ca550a3-dcd6-4372-9cbe-21c25106a77c.png" />
      <p>We have collected hundreds of thousands of photos (and counting), and we need your help to identify all the animals in these photos! The identifications that you record will build a data set that scientists can use to better understand which animals exist in Gorongosa, where they are, how they behave, and how the ecosystem is responding to restoration actions. This information helps us monitor the park’s recovery and identify key challenges. Ready to get started? <a href="#/classify">Start Identifying</a></p>

      <h2>In the Classroom</h2>
      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/6f6deafb-fe09-4b3c-acca-f80591b6a508.png" />
      <p>HHMI’s BioInteractive has developed free educational resources using Gorongosa National Park as a case study in conservation biology and ecology. Educators can use these multimedia interactive resources, which are aligned to national curriculum standards, to teach concepts in ecology, conservation, social science, and inquiry-based science practices. <a href="https://www.biointeractive.org/gorongosa">Explore Resources</a></p>

      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/e57ac0ee-211c-46b0-ae1f-7409d9bfa54b.png" />

      <h1>Lion Research</h1>
      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/e57ac0ee-211c-46b0-ae1f-7409d9bfa54b.png" />

      <h2>Gorongosa Lion Project</h2>
      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/d4a9eb5f-bce3-433b-a104-4f549b6f5693.jpeg" />

      <p>The trail camera initiative started as a study led by the Gorongosa Lion Project, a team of international and Mozambican conservationists whose goal is to understand the status and recovery of the lion population after the devastating years of war in Mozambique. We are conducting the first formal large carnivore research and conservation initiative in the park since the 1970s, and our first priority has been to identify and track each individual lion and map the prides and coalitions that they belong to. Our research also includes studying the structure and dynamics of these prides and coalitions, reproduction and mortality, diet, genetics, disease exposure, and human impacts (including illegal hunting and habitat encroachment). By closely studying Gorongosa’s lion population, we can help forge effective conservation strategies for their long-term survival.</p>

      <p>One of our research tools is an array of over 50 trail cameras that capture photos of animals as they walk by. We use the data from these cameras to identify new lions, track their movement, and study the other species that interact with lions across the park. The cameras have also proved useful for identifying other animals in Gorongosa, including new elephants and species that have not been seen in Gorongosa in decades, such as hyenas and jackals.</p>

      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/1226d7c8-b0a1-490f-93dc-b4520947151d.png" />

      <h2>Trail Cameras</h2>
      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/d2740e36-5022-4d85-b0cd-c98395616845.png" />

      <p>We have over 50 trail cameras spread across the park, some in very remote places. Part of our job is to regularly check on these cameras to make sure they are still working, change their batteries, and replace the memory cards that store thousands of images. We use helicopters to access cameras in very remote places, like the limestone gorges in the far northwestern region of the park. Sometimes we have to replace cameras that have been destroyed by elephants or flooded by swollen rivers. Once we get the photos back to camp, we check that the pictures were taken properly and we upload them to WildCam Gorongosa for you to identify.</p>

      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/a4498bac-109a-4c86-95fb-16cf79e62d70.jpeg" />
      <img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/e57ac0ee-211c-46b0-ae1f-7409d9bfa54b.png" />

      <h1>Organizations</h1>

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
            <div className="organization-logo"><img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/8d6dc1d9-0215-4b58-b3fa-5a601066a23e.png" /></div>
            <p>Howard Hughes Medical Institute is a nonprofit organization whose mission is to advance biomedical research and science education. HHMI’s BioInteractive website provides free multimedia resources to science educators and students. They include multimedia interactive resources, such as apps, animations, videos, click and learns, and virtual labs.<br/><a href="http://www.biointeractive.org" target="_blank">Visit Site</a></p>
          </div>
        </div>
        <div className="organization">
          <h3>Zooniverse</h3>
          <div className="organization-content">
            <div className="organization-logo"><img src="https://panoptes-uploads.zooniverse.org/production/project_attached_image/adafceb0-0143-4f17-b977-05798160deca.jpeg" /></div>
            <p>The Zooniverse and the suite of projects it contains is produced, maintained, and developed by the Citizen Science Alliance (CSA). The member institutions of the CSA work with many academic and other partners around the world to produce projects that use the efforts and ability of volunteers to help scientists and researchers deal with the flood of data that confronts them.</p>
          </div>
        </div>
      </div>
    </div>
