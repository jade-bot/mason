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

quat4.multiplyVec3 = (quat, vec, dest) ->
  dest = vec  unless dest
  x = vec[0]
  y = vec[1]
  z = vec[2]
  qx = quat[0]
  qy = quat[1]
  qz = quat[2]
  qw = quat[3]
  
  # calculate quat * vec
  ix = qw * x + qy * z - qz * y
  iy = qw * y + qz * x - qx * z
  iz = qw * z + qx * y - qy * x
  iw = -qx * x - qy * y - qz * z
  
  # calculate result * inverse quat
  dest[0] = ix * qw + iw * -qx + iy * -qz - iz * -qy
  dest[1] = iy * qw + iw * -qy + iz * -qx - ix * -qz
  dest[2] = iz * qw + iw * -qz + ix * -qy - iy * -qx
  dest

quat4.fromRotationMatrix = (mat, dest) ->
  dest = quat4.create()  unless dest
  
  # Algorithm in Ken Shoemake's article in 1987 SIGGRAPH course notes
  # article "Quaternion Calculus and Fast Animation".
  fTrace = mat[0] + mat[4] + mat[8]
  fRoot = undefined
  if fTrace > 0.0
    
    # |w| > 1/2, may as well choose w > 1/2
    fRoot = Math.sqrt(fTrace + 1.0) # 2w
    dest[3] = 0.5 * fRoot
    fRoot = 0.5 / fRoot # 1/(4w)
    dest[0] = (mat[7] - mat[5]) * fRoot
    dest[1] = (mat[2] - mat[6]) * fRoot
    dest[2] = (mat[3] - mat[1]) * fRoot
  else
    
    # |w| <= 1/2
    s_iNext = quat4.fromRotationMatrix.s_iNext = quat4.fromRotationMatrix.s_iNext or [1, 2, 0]
    i = 0
    i = 1  if mat[4] > mat[0]
    i = 2  if mat[8] > mat[i * 3 + i]
    j = s_iNext[i]
    k = s_iNext[j]
    fRoot = Math.sqrt(mat[i * 3 + i] - mat[j * 3 + j] - mat[k * 3 + k] + 1.0)
    dest[i] = 0.5 * fRoot
    fRoot = 0.5 / fRoot
    dest[3] = (mat[k * 3 + j] - mat[j * 3 + k]) * fRoot
    dest[j] = (mat[j * 3 + i] + mat[i * 3 + j]) * fRoot
    dest[k] = (mat[k * 3 + i] + mat[i * 3 + k]) * fRoot
  dest


###
Alias. See the description for quat4.fromRotationMatrix().
###
mat3.toQuat4 = quat4.fromRotationMatrix

quat4.fromAngleAxis = (angle, axis, dest) ->
  dest = quat4.create() unless dest
  
  half = angle * 0.5
  s = Math.sin half

  dest[3] = Math.cos half
  
  dest[0] = s * axis[0]
  dest[1] = s * axis[1]
  dest[2] = s * axis[2]

  dest

quat4.set = (quat, dest) ->
  dest[0] = quat[0]
  dest[1] = quat[1]
  dest[2] = quat[2]
  dest[3] = quat[3]
  dest
