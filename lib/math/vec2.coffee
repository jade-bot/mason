MatrixArray = require './type'
{EPSILON} = (require './precision').FLOAT

module.exports = vec2 = {}

vec2.create = (vec) ->
  out = new MatrixArray 2
  
  if vec then [out[0], out[1]] = vec
  else out[0] = out[1] = 0
  
  out

vec2.equal = (a, b) ->
  return a is b or (
    Math.abs(a[0] - b[0]) < FLOAT_EPSILON and
    Math.abs(a[1] - b[1]) < FLOAT_EPSILON
  )