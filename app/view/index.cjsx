React = require 'react'
{Link} = require 'react-router'
{RouteHandler, State} = require 'react-router'

module.exports = React.createClass
  render: ->
    {data} = @props
    {title, sha, description, author} = data
    appFileName = sha or 'app'
    cssFilePath = "/assets/#{appFileName}.css"
    jsFilePath = "/assets/#{appFileName}.js"

    <html>
      <head>
        <title>{title}</title>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="/default.css" />
        <meta name="generator" content="CAPE.io, see www.cape.io" />
        <meta name="description" content={description} />
        <meta name="author" content={author} />
      </head>
      <body>
        {React.createElement(RouteHandler, data)}
        <Link to="login">Login</Link>
        <script src={jsFilePath} type="text/javascript" />
      </body>
    </html>
