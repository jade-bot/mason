module.exports = ({socket}) ->
  socket.on 'position', ({id, position, rotation}) ->
    socket.broadcast.emit 'position'
      id: id
      position: position
      rotation: rotation