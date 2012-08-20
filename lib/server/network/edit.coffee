blocks = require '../../../blocks'

module.exports = ({io, socket, db}) ->
  {volume}  = db
  
  volume.on 'set', (x, y, z, voxel, chunk) ->
    io.sockets.emit 'set', x, y, z, voxel.index
  
  volume.on 'delete', (x, y, z) ->
    io.sockets.emit 'delete', x, y, z
  
  socket.on 'delete', (x, y, z) ->
    volume.delete x, y, z
  
  socket.on 'set', (x, y, z, voxel) ->
    volume.set x, y, z, blocks.map[voxel]