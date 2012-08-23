Collection = require '../collection'
Database = require '../database'

persist = require '../persist'

module.exports = ({client}) ->
  client.db = db = new Database
  persist.client.database db, client,
    users: require '../user'
    loots: require '../loot'
  
  db.users = db.collections.new key: 'users', mode: require '../user'
  db.loots = db.collections.new key: 'loots', model: require '../loot'