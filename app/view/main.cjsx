React = require 'react'

module.exports = React.createClass
  render: ->
    {data, query} = @props

    <div className="container">
      <h1>Member Directory</h1>
    </div>
