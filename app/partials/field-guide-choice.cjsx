React = require 'react'
Reflux = require 'reflux'
_ = require 'lodash'
classNames = require 'classnames'

module.exports = React.createClass
  displayName: 'FieldGuideChoice'

  # Flakey
  getKeyFromUrlPath: (choice) ->
    choice.replace(/[aeiouy_]/g, '').toUpperCase()

  render: ->
    unless @props.workflow
      return <div></div>

    try
      localChoice = require "../lib/field-guide-content/#{ @props.params.choice }"

    key = @getKeyFromUrlPath @props.params.choice

    task = @props.workflow.tasks[@props.workflow.first_task]
    task.images = _.mapKeys task.images, (value, key) -> key.toLowerCase()
    sourceChoice = task.choices[key]

    if localChoice && sourceChoice
      choice = Object.assign {}, sourceChoice, localChoice
    else
      return <div></div>

    images = choice.images.map (image, i) ->
      src = "https://thumbnails.zooniverse.org/400x300/#{ task.images[image.toLowerCase()].replace(/.*?:\/\//g, '') }"

    featuredImage = choice.mainImage || images[0]

    <div className="field-guide-entry">
      <div className="field-guide-entry-title"><h1>{choice.label}</h1></div>

      {if choice.scientificName
        <div className="field-guide-entry-scientific-name">{choice.scientificName}</div>}

      {if choice.conservationStatus
        <div>Status: {choice.conservationStatus}</div>}

      <p className="field-guide-entry-description">{choice.description}</p>

      <div className="field-guide-entry-content">
        <div className="columns">
          <div className="column">
            <img src={featuredImage} alt={choice.label} />
          </div>
          <div className="column">
            <table cellSpacing="0" cellPadding="0">
              <tr><th colSpan="2">Information</th></tr>
              {if choice.information
                for item, i in choice.information
                  <tr key={i}>
                    <td><b>{item.label}</b></td>
                    <td>{item.value}</td>
                  </tr>
              else
                <tr><td>No information available</td></tr>}
            </table>
          </div>
        </div>
        {if choice.sections
          <div className="field-guide-entry-sections">
            {for section, i in choice.sections
              classes = classNames ['field-guide-entry-section', section.style || false]
              <div key={i} className={classes}>
                <div><b>{section.title}</b></div>
                <div className="field-guide-entry-section-content" dangerouslySetInnerHTML={{__html: section.content}} />
              </div>}
          </div>}
      </div>

      <h3>Trail Camera Images</h3>
      <div className="field-guide-entry-gallery">
        {images.map (src, i) ->
          <div key={i} className="field-guide-entry-gallery-image"><img src={src} alt={choice.label} /></div>}
      </div>
    </div>
