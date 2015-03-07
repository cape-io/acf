React = require 'react'

Members = require './member/list'

module.exports = React.createClass
  render: ->
    {data, query} = @props

    <div className="container">
      <Members data={data} />
    </div>
