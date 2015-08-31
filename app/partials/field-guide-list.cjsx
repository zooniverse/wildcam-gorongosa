React = require 'react'
Reflux = require 'reflux'
Router = {Link} = require 'react-router'
_ = require 'lodash'

fieldGuideChoices = require '../lib/field-guide-content'

# TODO Integrate within fieldGuideChoices
categoryText =
  mammals: '''
    Mammals comprise some 5,416 species worldwide, about 1,125 of which live in Africa. Mammals are warm-blooded vertebrates, which have hair and nurse their young on milk produced by the female’s mammary glands. Most mammalian mothers give live birth and have relatively few babies, but they invest heavily in the survival of their young. Around one in four of the world’s mammals are currently threatened with extinction.

    Click on the icons below to browse some of Gorongosa's mammal species:
  '''
  ecology: '''
    Quisque vehicula in enim non aliquet. Aliquam at urna commodo, vestibulum ligula vel, tincidunt ex. Sed pretium orci dui, et sodales sem pharetra nec. Vivamus viverra pellentesque ipsum eget suscipit. Proin sollicitudin pretium risus nec blandit. Duis hendrerit, arcu nec mattis elementum, purus ex facilisis tellus, at semper enim dui eget mi. Sed aliquam tincidunt orci, sit amet luctus turpis. Ut eget mi hendrerit, iaculis felis volutpat, aliquam quam. Aenean pulvinar a nisl ac varius.
  '''
  birds: '''
    Birds are warm-blooded, egg-laying vertebrates that have evolved numerous adaptations for flight, including wings, powerful muscles, hollow bones, and, most distinctively, feathers. While all birds have feathers and wings, not all birds can fly, and there are also notable exceptions of birds that have lost (or partially lost) the trait of hollow bones. Birds comprise some 10,000 species worldwide, about 2,000 of which have been recorded in Africa. According to the International Union for Conservation of Nature (IUCN), 12 percent of birds worldwide are known to be threatened or extinct.

    Click on the icons below to browse some of Gorongosa's bird species:
  '''
  reptiles: '''
    Reptiles are cold-blooded, scaly-skinned vertebrates. Most reptiles lay leathery eggs; however, many lizard and snake species give birth to live young. The reptiles’ dry, scaly skin helps them retain water, making it possible for them to survive and thrive in typically inhospitable habitats such as deserts. However, they are absent from Antarctica. Reptiles comprise over 7,000 species worldwide, about 1,000 of which live in Africa. A third of the world’s reptiles are currently threatened with extinction.  
  '''





module.exports = React.createClass
  displayName: 'FieldGuideList'

  shouldShowCategory: (filter, category) ->
    should = if typeof filter is 'undefined' || filter is 'all'
      true
    else if filter is category
      true
    else
      false

    return should

  render: ->
    <div>
      {for category, choices of fieldGuideChoices
        if @shouldShowCategory @props.query.filter, category
          <div key={category}>
            <h1>{_.capitalize category}</h1>
            {if categoryText[category]
              <p>{categoryText[category]}</p>}
            <div className="field-guide-choice-list">
              {for key, choice of choices
                backgroundStyle =
                  backgroundImage: "url(#{ choice.mainImage })"
                <Link key={key} to="field-guide-choice" params={{choice: key}} className="field-guide-choice">
                    <div className="field-guide-choice-background" style={backgroundStyle} />
                    <div className="field-guide-choice-label">{key.replace(/[_]/g, ' ')}</div>
                </Link>}
            </div>
          </div>}
    </div>
