persist = entity: require './entity'

module.exports = (collection, driver, database, socket) ->
  # collection.on 'add', (member, args) ->
  #   console.log 'member', member unless args?.polarity is 'in'
    
  #   member.on 'change', -> collection.emit 'change'
    
  #   socket.emit 'sadd', collection.id, member.id
  
  # collection.on 'new', (member) ->
  #   persist.entity member, collection, driver, database, socket, ->
  #     member.emit 'persist'
  
  # socket.emit 'smembers', collection.id, (error, memberIds) ->
  #   collection.new id: memberId for memberId in memberIds
  #   return
  
  # socket.emit 'sub', collection.id, (channel, args...) ->
  #   if args[0] is 'sadd'
  #     [op, memberId] = args
  #     collection.new (id: memberId), (polarity: 'in')