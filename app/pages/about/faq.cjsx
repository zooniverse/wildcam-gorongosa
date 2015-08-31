React = require 'react'

module.exports = React.createClass
  displayName: 'FAQ'

  render: ->
    <div className="secondary-page">
      <h2>Why don’t you have an “I don’t know” button?</h2>
      <p>We know that some of these photos are just impossible to identify, so why isn’t there an “I don’t know" button? We get this question a lot, but there is a good reason for not having one. Human brains are actually much better than you might think at making pretty good guesses, even when you think you have no idea. Narrowing the options down and making a guess is still valuable information that we wouldn’t get if you selected “I don’t know.” We always show the same photo to multiple people. If the first several people don’t agree, we show it to many more people. Often times, showing it to enough people will give us enough information to lead us to what is probably the right answer. Even when everyone disagrees on what species is in the photo, we might still get good information, like what the animal is doing, or whether it is a large or small animal. After showing an image to many different people, if all of the guesses are still completely different, we will classify it as an “unknown” animal and flag it for a scientist to review it.</p>

      <h2>What if I identify something incorrectly? Will that mess up your data?</h2>
      <p>There is no such thing as a wrong answer! We always show the same photo to multiple people. If the first several people don’t agree, we show it to many more people, so everyone’s answers get combined into an aggregate answer. If the animal is easy to identify and you identify it incorrectly, many other people will identify correctly and that is the answer we will take. If the animal is hard to identify and many people record different answers, we will record the animal as “unknown.”</p>

      <h2>The animal is too close / too far from the camera, or it’s too dark to identify it. What do I do?</h2>
      <p>You should try your best to identify the animal. We realize that some of these photos are really impossible to identify, but by narrowing down your choices and making a guess, you are still providing valuable information. We always show the same photo to multiple people. If the first several people don’t agree, we show it to many more people, so everyone’s answers get combined into an aggregate answer. Even when everyone disagrees on what species is in the photo, we might still get good information, like what the animal is doing, or whether it is a large or small animal. After showing an image to many different people, if all of the guesses are still completely different, we will classify it as an “unknown” animal and flag it for a scientist to review it.</p>

      <h2>Something is wrong with my image. (It’s a picture of the sky or ground, or overexposed, for example.) What do I do?</h2>
      <p>If you don’t see any animals, simply select "Nothing here." Sometimes our cameras malfunction or get knocked down by curious animals, but the cameras keep taking pictures.</p>

      <h2>Can I go back? I think I made a mistake.</h2>
      <p>No, you can’t go back, but don’t worry! We always show the same photo to multiple people, so your answer will be combined with the answers of other volunteers. After showing the image to many people, wrong answers will get outweighed by many correct answers.</p>

      <h2>How do I identify more than one animal in a photo?</h2>
      <p>Go through the process of identifying the first animal and click identify. This will bring you back to the classification screen, where you can identify the next animal. When you are finished identifying all of the animals in the photo, click the green “Done” button at the bottom.</p>

      <h2>What do I do if different individuals of the same species are engagin in different behaviors?</h2>
      <p>You should make one identification for the species and mark all of the behaviors that you see in the whole group.</p>

      <h2>What if I see an animal that is not on your list?</h2>
      <p>First double-check that your animal isn’t on the list. We have some broad categories like “bird (other),” “rodents,” and “reptiles” that may apply. Otherwise, if it really isn’t on the list, make a guess that is closest to that animal, then click “Talk” and tag the photo with the hashtag #new-animal and the species you think it is. We regularly read the “Talk” section and our scientists will record the correct species when we see this hashtag.</p>

      <h2>I know the species in a photo, but the only choice is a broad category (like bird (other), or reptile). Is there a way to record the species name?</h2>
      <p>Yes. Select the category that applies to the animal and when you finish with the classification, click the “Talk” button. Tag the photo with the hashtag #new-animal and the species that you think it is.  We regularly read the “Talk” section and our scientists will record the correct species when we see this hashtag.</p>

      <h2>What if I see something in a photo that I want to tell the scientists about?</h2>
      <p>Sometimes people see animals with radio collars, animals with injuries, or just interesting behaviors. We want to know about it! When you finish classifying the photo, click the “Talk” button and tell us about it. Be sure to add a hashtag if you can to make it easier for us to search by keyword.</p>

      <h2>Why are there so many photos without animals in them?</h2>
      <p>Sometimes the wind will blow grass or tree branches in front of a camera. We know that this can be frustrating for you because you want to see the animals! But once enough people classify the image as “nothing here,” we can retire the image and we won’t have to show it to you again. Then you can get back to identifying animals!</p>

      <h2>How can I zoom in on a photo?</h2>
      <p>Some of the photos will be blurry, or the animals are off in the distance. Our images are not high resolution because the website would be much too slow if we didn’t resize the images smaller. However, some people still find that zooming in on the photo can be useful. You can do this in one of two ways:</p>

      <p>
        <ol>
          <li>
            Zoom in on the photo in the website:<br/>
            <ul>
              <li>On a PC: Hold down the ctrl key and press the + key until you are zoomed in enough. Press ctrl and the - key to zoom back out when you’re done.</li>
              <li>On a Mac: Hold down the command key and the + key until you are zoomed in enough. Press command and the - key to zoom back out when you’re done.</li>
              <li>On a mobile device: Use two fingers to push the image apart</li>
            </ul>
          </li>
          <li>
            Download the image and zoom:<br/>
            <ul><li>Right-click the image and click “save as” to save the image to your computer. You can then open the file and zoom in using image-editing software.</li></ul>
          </li>
        </ol>
      </p>

      <h2>Is there a way to see the images taken right before and right after an image?</h2>
      <p>All of our images are served to the website in random order. Unfortunately, there is no good way to see the images before and after a given image.</p>

      <h2>How can I use WildCam Gorongosa in my classroom?</h2>
      <p>In the spring of 2016, we will launch an educator portal that will allow students to ask ecological questions, filter trail camera data, and download the data to analyze trends. Educators can use the portal to set up their classrooms, invite students, and manage projects and data for use in class. In the meantime, we will post activities on our <a href="http://www.wildcamgorongosa.org/about/education">Education</a> page using smaller sets of trail camera photos and data. You can also explore a variety of educational resources about Gorongosa National Park on <a href="http://www.biointeractive.org/gorongosa">BioInteractive.org</a>.</p>

      <h2>How can I ask a question about a topic that’s not in this FAQ?</h2>
      <p>The Talk forum is a great place to ask questions. Our scientists will be monitoring the discussion boards and answering as many questions as we can. Many seasoned Zooniverse volunteers also offer great advice on the forum.</p>
    </div>
