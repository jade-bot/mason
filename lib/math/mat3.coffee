module.exports = mat3 = {}

MatrixArray = require './type'

mat3.create = (mat) ->
  out = new MatrixArray 9
  
  if mat
    out[0] = mat[0]
    out[1] = mat[1]
    out[2] = mat[2]
    out[3] = mat[3]
    out[4] = mat[4]
    out[5] = mat[5]
    out[6] = mat[6]
    out[7] = mat[7]
    out[8] = mat[8]
  else
    out[0] = out[1] = out[2] = out[3] = out[4] = out[5] = out[6] = out[7] = out[8] = 0
  
  out

mat3.transpose = (mat, out) ->
  
  # If we are transposing ourselves we can skip a few steps but have to cache some values
  if not out or mat is out
    a01 = mat[1]
    a02 = mat[2]
    a12 = mat[5]
    mat[1] = mat[3]
    mat[2] = mat[6]
    mat[3] = a01
    mat[5] = mat[7]
    mat[6] = a02
    mat[7] = a12
    return mat
  
  out[0] = mat[0]
  out[1] = mat[3]
  out[2] = mat[6]
  out[3] = mat[1]
  out[4] = mat[4]
  out[5] = mat[7]
  out[6] = mat[2]
  out[7] = mat[5]
  out[8] = mat[8]

  out