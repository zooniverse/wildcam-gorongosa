module.exports =
  label: 'Some Name' # taken from task choice if not provided
  description: 'some description' # taken from task choice if not provided

  scientificName: 'scientificus namius'
  mainImage: 'assets/fieldguide-content/name/name-feature.jpg'

  information: [{
    label: 'Length'
    value: 'some value'
  }, {
    label: 'Height'
    value: '1cm-5in.'
  }]

  conservationStatus: 'Least Concern' # Options are Least Concern, Near Threatened, Vulnerable, and Endangered; all have their own little icons as well.

  sections: [{
    title: 'Some Title'
    content: '''
      some <b>html</b> content
    '''
    },{
      title: 'Distribution'
      content: '<img src="assets/fieldguide-content/mammals/baboon/baboon-map.jpg"/>'
    }]
