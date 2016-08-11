React = require 'react'
Reflux = require 'reflux'
_ = require 'lodash'
classNames = require 'classnames'
LoadingIndicator = require '../components/loading-indicator'

module.exports = React.createClass
  displayName: 'FieldGuideChoice'

  # Flakey
  getKeyFromUrlPath: (choice) ->
    choice.replace(/[aeiouy_]/g, '').toUpperCase()

  getInitialState: ->
    choice: null
    images: null

  componentDidMount: ->
    @getChoiceImages(@props.workflow) if @props.workflow?

  componentWillReceiveProps: (nextProps) ->
    if @props.workflow isnt nextProps.workflow
      @getChoiceImages(nextProps.workflow)
  
  getChoiceImages: (workflow) ->
    try
      localChoice = require "../lib/field-guide-content/#{ @props.params.choice }"

    key = @getKeyFromUrlPath @props.params.choice

    task = workflow.tasks[workflow.first_task]
    task.images = _.mapKeys task.images, (value, key) -> key.toLowerCase()
    sourceChoice = task.choices[key]

    if localChoice && sourceChoice
      choice = Object.assign {}, sourceChoice, localChoice
      images = []
      choice.images.map (image, i) ->
        images.push "https://thumbnails.zooniverse.org/400x300/#{ task.images[image.toLowerCase()].replace(/.*?:\/\//g, '') }"
      @setState { choice: choice, images: images }
    else
      return <div></div>

  render: ->
    unless @props.workflow
      return <div></div>

    if @state.choice and @state.images
      featuredImage = @state.choice?.mainImage || @state.images[0]

      <div className="field-guide-entry">
        <div className="field-guide-entry-title"><h1>{@state.choice.label}</h1></div>

        {if @state.choice.scientificName
          <div className="field-guide-entry-scientific-name">{@state.choice.scientificName}</div>}

        {if @state.choice.conservationStatus
          <div>Status: {@state.choice.conservationStatus}</div>}

        <p className="field-guide-entry-description">{@state.choice.description}</p>

        <div className="field-guide-entry-content">
          <div className="columns">
            <div className="column">
              <img src={featuredImage} alt={@state.choice.label} />
            </div>
            <div className="column">
              <table cellSpacing="0" cellPadding="0">
                <tr><th colSpan="2">Information</th></tr>
                {if @state.choice.information
                  for item, i in @state.choice.information
                    <tr key={i}>
                      <td><b>{item.label}</b></td>
                      <td>{item.value}</td>
                    </tr>
                else
                  <tr><td>No information available</td></tr>}
              </table>
            </div>
          </div>
          {if @state.choice.sections
            <div className="field-guide-entry-sections">
              {for section, i in @state.choice.sections
                classes = classNames ['field-guide-entry-section', section.style || false]
                <div key={i} className={classes}>
                  <div><b>{section.title}</b></div>
                  <div className="field-guide-entry-section-content" dangerouslySetInnerHTML={{__html: section.content}}></div>
                </div>}
            </div>}
        </div>

        <h3>Trail Camera Images</h3>
        <div className="field-guide-entry-gallery">
          {@state.images.map (src, i) =>
            <div key={i} className="field-guide-entry-gallery-image"><img src={src} alt={@state.choice.label} /></div>}
        </div>
      </div>
    else
      <LoadingIndicator />
