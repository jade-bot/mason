blocks = require '../../blocks'

mail = require './mail'

module.exports = ({io, db}) ->
  {volume, users} = db
  
  # send new players the world
  db.players.on 'add', (player) ->
    player.socket.emit 'pack', volume.pack()
    
    player.socket.broadcast.emit 'player', player.user, player.characterId
  
  # let players set
  volume.on 'set', (x, y, z, voxel, chunk) ->
    io.sockets.emit 'set', x, y, z, voxel.index
  
  # let players delete
  volume.on 'delete', (x, y, z) ->
    io.sockets.emit 'delete', x, y, z
  
  io.sockets.on 'connection', (socket) ->
    console.log 'socket'
    
    socket.on 'sub', (id) ->
      entity = db.map[id]
      entity.on 'add', (member) ->
        socket.emit id, 'add', member.id
    
    socket.on 'login', ({alias, secret}) ->
      return unless alias in (Object.keys db.users)
      
      console.log alias, secret
      
      user = db.users[alias]
      socket.user = user
      
      db.online.add user
      
      socket.emit 'login', user, online: db.online.id
      
      # can only play once logged in
      socket.on 'play', (characterId) ->
        player =
          characterId: characterId
          socket: socket
          user: socket.user
        
        db.players.add player
    
    socket.on 'move', (position) ->
      socket.broadcast.emit 'move', socket.user?.id, position
    
    socket.on 'delete', (x, y, z) ->
      volume.delete x, y, z
    
    socket.on 'set', (x, y, z, voxel) ->
      volume.set x, y, z, blocks.map[voxel]
    
    socket.on 'chat', (message) ->
      io.sockets.emit 'chat', socket.user.alias, message
    
    socket.on 'join', ({alias, email, secret}) ->
      user = new User alias: alias, email: email, secret: secret
      
      if users[user.alias]?
        console.log 'user exists'
        
        socket.emit 'error', 'user exists'
      else
        users[user.alias] = user
        
        mail.join user
        
        socket.emit 'join', user