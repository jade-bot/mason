module.exports = ({io, db}) ->
  io.sockets.on 'connection', (socket) ->
    console.log 'socket'
    
    (require './network/edit') io: io, socket: socket, db: db
    (require './network/chat') io: io, socket: socket, db: db
    (require './network/login') io: io, socket: socket, db: db
    (require './network/join') io: io, socket: socket, db: db
    (require './network/position') io: io, socket: socket, db: db
    (require './network/play') io: io, socket: socket, db: db