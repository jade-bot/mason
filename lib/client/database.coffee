Collection = require '../collection'
Database = require '../database'

persist = require '../persist/client'

module.exports = ({client}) ->
  client.db = db = new Database
  db.use new persist.drivers.socketio.Driver io: client.io
  
  # db.users = db.collections.new key: 'users', mode: require '../user'
  # db.loots = db.collections.new key: 'loots', model: require '../loot'