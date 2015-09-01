module.exports =
  label: 'Rodents' # taken from task choice if not provided
  description: '''
    There are thirty rodent species in Gorongosa that include mice, rats, gerbils, squirrels, mole rats, dormice, and the porcupine. As the largest of the rodent species in Gorongosa, the porcupine has a separate field guide entry. The rest of the rodent species are small mammals with a long tail that range from smooth, in the case of mice and rats, to furry, in the case of gerbils and squirrels. All rodents have a pair of incisors on each of the lower and upper jaw that grow continuously. They use these sharp incisors to gnaw food, excavate burrows and defend themselves.
  '''

  mainImage: 'assets/fieldguide-content/mammals/rodent/rodent-feature.jpg'

  conservationStatus: 'Least Concern' # Options are Least Concern, Near Threatened, Vulnerable, and Endangered; all have their own little icons as well.

  information: [{
    label: 'Length'
    value: '3-73 cm, depending on species'
  }, {
    label: 'Weight'
    value: '.003-23 kg, depending on species '
  }, {
    label: 'Lifespan'
    value: '2-15 years, depending on species'
  }, {
    label: 'Gestation'
    value: '1-4 months, depending on species'
  }, {
    label: 'Avg. number of offspring'
    value: '1-10, depending on species'
  }]

  sections: [{
    title: 'Habitat'
    content: 'Rodents live in a wide range of habitats. In Gorongosa, they can be found in all terrestrial habitats, from grasslands and savanna, to rainforest and limestone gorges.'
  }, {
    title: 'Diet'
    content: 'Seeds, stems, leaves, flowers, roots, bark, insects'
  }, {
    title: 'Predators'
    content: 'Birds, snakes, lizards, mongooses, weasels, and small cats, such as wildcats and servals.'
  }, {
    title: 'Behavior'
    content: '''
      <p>Most rodents are social, forming family groups but some species, such as the dormouse, are solitary. The structure of the social groups vary based on the species. Many rodents use mark with their urine to communicate within their own species or with other species. They may mark trails to establish their territories, but the odor of a predator will deter them from scent-marking. The scent of their urine provides important information about individuals including what species they are, their sex and even their individual identity. Urine can also provide information on dominance, reproductive status and health.</p>
    '''
  }, {
    title: 'Breeding'
    content: '''
      <p>Some rodent species are monogamous, where males and females form a pair bond. Other species are polygynous, where males will mate with multiple females. Females usually play a primary role in selecting their mates based on size, dominance, or territory of the male.</p>
      <p>Depending on the species, rodents may be born altricial (blind, hairless, and underdeveloped) or precocial (mostly furred, eyes open, and more developed). Squirrels and mice typically give birth to altricial young while porcupines give birth to precocial young. Females with altricial young usually build nests, which they use until their young are weaned. Young may leave the nest for the first time just a few days after they have opened their eyes and return regularly. When they get older, they visit the nest less often and eventually leave permanently.</p>
    '''
  }, {
    title: 'Fun Facts'
    style: 'focus-box'
    content: '''
      <ol>
        <li>Because their incisors grow continuously, rodents must continue to wear them down by gnawing on things.</li>
        <li>Rodents can see light on the ultraviolet (UV) spectrum and therefore can see light that humans can’t see.</li>
        <li>The urine of some rodents reflects UV light and this may be used in communication by leaving visible markings.</li>
      </ol>
    '''
  }]
