module.exports = util = {}

util.spin = (entity) ->
  return setInterval ->
    volume.rotateY 1 / 60
    volume.sync()
  , 1000 / 60

CX = 16
CY = 16
CZ = 16

util.voxelVectorToChunkKey = (vector) ->
  cx = Math.floor vector[0] / CX
  cy = Math.floor vector[1] / CY
  cz = Math.floor vector[2] / CZ
  
  return "#{cx}:#{cy}:#{cz}"

util.voxelToChunkKey = (x, y, z) ->
  cx = Math.floor x / CX
  cy = Math.floor y / CY
  cz = Math.floor z / CZ
  
  return "#{cx}:#{cy}:#{cz}"

util.chunkKey = (x, y, z) ->
  return "#{x}:#{y}:#{z}"

util.chunkKeyVector = (chunk) ->
  return "#{chunk[0]}:#{chunk[1]}:#{chunk[2]}"

util.voxelIndex = (x, y, z) ->
  return x + (y * CX) + (z * CX * CY)

util.voxelToChunk = (x, y, z, chunk = []) ->
  chunk[0] = Math.floor x / CX
  chunk[1] = Math.floor y / CY
  chunk[2] = Math.floor z / CZ
  
  return chunk
  
util.voxelVectorToChunk = (voxel, chunk = []) ->
  chunk[0] = Math.floor voxel[0] / CX
  chunk[1] = Math.floor voxel[1] / CY
  chunk[2] = Math.floor voxel[2] / CZ
  
  return chunk

util.voxelVectorToChunkVoxel = (vector, chunkVoxel = []) ->
  [x, y, z] = vector
  
  x %= CX
  y %= CY
  z %= CZ
  
  chunkVoxel[0] = if x < 0 then CX - (Math.abs x) else x
  chunkVoxel[1] = if y < 0 then CY - (Math.abs y) else y
  chunkVoxel[2] = if z < 0 then CZ - (Math.abs z) else z
  
  return chunkVoxel

util.voxelToChunkVoxel = (x, y, z, chunkVoxel = []) ->
  x %= CX
  y %= CY
  z %= CZ
  
  chunkVoxel[0] = if x < 0 then CX - (Math.abs x) else x
  chunkVoxel[1] = if y < 0 then CY - (Math.abs y) else y
  chunkVoxel[2] = if z < 0 then CZ - (Math.abs z) else z
  
  return chunkVoxel