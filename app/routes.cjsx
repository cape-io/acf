React = require 'react'
Router = require 'react-router'
{Route, DefaultRoute} = Router

Index = require './view/index'
Login = require './view/login/login'
Members = require './view/member/list'

module.exports =

  <Route name="app" path="/" handler={Index}>
    <DefaultRoute name="login" handler={Login} />
    <Route name="admin" handler={Members} />
  </Route>
