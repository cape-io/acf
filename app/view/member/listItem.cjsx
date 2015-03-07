React = require 'react'

module.exports = React.createClass
  render: ->
    {name, emails, expired, onClick} = @props
    txt = "#{name}, #{emails.join(', ')}"
    className = if expired then 'text-warning'
    <li onClick={onClick} className={className}> {txt} </li>
