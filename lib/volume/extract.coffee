extractVoxel = require '../voxel/extract'

module.exports = extract = (min, max, volume, mesh) ->
  mesh.reset()
  
  console.time 'extract'
  # console.profile 'extract'
  
  for i in [min[0]...max[0]]
    for j in [min[1]...max[1]]
      for k in [min[2]...max[2]]
        voxel = volume.get i, j, k
        continue unless voxel?
        extractVoxel voxel, volume, mesh
  
  # console.profileEnd 'extract'
  console.timeEnd 'extract'