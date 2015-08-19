React = require 'react'

module.exports = React.createClass
  displayName: 'FieldGuideEntry'

  render: ->
    <div>
      {@props.params.entryName}
    </div>
