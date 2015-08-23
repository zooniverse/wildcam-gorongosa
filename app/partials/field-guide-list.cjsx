React = require 'react'
Reflux = require 'reflux'
Router = {Link} = require 'react-router'
_ = require 'lodash'

fieldGuideChoices = require '../lib/field-guide-content'

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
            <div>{category}</div>
            <div>
              {for key, choice of choices
                <div key={key}>
                  <Link to="field-guide-choice" params={{choice: key}}>{key}</Link>
                </div>}
            </div>
          </div>}
    </div>
