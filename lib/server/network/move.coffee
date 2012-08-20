module.exports = ({socket}) ->
  socket.on 'move', (position) ->
    socket.broadcast.emit 'move', socket.user?.id, position