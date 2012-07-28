module.exports = vec3 = {}

MatrixArray = require './type'

vec3.create = (vec) ->
  dest = new MatrixArray 3
  
  if vec
    dest[0] = vec[0]
    dest[1] = vec[1]
    dest[2] = vec[2]
  else
    dest[0] = dest[1] = dest[2] = 0

  dest

vec3.normalize = (vec, dest) ->
  dest = vec  unless dest

  x = vec[0]
  y = vec[1]
  z = vec[2]
  
  len = Math.sqrt(x * x + y * y + z * z)
  
  unless len
    dest[0] = 0
    dest[1] = 0
    dest[2] = 0
    return dest
  else if len is 1
    dest[0] = x
    dest[1] = y
    dest[2] = z
    return dest

  len = 1 / len
  
  dest[0] = x * len
  dest[1] = y * len
  dest[2] = z * len
  
  dest

vec3.scale = (vec, val, dest) ->
  if not dest or vec is dest
    vec[0] *= val
    vec[1] *= val
    vec[2] *= val
    return vec
  
  dest[0] = vec[0] * val
  dest[1] = vec[1] * val
  dest[2] = vec[2] * val
  
  dest