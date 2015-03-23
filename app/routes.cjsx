React = require 'react'
{Route, DefaultRoute} = require 'react-router'

Index = require './view/index'
Main = require './view/main'
Login = require './view/login/login'
Members = require './view/member/list'
Detail = require './view/member/detail'

module.exports =

  <Route name="app" path="/" handler={Index}>
    <DefaultRoute handler={Main} />
    <Route name="login" handler={Login} />
    <Route name="admin" handler={Members} />
    <Route name="me" handler={Detail} />
  </Route>
