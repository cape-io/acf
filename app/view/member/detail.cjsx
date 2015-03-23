React = require 'react'

module.exports = React.createClass
  statics:
    willTransitionTo: (transition, params) ->
      app = window?.app or {}
      unless app.me
        transition.redirect('login')

  render: ->
    {title, expires, recurly, expired, state, loaded, emails, picture} = @props.member
    listItems = [
      <li key="expired"><strong>Status:</strong> {if expired then 'Expired' else 'Active'}</li>
      <li key="emails"><strong>Emails:</strong> {emails.join(', ')}</li>
    ]

    # Drupal info
    if state
      listItems.push <li key="state"><strong>State:</strong> {state}</li>
    if expires
      listItems.push <li key="expires"><strong>Expires (drupal): </strong> {expires}</li>
    # Recurly info
    if recurly?.token
      if recurly.membership
        listItems.push <li key="expiresRecurly">
          <strong>Expires (recurly):</strong> {recurly.membership.expires}</li>
        listItems.push <li key="status"><strong>Status:</strong> {recurly.membership.status}</li>
        if recurly.membership.invStatus
          listItems.push <li key="invStatus"><strong>Invoice Status:</strong> {recurly.membership.invStatus}</li>
      href= "http://acf.recurly.com/account/#{recurly.token}"
      listItems.push <li key="token">
        <strong>Recurly Link: </strong> <a href={href}>{href}</a></li>

    className = if expired then 'text-warning' else 'text-success'
    msg = if loaded then false else <small>Loading more info...</small>
    titleEl = <h2 className={className}>{title} {msg}</h2>

    if picture
      pic = <img src="//acf-img.imgix.net/#{picture.filepath}?w=300" style={float:'right'} alt="member photo" />
    <div>
      {pic}
      {titleEl}
      <ul>
        {listItems}
      </ul>
    </div>
