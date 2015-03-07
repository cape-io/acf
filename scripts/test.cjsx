React = require 'react'

module.exports = React.createClass
  render: ->
    {name} = @props
    str = "Hello, #{name}!"
    <div>{str}</div>
