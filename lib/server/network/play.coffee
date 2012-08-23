module.exports = ({db, io, socket}) ->
  socket.on 'play', ({id, position, rotation}) ->
    socket.broadcast.emit 'play',
      id: id
      position: position
      rotation: rotation