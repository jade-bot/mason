module.exports = quat4 = {}

MatrixArray = require './type'
{EPSILON} = (require './precision').FLOAT

quat4.create = (quat) ->
  out = new MatrixArray 4

  if quat
    out[0] = quat[0]
    out[1] = quat[1]
    out[2] = quat[2]
    out[3] = quat[3]
  else
    out[0] = out[1] = out[2] = out[3] = 0
  out

quat4.equal = (a, b) ->
  return a is b or (
    Math.abs(a[0] - b[0]) < FLOAT_EPSILON and
    Math.abs(a[1] - b[1]) < FLOAT_EPSILON and
    Math.abs(a[2] - b[2]) < FLOAT_EPSILON and
    Math.abs(a[3] - b[3]) < FLOAT_EPSILON
  )

quat4.toAngleAxis = (src, out) ->
  out = src  unless out
  
  # The quaternion representing the rotation is
  #   q = cos(A/2)+sin(A/2)*(x*i+y*j+z*k)
  sqrlen = src[0] * src[0] + src[1] * src[1] + src[2] * src[2]
  if sqrlen > 0
    out[3] = 2 * Math.acos(src[3])
    invlen = glMath.invsqrt(sqrlen)
    out[0] = src[0] * invlen
    out[1] = src[1] * invlen
    out[2] = src[2] * invlen
  else
    
    # angle is 0 (mod 2*pi), so any axis will do
    out[3] = 0
    out[0] = 1
    out[1] = 0
    out[2] = 0
  out

quat4.multiply = (quat, quat2, out) ->
  out = quat unless out

  qax = quat[0]
  qay = quat[1]
  qaz = quat[2]
  qaw = quat[3]

  qbx = quat2[0]
  qby = quat2[1]
  qbz = quat2[2]
  qbw = quat2[3]

  out[0] = qax * qbw + qaw * qbx + qay * qbz - qaz * qby
  out[1] = qay * qbw + qaw * qby + qaz * qbx - qax * qbz
  out[2] = qaz * qbw + qaw * qbz + qax * qby - qay * qbx
  out[3] = qaw * qbw - qax * qbx - qay * qby - qaz * qbz

  out

quat4.multiplyVec3 = (quat, vec, out) ->
  out = vec  unless out
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
  out[0] = ix * qw + iw * -qx + iy * -qz - iz * -qy
  out[1] = iy * qw + iw * -qy + iz * -qx - ix * -qz
  out[2] = iz * qw + iw * -qz + ix * -qy - iy * -qx
  out

quat4.fromRotationMatrix = (mat, out) ->
  out = quat4.create()  unless out
  
  # Algorithm in Ken Shoemake's article in 1987 SIGGRAPH course notes
  # article "Quaternion Calculus and Fast Animation".
  fTrace = mat[0] + mat[4] + mat[8]
  fRoot = undefined
  if fTrace > 0.0
    
    # |w| > 1/2, may as well choose w > 1/2
    fRoot = Math.sqrt(fTrace + 1.0) # 2w
    out[3] = 0.5 * fRoot
    fRoot = 0.5 / fRoot # 1/(4w)
    out[0] = (mat[7] - mat[5]) * fRoot
    out[1] = (mat[2] - mat[6]) * fRoot
    out[2] = (mat[3] - mat[1]) * fRoot
  else
    
    # |w| <= 1/2
    s_iNext = quat4.fromRotationMatrix.s_iNext = quat4.fromRotationMatrix.s_iNext or [1, 2, 0]
    i = 0
    i = 1  if mat[4] > mat[0]
    i = 2  if mat[8] > mat[i * 3 + i]
    j = s_iNext[i]
    k = s_iNext[j]
    fRoot = Math.sqrt(mat[i * 3 + i] - mat[j * 3 + j] - mat[k * 3 + k] + 1.0)
    out[i] = 0.5 * fRoot
    fRoot = 0.5 / fRoot
    out[3] = (mat[k * 3 + j] - mat[j * 3 + k]) * fRoot
    out[j] = (mat[j * 3 + i] + mat[i * 3 + j]) * fRoot
    out[k] = (mat[k * 3 + i] + mat[i * 3 + k]) * fRoot
  out


###
Alias. See the description for quat4.fromRotationMatrix().
###
mat3.toQuat4 = quat4.fromRotationMatrix

quat4.normalize = (quat, out) ->
  out = quat unless out
  
  x = quat[0]
  y = quat[1]
  z = quat[2]
  w = quat[3]
  
  len = Math.sqrt(x * x + y * y + z * z + w * w)
  if len is 0
    out[0] = 0
    out[1] = 0
    out[2] = 0
    out[3] = 0
    return out
  
  len = 1 / len
  
  out[0] = x * len
  out[1] = y * len
  out[2] = z * len
  out[3] = w * len

  out

quat4.yaw = (quat) ->
  [x, y, z, w] = quat
  
  2 * Math.acos w

quat4.pitch = (quat) ->
  [x, y, z, w] = quat
  
  Math.atan2 2 * (y*z + w*x), w*w - x*x - y*y + z*z

quat4.roll = (quat) ->
  [x, y, z, w] = quat
  
  Math.atan2 2 * (x * y + w * z), w * w + x * x - y * y - z * z

quat4.fromAngleAxis = (angle, axis, out) ->
  out = quat4.create() unless out
  
  half = angle * 0.5
  s = Math.sin half

  out[3] = Math.cos half
  
  out[0] = s * axis[0]
  out[1] = s * axis[1]
  out[2] = s * axis[2]

  out

quat4.set = (quat, out) ->
  out[0] = quat[0]
  out[1] = quat[1]
  out[2] = quat[2]
  out[3] = quat[3]

  out
