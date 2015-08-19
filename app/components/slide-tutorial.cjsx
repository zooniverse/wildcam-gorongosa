React = require 'react'
classnames = require 'classnames'

counterpart = require 'counterpart'
Translate = require 'react-translate-component'

slideTutorialContent = require '../lib/slide-tutorial-content'

counterpart.registerTranslations 'en',
  slides:
    one:
      title: slideTutorialContent[0].title
      content: slideTutorialContent[0].content
      button: slideTutorialContent[0].button
    two:
      title: slideTutorialContent[1].title
      content: slideTutorialContent[1].content
      button: slideTutorialContent[1].button
    three:
      title: slideTutorialContent[2].title
      content: slideTutorialContent[2].content
      button: slideTutorialContent[2].button

SlideTutorial = React.createClass
  displayName: 'SlideTutorial'

  getInitialState: ->
    activeSlide: 0

  componentWillReceiveProps: (nextProps) ->
    if nextProps.tutorialIsOpen is false
      @setState activeSlide: 0

  onClickButton: ->
    switch
      when @state.activeSlide < slideTutorialContent.length - 1
        @setState activeSlide: @state.activeSlide + 1
      when @state.activeSlide is slideTutorialContent.length - 1
        @onClickCloseTutorial()

  onClickCloseTutorial: ->
    slideTutorial = React.findDOMNode(@refs.slideTutorial)
    slideTutorial.classList.add 'fade-out' #css fade-out animation cause js animations aren't great in react yet.

    #Wait for animation
    setTimeout ( =>
      slideTutorial.classList.remove 'fade-out'
      @props.closeTutorial()
    ), 250

  onDotClick: (i) ->
    @setState activeSlide: i

  render: ->
    slideDots = slideTutorialContent.map (slide, i) =>
      dotClasses = classnames
        'slide-tutorial-dot': true
        'active': i is @state.activeSlide

      <div key={i} className={dotClasses} onClick={@onDotClick.bind(null, i)}></div>

    slides = slideTutorialContent.map (slide, i) =>
      slideClasses = classnames
        'slide-tutorial-slide': true
        'active': i is @state.activeSlide

      <div key={i} className={slideClasses}>
        <div className="slide-tutorial-slide-top">
          {<img src={slide.image} alt="" /> if slide.image?}
        </div>
        <div className="slide-tutorial-slide-bottom">
          <h1>{slide.title}</h1>
          <p>{slide.content}</p>
        </div>
        <div className="slide-tutorial-button-container">
          <button className="slide-tutorial-next-button" onClick={@onClickButton} value={slide.button}>{slide.button}</button>
        </div>
        <div className="slide-tutorial-dots">
          {slideDots}
        </div>
      </div>

    slideTutorialClasses = classnames
      'slide-tutorial': true
      'show': @props.tutorialIsOpen

    <div ref="slideTutorial" className={slideTutorialClasses}>
      <div className="slide-tutorial-overlay" onClick={@onClickCloseTutorial}></div>
      <div className="slide-tutorial-container">
        <button className="slide-tutorial-close-button" onClick={@onClickCloseTutorial}><img src="./assets/ex-icon.svg" alt="cancel icon" /></button>
        {slides}
      </div>
    </div>

module.exports = SlideTutorial