Entity = require '../../entity'

persist = collection: require './collection'

User = require '../../user'

module.exports = (database, io) ->
  driver = new Entity
  driver.key = 'memory'
  driver.map = {}
  
  driver.storage = {}
  
  driver.types =
    User: User
  
  driver.lookup = (id) ->
    driver.storage[id]
  
  driver.store = (entity) ->
    driver.storage[entity.id] = entity
  
  driver.hmset = (key, map, callback = ->) ->
    type = map.type
    
    console.log key, map
    
    model = driver.lookup key
    model ?= new driver.types[type]
    model.unpack map
    driver.store model
    
    do callback
  
  driver.publish = (channel, args...) ->
    driver.map[channel] ?= []
    listener channel, args... for listener in driver.map[channel]
    return
  
  driver.subscribe = (channel, callback = ->) ->
    driver.map[channel] ?= []
    driver.map[channel].push callback
    return
  
  io.sockets.on 'connection', (socket) ->
    socket.emit 'db', database.describe()
  
  io.sockets.on 'connection', (socket) ->
    
    socket.on 'sadd', (key, member) ->
      collection = driver.lookup key
      model = driver.lookup member
      collection.add model
    
    socket.on 'hmset', (key, map, callback = ->) ->
      driver.hmset key, map, callback
    
    socket.on 'sub', (channel, callback = ->) ->
      driver.subscribe channel, callback
    
    socket.on 'pub', (channel, args...) ->
      if args[0] is 'sadd'
        [op, member] = args
        driver.publish channel, op, member
      if args[0] is 'hmset'
        [op, map] = args
        driver.publish channel, op, map
      return
  
  database.collections.on 'add', (collection) ->
    driver.store collection
    persist.collection collection, driver, database