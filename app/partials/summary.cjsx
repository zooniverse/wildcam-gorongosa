React = require 'react'

module.exports = React.createClass
  displayName: 'Summary'
  propTypes:
    annotations: React.PropTypes.array.isRequired

  render: ->
    console.log 'log dem annoos', @props.annotations
    <div>
      doo da
    </div>
