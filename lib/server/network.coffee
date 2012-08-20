module.exports = ({io, db}) ->
  io.sockets.on 'connection', (socket) ->
    console.log 'socket'
    
    (require './network/auth') io: io, socket: socket, db: db
    (require './network/edit') io: io, socket: socket, db: db
    (require './network/chat') io: io, socket: socket, db: db