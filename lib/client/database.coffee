Collection = require '../collection'
Database = require '../database'

persist = require '../persist'

module.exports = ({client}) ->
  client.db = db = new Database
  persist.client.database db, client, (users: require '../user')
  
  db.users = db.collections.new key: 'users'