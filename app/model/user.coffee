State = require 'ampersand-model'

module.exports = State.extend
  extraProperties: 'allow'
  url: ->
    if @email
      'https://composersforum.org/service/umail/'+@email
    else
      'https://composersforum.org/service/uid/'+@id
