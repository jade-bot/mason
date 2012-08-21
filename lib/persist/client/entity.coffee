module.exports = (entity, collection, driver, db, socket, callback) ->
  # socket.emit 'hgetall', entity.id, (error, map) ->
  #   if error then console.log error
  #   else entity.unpack map
  
  socket.emit 'hmset', entity.id, entity.pack(), ->
    do callback
  
  socket.emit 'sub', entity.id, (message) ->
    console.log 'sub', entity.id, message