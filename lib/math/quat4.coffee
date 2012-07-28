module.exports = quat4 = {}

MatrixArray = require './type'

quat4.create = (quat) ->
  dest = new MatrixArray 4

  if quat
    dest[0] = quat[0]
    dest[1] = quat[1]
    dest[2] = quat[2]
    dest[3] = quat[3]
  else
    dest[0] = dest[1] = dest[2] = dest[3] = 0
  dest

quat4.multiply = (quat, quat2, dest) ->
  dest = quat unless dest

  qax = quat[0]
  qay = quat[1]
  qaz = quat[2]
  qaw = quat[3]
  qbx = quat2[0]
  qby = quat2[1]
  qbz = quat2[2]
  qbw = quat2[3]

  dest[0] = qax * qbw + qaw * qbx + qay * qbz - qaz * qby
  dest[1] = qay * qbw + qaw * qby + qaz * qbx - qax * qbz
  dest[2] = qaz * qbw + qaw * qbz + qax * qby - qay * qbx
  dest[3] = qaw * qbw - qax * qbx - qay * qby - qaz * qbz

  dest

quat4.fromAngleAxis = (angle, axis, dest) ->
  dest = quat4.create() unless dest
  
  half = angle * 0.5
  s = Math.sin half

  dest[3] = Math.cos half
  
  dest[0] = s * axis[0]
  dest[1] = s * axis[1]
  dest[2] = s * axis[2]

  dest
