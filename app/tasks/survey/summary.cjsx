React = require 'react'
Reflux = require 'reflux'

ProjectStore = require '../../stores/project-store'

module.exports = React.createClass
  displayName: 'SurveySummary'
  mixins: [Reflux.connect(ProjectStore, 'projectData')]

  getDefaultProps: ->
    task: null
    annotations: []
    expanded: false

  getInitialState: ->
    expanded: @props.expanded

  render: ->
    <div className="classification-task-summary">
      <div className="question">
        Survey of {@props.task.choicesOrder.length}
        {if @state.expanded
          <button type="button" className="toggle-more" onClick={@setState.bind this, expanded: false, null}>Less</button>
        else
          <button type="button" className="toggle-more" onClick={@setState.bind this, expanded: true, null}>More</button>}
      </div>
      <div className="answers">
        <div className="answer">
          {@props.annotations.length} identifications
        </div>
        {if @state.expanded and @props.annotations[0]?.value
          choiceSummaries = for identification in @props.annotations[0].value
            choice = @props.task.choices[identification.choice]
            allAnswers = for questionID in @props.task.questionsOrder when questionID of identification.answers
              answerLabels = for answerID in [].concat identification.answers[questionID]
                @props.task.questions[questionID].answers[answerID].label
              answerLabels.join ', '

            "#{choice.label}: #{allAnswers.join '; '}"

          for choiceSummary, i in choiceSummaries
            <div key={i} className="answer">
              {choiceSummary}
            </div>}
      </div>
      <a href="https://www.zooniverse.org/#/#{@state.projectData.slug}/talk/subjects/#{@props.subject.id}" className="discuss-link" target="_blank">
        Discuss
      </a>
    </div>
