Collection = require('ampersand-rest-collection')
Model = require('./user')

module.exports = Collection.extend
  model: Model
  url: 'https://composersforum.org/service/members.json'
