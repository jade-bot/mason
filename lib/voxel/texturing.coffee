EPSILON = 0.00125

textures = require '../../textures'

size = 1 / 16

module.exports = (face, voxel, out) ->
  texture = textures[voxel.type.key]
  
  if voxel.type.textures?
    texture = voxel.type.textures[face.key]
  
  out.left = (texture[0] * size) + EPSILON
  out.right = ((texture[0] + 1) * size) - EPSILON
  out.top = (texture[1] * size) + EPSILON
  out.bottom = ((texture[1] + 1) * size) - EPSILON