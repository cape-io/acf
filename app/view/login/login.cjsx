React = require 'react'
{Input} = require 'react-bootstrap'
_ = require 'lodash'
http = require 'superagent'

emailIndex = {}

module.exports = React.createClass
  getInitialState: ->
    email: ''
    emailStatus: null

  changeEmail: ->
    email = @refs.email.getValue()
    if emailIndex[email] is false
      @setState
        emailStatus: 'error'
        email: email
      return
    if emailIndex[email]
      @setState
        emailStatus: 'success'
        email: email
      return
    if _.contains(email, '@') and domain = email.split('@')[1]
      if _.contains(domain, '.') and tld = domain.split('.')[1]
        if tld.length > 1
          #console.log 'Checking email ', email
          http.get('http://acf.cape.io.ld/user/email/'+email).accept('json').end (err, res) =>
            if not err and res and res.body
              if emailIndex[email] = res.body[0] or false
                @setState emailStatus: 'success'
              else
                @setState emailStatus: 'warning'
            else
              console.log err, res
    @setState
      emailStatus: null
      email: email

  #mixins: [Navigation, CurrentPath]
  render: ->
    {email, emailStatus} = @state
    {login} = @props

    if emailStatus is 'success'
      {title, expired} = emailIndex[email]
      welcome = "Welcome, #{title}!"
      emailHelpTxt = false
      userInfo =
        <div>
          <h3>{welcome}</h3>
          {if expired then <p>{login.expired_membership}</p> else false}
        </div>
      passwordField =
        <Input
          type="password"
          label="Password:"
          help="Please enter your password."
        />
    else
      passwordField = false
      userInfo = false
      emailHelpTxt = login.email_help

    <div className="row">
      <img src="https://composersforum.org/sites/all/themes/acfzen/acfzen/logo.png" alt="logo" />
      <div className="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
        <h1> Login </h1>
        <p className="lead">
          American Composers Forum
        </p>
        <Input
          type="text"
          value={email}
          placeholder='Enter your email'
          label='Your email please:'
          help={emailHelpTxt}
          bsStyle={emailStatus}
          ref='email'
          hasFeedback= {true}
          groupClassName='group-class-login'
          wrapperClassName='wrapper-class-login'
          labelClassName='label-class-editable'
          onChange={@changeEmail}
        />
        {userInfo}
        {passwordField}
      </div>
    </div>
