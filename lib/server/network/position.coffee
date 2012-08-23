module.exports = ({socket, db}) ->
  db.players ?= {}
  
  socket.on 'position', ({id, position, rotation}) ->
    if db.players[id]?
      vec3.set position, db.players[id].position 
      quat4.set rotation, db.players[id].rotation
    
    socket.broadcast.emit 'position'
      id: id
      position: position
      rotation: rotation