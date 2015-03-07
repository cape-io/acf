React = require 'react'
Router = require 'react-router'
Routes = require './routes'
#serverData = require './serverData'
data = require './data/data.json'
# data.imgNum = 1

inBrowser = typeof window isnt "undefined"

# The goal with this is to have the server and client call the same function to
# init the app.
App = (vars, render) ->
  path = vars.path or '/'
  #serverData (data) ->
  props =
    vars: vars
    data: data
  Render = (Handler) ->
    # This is the default props sent to the Index view.
    render Handler, props
  #console.log props
  if inBrowser
    domready = require 'domready'
    domready () ->
      console.log 'loaded page'
      Router.run Routes, Router.HistoryLocation, Render
  else
    console.time('renderx')
    Router.run Routes, path, Render
    console.timeEnd('renderx')

if inBrowser
  console.log 'js triggered'
  render = (Handler, props) ->
    React.render React.createElement(Handler, props), document.documentElement
  App {}, render

module.exports = App
