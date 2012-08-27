Driver = require '../driver'

types =
  users: require '../../../../user'
  loots: require '../../../../model'

handle = (callthru = ->) ->
  (error, args...) ->
    if error? then console.log 'ERROR', error
    else callthru args...

module.exports = class SocketIO extends Driver
  constructor: (args = {}) ->
    super
    
    @io = args.io
  
  readEntity: (entity, collection, callback = ->) ->
    @io.emit 'hgetall', entity.id, handle (map) =>
      entity.unpack map
      do callback
  
  trackEntity: (entity, collection, callback = ->) ->
    @readEntity entity, collection, callback
  
  trackEntityById: (entityId, collection, callback = ->) ->
    entity = collection.create id: entityId, ->
    @trackEntity entity, collection, callback
  
  used: (db) ->
    db.collections.on 'add', (collection) =>
      console.log 'collection', collection
      
      @io.emit 'smembers', collection.id, handle (members) =>
        (@trackEntityById member, collection) for member in members
    
    @io.on 'db', (packets) ->
      for key, packet of packets
        console.log packet
        
        db.collections.new
          id: packet.id
          key: packet.key
          model: types[packet.key]