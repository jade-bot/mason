module.exports = mat4 = {}

MatrixArray = require './type'
{EPSILON} = (require './precision').FLOAT

mat4.create = (mat) ->
  out = new MatrixArray 16
  
  if mat
    [out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7], out[8], out[9], out[10], out[11], out[12], out[13], out[14], out[15]] = mat
  
  out

mat4.equal = (a, b) ->
  return a is b or (
    Math.abs(a[0] - b[0]) < EPSILON and
    Math.abs(a[1] - b[1]) < EPSILON and
    Math.abs(a[2] - b[2]) < EPSILON and
    Math.abs(a[3] - b[3]) < EPSILON and
    Math.abs(a[4] - b[4]) < EPSILON and
    Math.abs(a[5] - b[5]) < EPSILON and
    Math.abs(a[6] - b[6]) < EPSILON and
    Math.abs(a[7] - b[7]) < EPSILON and
    Math.abs(a[8] - b[8]) < EPSILON and
    Math.abs(a[9] - b[9]) < EPSILON and
    Math.abs(a[10] - b[10]) < EPSILON and
    Math.abs(a[11] - b[11]) < EPSILON and
    Math.abs(a[12] - b[12]) < EPSILON and
    Math.abs(a[13] - b[13]) < EPSILON and
    Math.abs(a[14] - b[14]) < EPSILON and
    Math.abs(a[15] - b[15]) < EPSILON
  )

mat4.identity = (out) ->
  out ?= mat4.create()
  
  out[0] = 1
  out[1] = 0
  out[2] = 0
  out[3] = 0
  out[4] = 0
  out[5] = 1
  out[6] = 0
  out[7] = 0
  out[8] = 0
  out[9] = 0
  out[10] = 1
  out[11] = 0
  out[12] = 0
  out[13] = 0
  out[14] = 0
  out[15] = 1
  
  out

mat4.set = (mat, out) ->
  [out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7], out[8], out[9], out[10], out[11], out[12], out[13], out[14], out[15]] = mat

  out

mat4.multiply = (mat, mat2, out) ->
  out ?= mat
  
  [a00, a01, a02, a03, a10, a11, a12, a13, a20, a21, a22, a23, a30, a31, a32, a33] = mat
  
  b0 = mat2[0]
  b1 = mat2[1]
  b2 = mat2[2]
  b3 = mat2[3]
  out[0] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30
  out[1] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31
  out[2] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32
  out[3] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33
  b0 = mat2[4]
  b1 = mat2[5]
  b2 = mat2[6]
  b3 = mat2[7]
  out[4] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30
  out[5] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31
  out[6] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32
  out[7] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33
  b0 = mat2[8]
  b1 = mat2[9]
  b2 = mat2[10]
  b3 = mat2[11]
  out[8] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30
  out[9] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31
  out[10] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32
  out[11] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33
  b0 = mat2[12]
  b1 = mat2[13]
  b2 = mat2[14]
  b3 = mat2[15]
  out[12] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30
  out[13] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31
  out[14] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32
  out[15] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33
  out

mat4.multiplyVec4 = (mat, vec, out) ->
  out ?= vec
  
  [x, y, z, w] = vec
  
  out[0] = mat[0] * x + mat[4] * y + mat[8] * z + mat[12] * w
  out[1] = mat[1] * x + mat[5] * y + mat[9] * z + mat[13] * w
  out[2] = mat[2] * x + mat[6] * y + mat[10] * z + mat[14] * w
  out[3] = mat[3] * x + mat[7] * y + mat[11] * z + mat[15] * w
  
  out

mat4.translate = (mat, vec, out) ->
  [x, y, z] = vec
  
  if not out or mat is out
    mat[12] = mat[0] * x + mat[4] * y + mat[8] * z + mat[12]
    mat[13] = mat[1] * x + mat[5] * y + mat[9] * z + mat[13]
    mat[14] = mat[2] * x + mat[6] * y + mat[10] * z + mat[14]
    mat[15] = mat[3] * x + mat[7] * y + mat[11] * z + mat[15]
    
    return mat
  
  a00 = mat[0]
  a01 = mat[1]
  a02 = mat[2]
  a03 = mat[3]
  a10 = mat[4]
  a11 = mat[5]
  a12 = mat[6]
  a13 = mat[7]
  a20 = mat[8]
  a21 = mat[9]
  a22 = mat[10]
  a23 = mat[11]
  
  out[0] = a00
  out[1] = a01
  out[2] = a02
  out[3] = a03
  out[4] = a10
  out[5] = a11
  out[6] = a12
  out[7] = a13
  out[8] = a20
  out[9] = a21
  out[10] = a22
  out[11] = a23
  out[12] = a00 * x + a10 * y + a20 * z + mat[12]
  out[13] = a01 * x + a11 * y + a21 * z + mat[13]
  out[14] = a02 * x + a12 * y + a22 * z + mat[14]
  out[15] = a03 * x + a13 * y + a23 * z + mat[15]

  out

