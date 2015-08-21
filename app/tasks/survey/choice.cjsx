React = require 'react'
DropdownForm = require '../../components/dropdown-form'
{Markdown} = require 'markdownz'

ImageFlipper = React.createClass
  displayName: 'ImageFlipper'

  PRELOAD_STYLE:
    height: 0
    overflow: 'hidden'
    position: 'fixed'
    right: 0
    width: 0

  getDefaultProps: ->
    images: []

  getInitialState: ->
    frame: 0

  render: ->
    style =
      backgroundImage: "url(#{ @props.images[@state.frame] })"
      backgroundPosition: 'center'
      backgroundSize: 'cover'
      height: 170

    <span className="survey-task-image-flipper">
      {@renderPreload()}

      <div style={style} className="survey-task-image-flipper-image" />

      <span className="survey-task-image-flipper-pips">
        {unless @props.images.length is 1
          for index in [0...@props.images.length]
            <span key={@props.images[index]}>
              <button type="button" className="survey-task-image-flipper-pip" disabled={index is @state.frame} onClick={@handleFrameChange.bind this, index}>{index + 1}</button>
              {' '}
            </span>}
      </span>
    </span>

  renderPreload: ->
    <div style={@PRELOAD_STYLE}>
      {for image in @props.images
        <img src={image} key={image} />}
    </div>

  handleFrameChange: (frame) ->
    @setState {frame}

module.exports = React.createClass
  displayName: 'Choice'

  getDefaultProps: ->
    task: null
    choiceID: ''
    onSwitch: Function.prototype
    onConfirm: Function.prototype
    onCancel: Function.prototype

  getInitialState: ->
    answers: {}

  allFilledIn: ->
    for questionID in @props.task.questionsOrder
      question = @props.task.questions[questionID]
      if question.required
        answer = @state.answers[questionID]
        if (not answer?) or (question.multiple and answer.length is 0)
          return false
    true

  render: ->
    choice = @props.task.choices[@props.choiceID]
    <div className="survey-task-choice">
      {unless choice.images.length is 0
        <ImageFlipper images={@props.task.images[filename] for filename in choice.images} />}

      <div className="survey-task-choice-label">{choice.label}</div>
      <div className="survey-task-choice-description">{choice.description}</div>

      {unless choice.confusionsOrder.length is 0
        <div className="survey-task-choice-confusions">
          Often confused with
          {' '}
          {for otherChoiceID in choice.confusionsOrder
            otherChoice = @props.task.choices[otherChoiceID]
            <span key={otherChoiceID}>
              <DropdownForm className="survey-task-confusions-modal" label={
                <span className="survey-task-choice-confusion">
                  {otherChoice.label}
                </span>
              } style={maxWidth: '60ch'}>
                <ImageFlipper images={@props.task.images[filename] for filename in otherChoice.images} />
                <Markdown content={choice.confusions[otherChoiceID]} />
                <div className="survey-task-choice-confusion-buttons" style={textAlign: 'center'}>
                  <button type="submit" className="major-button cancel">Dismiss</button>
                  {' '}
                  <button type="button" className="standard-button identify" onClick={@props.onSwitch.bind null, otherChoiceID}>I think it’s this</button>
                </div>
              </DropdownForm>
              {' '}
            </span>}
        </div>}

      <hr />

      {for questionID in @props.task.questionsOrder
        question = @props.task.questions[questionID]
        inputType = if question.multiple
          'checkbox'
        else
          'radio'
        <div key={questionID} className="survey-task-choice-question" data-multiple={question.multiple || null}>
          <div className="survey-task-choice-question-label">{question.label}</div>
          {for answerID in question.answersOrder
            answer = question.answers[answerID]
            isChecked = if question.multiple
              answerID in (@state.answers[questionID] ? [])
            else
              answerID is @state.answers[questionID]
            <label key={answerID} className="survey-task-choice-answer" data-checked={isChecked || null}>
              <input type={inputType} checked={isChecked} onChange={@handleAnswer.bind this, questionID, answerID} />
              {answer.label}
            </label>}
        </div>}

      {unless @props.task.questionsOrder.lengths is 0
        <hr />}

      <div style={textAlign: 'center'} className="task-buttons-container">
        <button type="button" className="minor-button cancel" onClick={@props.onCancel}>Cancel</button>
        <button type="button" className="standard-button identify" disabled={not @allFilledIn()} onClick={@handleIdentification}>Identify</button>
      </div>
    </div>

  handleAnswer: (questionID, answerID, e) ->
    if @props.task.questions[questionID].multiple
      @state.answers[questionID] ?= []
      if e.target.checked
        @state.answers[questionID].push answerID
      else
        @state.answers[questionID].splice @state.answers[questionID].indexOf(answerID), 1
    else
      @state.answers[questionID] = if e.target.checked
        answerID
      else
        null
    @setState answers: @state.answers

  handleIdentification: ->
    @props.onConfirm @props.choiceID, @state.answers
