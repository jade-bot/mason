Entity = require '../../entity'

persist =
  entity: require './entity'
  collection: require './collection'

module.exports = (db, client, types) ->
  socket = client.io
  
  driver = new Entity
  driver.key = 'memory'
  
  db.collections.on 'add', (collection) ->
    persist.collection collection, driver, db, socket
  
  client.io.on 'db', (packets) ->
    for key, packet of packets
      db.collections.new
        id: packet.id
        key: packet.key
        model: types[packet.key]
    
    return