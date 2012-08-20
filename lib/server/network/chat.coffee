module.exports = ({io, socket}) ->
  socket.on 'chat', (message) ->
    io.sockets.emit 'chat', socket.user.alias, message