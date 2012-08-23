blocks = require '../../../blocks'

module.exports = ({io, socket, db}) ->
  {volume}  = db
  
  volume.on 'set', (x, y, z, voxel, chunk) ->
    io.sockets.emit 'set', x, y, z, voxel.index
  
  volume.on 'delete', (x, y, z) ->
    io.sockets.emit 'delete', x, y, z
  
  db.loots.on 'add', (loot) ->
    io.sockets.emit 'loot', loot.x, loot.y, loot.z, loot.index
  
  socket.on 'play', ->
    for key, loot of db.loots.members
      io.sockets.emit 'loot', loot.x, loot.y, loot.z, loot.index
  
  socket.on 'delete', (x, y, z) ->
    voxel = volume.get x, y, z
    if voxel.index? and voxel.index isnt 0
      db.loots.new
        id: "#{x}:#{y}:#{z}"
        x: x, y: y, z: z
        index: voxel.index
    
    volume.delete x, y, z
  
  socket.on 'set', (x, y, z, voxel) ->
    volume.set x, y, z, blocks.map[voxel]