mat4.toMat3 = (mat, out) ->
  out ?= mat3.create()
  
  out[0] = mat[0]
  out[1] = mat[1]
  out[2] = mat[2]
  out[3] = mat[4]
  out[4] = mat[5]
  out[5] = mat[6]
  out[6] = mat[8]
  out[7] = mat[9]
  out[8] = mat[10]
  
  out

mat4.frustum = (left, right, bottom, top, near, far, out) ->
  out ?= mat4.create()
  
  rl = right - left
  tb = top - bottom
  fn = far - near

  out[0] = (near * 2) / rl
  out[1] = 0
  out[2] = 0
  out[3] = 0
  out[4] = 0
  out[5] = (near * 2) / tb
  out[6] = 0
  out[7] = 0
  out[8] = (right + left) / rl
  out[9] = (top + bottom) / tb
  out[10] = -(far + near) / fn
  out[11] = -1
  out[12] = 0
  out[13] = 0
  out[14] = -(far * near * 2) / fn
  out[15] = 0

  out

mat4.perspective = (fovy, aspect, near, far, out) ->
  top = near * (Math.tan fovy * Math.PI / 360)
  right = top * aspect
  mat4.frustum -right, right, -top, top, near, far, out

mat4.fromRotationTranslation = (quat, vec, out) ->
  out ?= mat4.create()
  
  [x, y, z, w] = quat

  x2 = x + x
  y2 = y + y
  z2 = z + z
  xx = x * x2
  xy = x * y2
  xz = x * z2
  yy = y * y2
  yz = y * z2
  zz = z * z2
  wx = w * x2
  wy = w * y2
  wz = w * z2

  out[0] = 1 - (yy + zz)
  out[1] = xy + wz
  out[2] = xz - wy
  out[3] = 0
  out[4] = xy - wz
  out[5] = 1 - (xx + zz)
  out[6] = yz + wx
  out[7] = 0
  out[8] = xz + wy
  out[9] = yz - wx
  out[10] = 1 - (xx + yy)
  out[11] = 0
  out[12] = vec[0]
  out[13] = vec[1]
  out[14] = vec[2]
  out[15] = 1

  out

mat4.inverse = (mat, out) ->
  out ?= mat
  
  [a00, a01, a02, a03, a10, a11, a12, a13, a20, a21, a22, a23, a30, a31, a32, a33] = mat
  
  b00 = a00 * a11 - a01 * a10
  b01 = a00 * a12 - a02 * a10
  b02 = a00 * a13 - a03 * a10
  b03 = a01 * a12 - a02 * a11
  b04 = a01 * a13 - a03 * a11
  b05 = a02 * a13 - a03 * a12
  b06 = a20 * a31 - a21 * a30
  b07 = a20 * a32 - a22 * a30
  b08 = a20 * a33 - a23 * a30
  b09 = a21 * a32 - a22 * a31
  b10 = a21 * a33 - a23 * a31
  b11 = a22 * a33 - a23 * a32
  
  d = (b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06)
  return unless d
  invDet = 1 / d
  
  out[0] = (a11 * b11 - a12 * b10 + a13 * b09) * invDet
  out[1] = (-a01 * b11 + a02 * b10 - a03 * b09) * invDet
  out[2] = (a31 * b05 - a32 * b04 + a33 * b03) * invDet
  out[3] = (-a21 * b05 + a22 * b04 - a23 * b03) * invDet
  out[4] = (-a10 * b11 + a12 * b08 - a13 * b07) * invDet
  out[5] = (a00 * b11 - a02 * b08 + a03 * b07) * invDet
  out[6] = (-a30 * b05 + a32 * b02 - a33 * b01) * invDet
  out[7] = (a20 * b05 - a22 * b02 + a23 * b01) * invDet
  out[8] = (a10 * b10 - a11 * b08 + a13 * b06) * invDet
  out[9] = (-a00 * b10 + a01 * b08 - a03 * b06) * invDet
  out[10] = (a30 * b04 - a31 * b02 + a33 * b00) * invDet
  out[11] = (-a20 * b04 + a21 * b02 - a23 * b00) * invDet
  out[12] = (-a10 * b09 + a11 * b07 - a12 * b06) * invDet
  out[13] = (a00 * b09 - a01 * b07 + a02 * b06) * invDet
  out[14] = (-a30 * b03 + a31 * b01 - a32 * b00) * invDet
  out[15] = (a20 * b03 - a21 * b01 + a22 * b00) * invDet

  out

