persist =
  server:
    entity: require './entity'
  unpack: require '../unpack'
  pack: require '../pack'

module.exports = (database, io) ->
  redis = require 'redis'
  
  driver = database.drivers.new
    key: 'redis'
  driver.client = redis.createClient()
  driver.pubsub = redis.createClient()
  driver.map = {}
  
  driver.subscribe = (channel, callback) ->
    driver.map[channel] ?= []
    
    driver.map[channel].push callback
    
    driver.pubsub.subscribe channel
    
    driver.pubsub.on 'message', (channel, message) ->
      for subscriber in driver.map[channel]
        subscriber message
    
    return
  
  io.sockets.on 'connection', (socket) ->
    socket.emit 'db', (persist.pack.collection database.collections)
    
    socket.on 'type', (key, callback = ->) ->
      driver.client.type key, callback
    
    socket.on 'get', (key, callback = ->) ->
      driver.client.get key, callback
    
    socket.on 'set', (key, value, callback = ->) ->
      driver.client.set key, value, callback
    
    socket.on 'smembers', (key, callback = ->) ->
      driver.client.smembers key, callback
    
    socket.on 'subscribe', (channel, callback = ->) ->
      driver.subscribe channel, callback
  
  trackCollection = (collection) ->
    collection.on 'add', (member) ->
      driver.client.sadd collection.id, member.id
      driver.client.publish collection.id, JSON.stringify ['sadd', member.id]
    
    driver.client.smembers collection.id, (error, memberIds) ->
      for memberId in memberIds
        member = collection.new id: memberId
        persist.server.entity member, database
  
  database.collections.on 'add', (collection) ->
    if collection.key?
      driver.client.type collection.key, (error, type) ->
        console.log error if error
        
        if type? and type is 'string'
          driver.client.get collection.key, (error, collectionId) ->
            collection.id = collectionId
            trackCollection collection
        else
          driver.client.set collection.key, collection.id, (error) ->
            trackCollection collection
    else
      driver.client.set collection.key, collection.id, (error) ->
        trackCollection collection