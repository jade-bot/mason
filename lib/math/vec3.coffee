module.exports = vec3 =
  xUnit: [1, 0, 0]
  yUnit: [0, 1, 0]
  zUnit: [0, 0, 1]
  xUnitInv: [-1, 0, 0]
  yUnitInv: [0, -1, 0]
  zUnitInv: [0, 0, -1]

MatrixArray = require './type'

vec3.create = (vec) ->
  out = new MatrixArray 3
  
  if vec
    out[0] = vec[0]
    out[1] = vec[1]
    out[2] = vec[2]
  else
    out[0] = out[1] = out[2] = 0

  out

vec3.add = (vec, vec2, out) ->
  if not out or vec is out
    vec[0] += vec2[0]
    vec[1] += vec2[1]
    vec[2] += vec2[2]
    
    return vec

  out[0] = vec[0] + vec2[0]
  out[1] = vec[1] + vec2[1]
  out[2] = vec[2] + vec2[2]
  
  out

vec3.set = (vec, dest) ->
  dest[0] = vec[0]
  dest[1] = vec[1]
  dest[2] = vec[2]
  
  dest

vec3.normalize = (vec, out) ->
  out = vec  unless out

  x = vec[0]
  y = vec[1]
  z = vec[2]
  
  len = Math.sqrt(x * x + y * y + z * z)
  
  unless len
    out[0] = 0
    out[1] = 0
    out[2] = 0
    return out
  else if len is 1
    out[0] = x
    out[1] = y
    out[2] = z
    return out

  len = 1 / len
  
  out[0] = x * len
  out[1] = y * len
  out[2] = z * len
  
  out

vec3.length = (vec) ->
  x = vec[0]
  y = vec[1]
  z = vec[2]

  Math.sqrt x * x + y * y + z * z

unprojectMat = null
unprojectVec = new MatrixArray 4

vec3.unproject = (vec, view, proj, viewport, dest) ->
  dest = vec unless dest
  
  unprojectMat = mat4.create() unless unprojectMat
  
  m = unprojectMat
  v = unprojectVec
  
  v[0] = (vec[0] - viewport[0]) * 2.0 / viewport[2] - 1.0
  v[1] = (vec[1] - viewport[1]) * 2.0 / viewport[3] - 1.0
  v[2] = 2.0 * vec[2] - 1.0
  v[3] = 1.0
  
  mat4.multiply proj, view, m
  return null unless mat4.inverse m
  
  mat4.multiplyVec4 m, v
  return null if v[3] is 0
  
  dest[0] = v[0] / v[3]
  dest[1] = v[1] / v[3]
  dest[2] = v[2] / v[3]
  
  dest

vec3.subtract = (vec, vec2, dest) ->
  if not dest or vec is dest
    vec[0] -= vec2[0]
    vec[1] -= vec2[1]
    vec[2] -= vec2[2]
    return vec
  
  dest[0] = vec[0] - vec2[0]
  dest[1] = vec[1] - vec2[1]
  dest[2] = vec[2] - vec2[2]

  dest

vec3.scale = (vec, val, out) ->
  if not out or vec is out
    vec[0] *= val
    vec[1] *= val
    vec[2] *= val
    return vec
  
  out[0] = vec[0] * val
  out[1] = vec[1] * val
  out[2] = vec[2] * val
  
  out