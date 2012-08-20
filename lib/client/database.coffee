Collection = require '../collection'
Database = require '../persist/database'

persist = require '../persist'

module.exports = ({client}) ->
  client.db = db = new Database
  persist.client.database db
  
  db.users = db.collections.new key: 'users'