mat4.rotate = (mat, angle, axis, out) ->
  [x, y, z] = axis
  
  len = Math.sqrt x * x + y * y + z * z
  
  return unless len
  if len isnt 1
    len = 1 / len
    x *= len
    y *= len
    z *= len
  
  s = Math.sin angle
  c = Math.cos angle
  t = 1 - c
  
  [a00, a01, a02, a03, a10, a11, a12, a13, a20, a21, a22, a23] = mat
  
  b00 = x * x * t + c
  b01 = y * x * t + z * s
  b02 = z * x * t - y * s
  b10 = x * y * t - z * s
  b11 = y * y * t + c
  b12 = z * y * t + x * s
  b20 = x * z * t + y * s
  b21 = y * z * t - x * s
  b22 = z * z * t + c
  
  unless out then out = mat
  else if mat isnt out
    out[12] = mat[12]
    out[13] = mat[13]
    out[14] = mat[14]
    out[15] = mat[15]
  
  out[0] = a00 * b00 + a10 * b01 + a20 * b02
  out[1] = a01 * b00 + a11 * b01 + a21 * b02
  out[2] = a02 * b00 + a12 * b01 + a22 * b02
  out[3] = a03 * b00 + a13 * b01 + a23 * b02
  out[4] = a00 * b10 + a10 * b11 + a20 * b12
  out[5] = a01 * b10 + a11 * b11 + a21 * b12
  out[6] = a02 * b10 + a12 * b11 + a22 * b12
  out[7] = a03 * b10 + a13 * b11 + a23 * b12
  out[8] = a00 * b20 + a10 * b21 + a20 * b22
  out[9] = a01 * b20 + a11 * b21 + a21 * b22
  out[10] = a02 * b20 + a12 * b21 + a22 * b22
  out[11] = a03 * b20 + a13 * b21 + a23 * b22

  out

mat4.toInverseMat3 = (mat, out) ->
  a00 = mat[0]
  a01 = mat[1]
  a02 = mat[2]
  a10 = mat[4]
  a11 = mat[5]
  a12 = mat[6]
  a20 = mat[8]
  a21 = mat[9]
  a22 = mat[10]
  b01 = a22 * a11 - a12 * a21
  b11 = -a22 * a10 + a12 * a20
  b21 = a21 * a10 - a11 * a20
  
  d = a00 * b01 + a01 * b11 + a02 * b21
  id = undefined
  return null unless d
  id = 1 / d
  
  out ?= mat3.create()
  
  out[0] = b01 * id
  out[1] = (-a22 * a01 + a02 * a21) * id
  out[2] = (a12 * a01 - a02 * a11) * id
  out[3] = b11 * id
  out[4] = (a22 * a00 - a02 * a20) * id
  out[5] = (-a12 * a00 + a02 * a10) * id
  out[6] = b21 * id
  out[7] = (-a21 * a00 + a01 * a20) * id
  out[8] = (a11 * a00 - a01 * a10) * id

  out

mat4.lookAt = (eye, center, up, out) ->
  out ?= mat4.create()
  
  [eyex, eyey, eyez] = eye
  
  [upx, upy, upz] = up
  
  [centerx, centery, centerz] = center
  
  return (mat4.identity out) if eyex is centerx and eyey is centery and eyez is centerz
  
  z0 = eyex - centerx
  z1 = eyey - centery
  z2 = eyez - centerz
  len = 1 / Math.sqrt z0 * z0 + z1 * z1 + z2 * z2
  z0 *= len
  z1 *= len
  z2 *= len
  
  x0 = upy * z2 - upz * z1
  x1 = upz * z0 - upx * z2
  x2 = upx * z1 - upy * z0
  len = Math.sqrt x0 * x0 + x1 * x1 + x2 * x2
  unless len
    x0 = 0
    x1 = 0
    x2 = 0
  else
    len = 1 / len
    x0 *= len
    x1 *= len
    x2 *= len
  
  y0 = z1 * x2 - z2 * x1
  y1 = z2 * x0 - z0 * x2
  y2 = z0 * x1 - z1 * x0
  len = Math.sqrt y0 * y0 + y1 * y1 + y2 * y2
  unless len
    y0 = 0
    y1 = 0
    y2 = 0
  else
    len = 1 / len
    y0 *= len
    y1 *= len
    y2 *= len
  
  out[0] = x0
  out[1] = y0
  out[2] = z0
  out[3] = 0
  out[4] = x1
  out[5] = y1
  out[6] = z1
  out[7] = 0
  out[8] = x2
  out[9] = y2
  out[10] = z2
  out[11] = 0
  out[12] = -(x0 * eyex + x1 * eyey + x2 * eyez)
  out[13] = -(y0 * eyex + y1 * eyey + y2 * eyez)
  out[14] = -(z0 * eyex + z1 * eyey + z2 * eyez)
  out[15] = 1
  
  out

mat4.scale = (mat, vec, out) ->
  [x, y, z] = vec

  if not out or mat is out
    mat[0] *= x
    mat[1] *= x
    mat[2] *= x
    mat[3] *= x
    mat[4] *= y
    mat[5] *= y
    mat[6] *= y
    mat[7] *= y
    mat[8] *= z
    mat[9] *= z
    mat[10] *= z
    mat[11] *= z
    
    return mat

  out[0] = mat[0] * x
  out[1] = mat[1] * x
  out[2] = mat[2] * x
  out[3] = mat[3] * x
  out[4] = mat[4] * y
  out[5] = mat[5] * y
  out[6] = mat[6] * y
  out[7] = mat[7] * y
  out[8] = mat[8] * z
  out[9] = mat[9] * z
  out[10] = mat[10] * z
  out[11] = mat[11] * z
  out[12] = mat[12]
  out[13] = mat[13]
  out[14] = mat[14]
  out[15] = mat[15]

  out