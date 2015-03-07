_ = require 'queries'
async = require 'async'
http = require 'superagent'

makeReq = (url, handleData) ->
  (cb) ->
    console.log 'requesting', url

    http.get(url).accept('json').end (err, data) ->
      if _.isFunction handleData
        console.log 'process data', url
        data = handleData body
      cb err, body

module.exports = (callback) ->
  if typeof window is "undefined"
    data = fs.readJsonSync 'app/data/data.json'
  else
    data = require '../app/data/data.json'
  unless data
    callback()
    return

  if data.api
    getData = _.mapValues data.api, (url) ->
      makeReq url
  else
    getData = {}

  if data.facebook
    url = "http://social.cape.io/facebook/#{data.facebook}"
    handleData = (data) ->
      if data.cover and data.cover.images[0]
        data.coverImg = _.rename data.cover.images[0], {source: 'url'}
      return data

  if data.instagram
    url = "http://social.cape.io/instagram/#{data.instagram}"
    getData.insta = makeReq url

  save = (err, serverData) ->
    throw err if err
    _.merge data, serverData
    if _.isFunction callback
      callback()

  async.parallel getData, save
