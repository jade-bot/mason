extractVoxel = require '../voxel/extract'

blocks = require '../../blocks'

module.exports = extract = (min, max, volume, mesh) ->
  mesh.reset()
  
  console.time 'extract'
  
  for i in [min[0]...max[0]]
    for j in [min[1]...max[1]]
      for k in [min[2]...max[2]]
        voxel = volume.get i, j, k
        
        continue unless voxel?
        
        # skip air
        continue if voxel is blocks.air
        extractVoxel voxel, i, j, k, volume, mesh
  
  console.timeEnd 'extract'