extractVoxel = require './voxel_extractor'

module.exports = extract = (volume, mesh) ->
  mesh = volume
  
  mesh.reset()
  
  for own key, voxel of volume.voxels
    extractVoxel voxel, volume, mesh