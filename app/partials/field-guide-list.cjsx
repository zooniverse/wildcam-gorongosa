React = require 'react'
Reflux = require 'reflux'
Router = {Link} = require 'react-router'
_ = require 'lodash'

fieldGuideChoices = require '../lib/field-guide-content'

# TODO Integrate within fieldGuideChoices
categoryText =
  mammals: '''
    Quisque vehicula in enim non aliquet. Aliquam at urna commodo, vestibulum ligula vel, tincidunt ex. Sed pretium orci dui, et sodales sem pharetra nec. Vivamus viverra pellentesque ipsum eget suscipit. Proin sollicitudin pretium risus nec blandit. Duis hendrerit, arcu nec mattis elementum, purus ex facilisis tellus, at semper enim dui eget mi. Sed aliquam tincidunt orci, sit amet luctus turpis. Ut eget mi hendrerit, iaculis felis volutpat, aliquam quam. Aenean pulvinar a nisl ac varius.
  '''
  ecology: '''
    Quisque vehicula in enim non aliquet. Aliquam at urna commodo, vestibulum ligula vel, tincidunt ex. Sed pretium orci dui, et sodales sem pharetra nec. Vivamus viverra pellentesque ipsum eget suscipit. Proin sollicitudin pretium risus nec blandit. Duis hendrerit, arcu nec mattis elementum, purus ex facilisis tellus, at semper enim dui eget mi. Sed aliquam tincidunt orci, sit amet luctus turpis. Ut eget mi hendrerit, iaculis felis volutpat, aliquam quam. Aenean pulvinar a nisl ac varius.
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
                    <div className="field-guide-choice-label">{_.capitalize key}</div>
                </Link>}
            </div>
          </div>}
    </div>
