Collection = require '../collection'
Database = require '../persist/database'

persist = require '../persist'

module.exports = ({client}) ->
  client.db = db = new Database
  persist.client.database db, client
  
  client.io.on 'db', (packets) ->
    persist.unpack.collection packets, db