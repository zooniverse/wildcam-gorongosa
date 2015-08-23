module.exports =
  label: 'Some Name' # taken from task choice if not provided
  description: 'some description' # taken from task choice if not provided

  scientificName: 'scientificus namius'
  mainImage: 'http://placehold.it/400'

  information: [{
    label: 'Length'
    value: 'some value'
  }, {
    label: 'Height'
    value: '1cm-5in.'
  }]

  conservationStatus: 'low' # valid options: low, medium, high. Or you can exclude it

  sections: [{
    title: 'Some Tittle'
    content: '''
      some <b>html</b> content
    '''
  }]
