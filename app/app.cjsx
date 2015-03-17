React = require 'react'
Router = require 'react-router'
http = require 'superagent'

Routes = require './routes'

inBrowser = typeof window isnt "undefined"

# The goal with this is to have the server and client call the same function to
# init the app.
App = (data, render) ->
  if not data.path then data.path = '/'

  Render = (Handler) ->
    # This is the default props sent to the Index view.
    render Handler, data

  if inBrowser
    Router.run Routes, Router.HistoryLocation, Render
  else
    Router.run Routes, data.path, Render

if inBrowser
  window.onload = -> # Attach event handlers.
    # This is created specific to the client.
    render = (Handler, props) ->
      React.render React.createElement(Handler, props), document
    http.get('/index.json').accept('json').end (err, res) =>
      if err
        return console.error err
      if res and res.body
        # Attach app to global window var as app.
        window.app = data = res.body
        # Trigger render.
        App data, render
        console.log 'Init react with data.'
      else
        console.error err or res

module.exports = App
