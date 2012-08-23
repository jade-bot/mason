module.exports = ({db, io, socket}) ->
  db.players ?= {}
  
  socket.on 'play', ({id, position, rotation}) ->
    for key, player of db.players
      socket.emit 'player', player
    
    db.players[id] =
      id: id
      position: position
      rotation: rotation
    
    socket.broadcast.emit 'play',
      id: id
      position: position
      rotation: rotation