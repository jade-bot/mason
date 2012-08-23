Driver = require '../driver'

module.exports = class SocketIO extends Driver
  constructor: (args = {}) ->
    super
    
    @io = args.io
  
  used: (database) ->
    @db = database
    
    @io.sockets.on 'connection', (socket) ->
    # socket.emit 'db', database.describe()
    
    @io.sockets.on 'connection', (socket) =>
      socket.on 'get', (url, callback) =>
        # console.log url
        
        [match, hash, key, field] = /\/(.*)\/(.*)\/(.*)/.exec url
        
        console.log hash, key, field
        
        ids = Object.keys @db[hash].members[key][field].members
        
        callback @db[hash].members[key][field].members
    
  # socket.on 'sadd', (key, member) ->
  #     collection = driver.lookup key
  #     model = driver.lookup member
  #     collection.add model
    
  #   socket.on 'hmset', (key, map, callback = ->) ->
  #     driver.hmset key, map, callback
    
  #   socket.on 'sub', (channel, callback = ->) ->
  #     driver.subscribe channel, callback
    
  #   socket.on 'pub', (channel, args...) ->
  #     if args[0] is 'sadd'
  #       [op, member] = args
  #       driver.publish channel, op, member
  #     if args[0] is 'hmset'
  #       [op, map] = args
  #       driver.publish channel, op, map
  #     return