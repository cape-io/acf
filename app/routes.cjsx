React = require 'react'
{Route, DefaultRoute} = require 'react-router'

Index = require './view/index'
Login = require './view/login/login'
Members = require './view/member/list'

module.exports =

  <Route name="app" path="/" handler={Index}>
    <DefaultRoute name="login" handler={Login} />
    <Route name="admin" handler={Members} />
  </Route>
