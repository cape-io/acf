React = require 'react'
{Input} = require 'react-bootstrap'
_ = require 'lodash'

module.exports = React.createClass
  getInitialState: ->
    email: ''
    emailStatus: null

  changeEmail: ->
    email = @refs.email.getValue()
    @setState
      emailStatus: null
      email: email

  #mixins: [Navigation, CurrentPath]
  render: ->
    {email, emailStatus} = @state

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
          label='Your email please'
          help='Please use the email used when registering your membership.'
          bsStyle={emailStatus}
          ref='email'
          hasFeedback= {true}
          groupClassName='group-class-login'
          wrapperClassName='wrapper-class-login'
          labelClassName='label-class-editable'
          onChange={@changeEmail}
        />
        <Input
          type="password"
          label="Password"
        />
      </div>
    </div>
