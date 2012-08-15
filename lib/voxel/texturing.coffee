EPSILON = 0.00125

textures = require '../../textures'

size = 1 / 16

module.exports = (face, type, out) ->
  texture = textures[type.key]
  
  if type.textures?
    texture = type.textures[face.key]
  
  out.left = (texture[0] * size) + EPSILON
  out.right = ((texture[0] + 1) * size) - EPSILON
  out.top = (texture[1] * size) + EPSILON
  out.bottom = ((texture[1] + 1) * size) - EPSILON