persist =
  client:
    entity: require './entity'

module.exports = (database, client) ->
  socket = client.io
  
  driver = database.drivers.new
    key: 'socket.io'
    socket: socket
  
  trackCollection = (collection) ->
    collection.on 'add', (member) ->
      driver.socket.emit 'sadd', collection.id, member.id
      driver.socket.emit 'publish', collection.id, 'sadd', member.id
    
    driver.socket.emit 'smembers', collection.id, (error, memberIds) ->
      for memberId in memberIds
        member = collection.new id: memberId
        persist.client.entity member, database
    
    driver.socket.emit 'subscribe', collection.id, (message) ->
      [op, args...] = JSON.parse message
      
      console.log op, args...
      
      if op is 'sadd'
        [key] = args
        member = collection.new id: key
        persist.client.entity member, database
  
  database.collections.on 'add', (collection) ->
    if collection.key?
      driver.socket.emit 'type', collection.key, (error, type) ->
        console.log error if error
        
        if type? and type is 'string'
          driver.socket.emit 'get', collection.key, (error, collectionId) ->
            collection.id = collectionId
            trackCollection collection
        else
          driver.socket.emit 'set', collection.key, collection.id, (error) ->
            trackCollection collection
    else
      driver.socket.emit 'set', collection.key, collection.id, (error) ->
        trackCollection collection