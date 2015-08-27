React = require 'react'
DropdownForm = require '../../components/dropdown-form'
_ = require 'lodash'
classNames = require 'classnames'

THUMBNAIL_BREAKPOINTS = [Infinity, 40, 20, 10, 5, 0]

module.exports = React.createClass
  displayName: 'Chooser'

  getDefaultProps: ->
    annotations: []
    task: null
    filters: {}
    onFilter: Function.prototype
    onChoose: Function.prototype
    onRemoveChoice: Function.prototype

  getFilteredChoices: ->
    for choiceID in @props.task.choicesOrder
      choice = @props.task.choices[choiceID]
      rejected = false
      for characteristicID, valueID of @props.filters
        if valueID not in choice.characteristics[characteristicID]
          rejected = true
          break
      if rejected
        continue
      else
        choiceID

  handleFilter: (characteristicID, valueID) ->
    @props.onFilter characteristicID, valueID

  handleClearFilters: ->
    for characteristicID in @props.task.characteristicsOrder
      @props.onFilter characteristicID, undefined

  render: ->
    filteredChoices = @getFilteredChoices()

    for point in THUMBNAIL_BREAKPOINTS
      if filteredChoices.length <= point
        breakpoint = point

    <div className="survey-task-chooser">
      <div className="survey-task-chooser-characteristics">
        {for characteristicID in @props.task.characteristicsOrder
          characteristic = @props.task.characteristics[characteristicID]
          selectedValue = characteristic.values[@props.filters[characteristicID]]
          hasBeenAutoFocused = false

          <DropdownForm key={characteristicID} ref="#{characteristicID}-dropdown" className="survey-task-chooser-characteristic-menu" label={
              <span className="survey-task-chooser-characteristic" data-is-active={selectedValue? || null}>
                <span className="survey-task-chooser-characteristic-label">{selectedValue?.label ? characteristic.label}</span>
              </span>
            }>
            <div className="survey-task-chooser-characteristic-menu-container">
              {for valueID in characteristic.valuesOrder
                value = characteristic.values[valueID]

                disabled = valueID is @props.filters[characteristicID]
                autoFocus = not disabled and not hasBeenAutoFocused
                selected = valueID is @props.filters[characteristicID]

                if autoFocus
                  hasBeenAutoFocused = true

                <span key={valueID}>
                  <button type="submit" title={value.label} className="survey-task-chooser-characteristic-value" disabled={disabled} autoFocus={autoFocus} data-selected={selected} onClick={@handleFilter.bind this, characteristicID, valueID}>
                    {if valueID is "THR"
                      "Other"
                    else
                      if value.image?
                        <img src={@props.task.images[value.image]} alt={value.label} className="survey-task-chooser-characteristic-value-icon" />}
                  </button>
                </span>}

              <button type="submit" className="survey-task-chooser-characteristic-clear-button" disabled={characteristicID not of @props.filters} autoFocus={not hasBeenAutoFocused} onClick={@handleFilter.bind this, characteristicID, undefined}>
                Clear
              </button>
            </div>
            <div className="survey-task-chooser-characteristic-value-label">
            {label = ""
            for valueID in characteristic.valuesOrder
              value = characteristic.values[valueID]

              if valueID is @props.filters[characteristicID]
                label = value.label
            if label then label else "Make a selection"
            }</div>
          </DropdownForm>}
      </div>

      <div className="survey-task-chooser-choices" data-breakpoint={breakpoint}>
        {if filteredChoices.length is 0
          <div>
            <em>No matches.</em>
          </div>
        else
          for choiceID, i in filteredChoices
            choice = @props.task.choices[choiceID]
            chosen = _.some @props.annotations, 'choice', choiceID
            classes = classNames [
              'survey-task-chooser-choice'
              'selected-annotation': chosen
              ]
            <div key={choiceID + i}>
              <button type="button" className={classes} onClick={@props.onChoose.bind null, choiceID}>
                {unless choice.images.length is 0
                    <img src={@props.task.images[choice.images[0]]} className="survey-task-chooser-choice-thumbnail" />}
                <div className="survey-task-chooser-choice-label">{choice.label}</div>
              </button>
              {if chosen
                <button type="button" className="survey-task-chooser-choice-remover-button" onClick={@props.onRemoveChoice.bind null, choiceID}>x</button>}
            </div>
      }</div>
      <div className="survey-task-characteristic-filter-summary">
        Showing {filteredChoices.length} of {@props.task.choicesOrder.length}.
        &ensp;
        <button type="button" className="survey-task-chooser-characteristic-clear-button" disabled={Object.keys(@props.filters).length is 0} onClick={@handleClearFilters}>
          <i className="fa fa-ban"></i> Clear filters
        </button>
      </div>
    </div>
