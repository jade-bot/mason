blocks = require '../../blocks'

module.exports = ({io, db}) ->
  {volume, users} = db
  
  volume.on 'set', (x, y, z, voxel, chunk) ->
    io.sockets.emit 'set', x, y, z, voxel.index
  
  volume.on 'delete', (x, y, z) ->
    io.sockets.emit 'delete', x, y, z
  
  io.sockets.on 'connection', (socket) ->
    console.log 'socket'
    
    socket.on 'login', ({alias, secret}) ->
      return unless alias in (Object.keys db.users)
      
      console.log alias, secret
      
      user = db.users[alias]
      socket.user = user
      
      socket.emit 'login', user, volume.pack()
    
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