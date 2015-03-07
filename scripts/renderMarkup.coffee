# Core node modules.
fs = require 'fs-extra'
path = require 'path'
_ = require 'queries'

# Contrib.
nodejsx = require 'coffee-react/register'
React = require 'react'
{Router} = require 'react-router'

# Custom.
App = require '../app/app'

# Run Code.
# Render function specific to the server.
render = (Handler, props) ->
  filePath = path.join 'public', props.vars.path, 'index.html'
  console.timeEnd('pre-render')
  console.time('renderToString')
  console.time('el')
  el = React.createElement(Handler, props)
  console.timeEnd('el')
  markup = React.renderToString el
  console.timeEnd('renderToString')
  console.time('markup2')
  markup2 = React.renderToStaticMarkup el
  console.timeEnd('markup2')

  filePath = 'public/index.html'
  fs.mkdirsSync path.dirname(filePath)
  markup = "<!DOCTYPE html>\n<script src=\"app.js\"></script>"
  fs.writeFile(filePath, markup)

processPg = (path) ->
  console.time('pre-render')
  vars = {path: path}
  App vars, render

pages = ['/']

_.each pages, (pg) ->
  processPg pg
