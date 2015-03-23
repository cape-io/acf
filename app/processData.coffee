_ = require 'lodash'

module.exports = (data) ->
  if data.members
    data.memberIndex = _.indexBy data.members, 'id'
  else
    data.memberIndex = {}
  return data
