# module.exports = (start, end, callback) ->
#   CELL_SIDE = 1
  
#   [i, j, k] = start
  
#   # i = Math.floor i
#   # j = Math.floor j
#   # k = Math.floor k
  
#   [iend, jend, kend] = end
  
#   di = if i < iend then 1 else (if i > iend then -1 else 0)
#   dj = if j < jend then 1 else (if j > jend then -1 else 0)
#   dk = if k < kend then 1 else (if k > kend then -1 else 0)
  
#   minx = Math.floor i
#   miny = Math.floor j
#   minz = Math.floor k
  
#   maxx = minx + CELL_SIDE
#   maxy = miny + CELL_SIDE
#   maxz = minz + CELL_SIDE
  
#   tx = (if i < iend then i - minx else maxx - i) / (Math.abs iend - i)
#   ty = (if j < jend then j - miny else maxy - j) / (Math.abs jend - j)
#   tz = (if k < kend then k - minz else maxz - k) / (Math.abs kend - k)
  
#   deltatx = CELL_SIDE / (Math.abs iend - i)
#   deltaty = CELL_SIDE / (Math.abs jend - j)
#   deltatz = CELL_SIDE / (Math.abs kend - k)
  
#   while true
#     # console.log i, j, k
#     break if callback (Math.floor i), (Math.floor j), (Math.floor k)
    
#     if tx <= ty and tx <= tz
#       if i is iend then break
#       tx += deltatx
#       i += di
    
#     else if ty <= tx and ty <= tz
#       if j is jend then break
#       ty += deltaty
#       j += dj
      
#     else
#       if k is kend then break
#       tz += deltatz
#       k += dk

# smallest positive t such that s+t*ds is an integer
intbound = (s, ds) ->
  if ds < 0
    intbound -s, -ds
  else
    s = mod s, 1
    
    return (1 - s) / ds

signum = (x) ->
  return (if x > 0 then 1 else (if x < 0 then -1 else 0))

mod = (value, modulus) ->
  return (value % modulus + modulus) % modulus

wx = 128
wy = 128
wz = 128

module.exports = raycast = (origin, direction, callback, radius = 30) ->
  x = Math.floor origin[0]
  y = Math.floor origin[1]
  z = Math.floor origin[2]
  
  dx = direction[0]
  dy = direction[1]
  dz = direction[2]
  
  stepX = signum dx
  stepY = signum dy
  stepZ = signum dz
  
  tMaxX = intbound origin[0], dx
  tMaxY = intbound origin[1], dy
  tMaxZ = intbound origin[2], dz
  
  tDeltaX = stepX / dx
  tDeltaY = stepY / dy
  tDeltaZ = stepZ / dz
  
  face = vec3.create()
  
  if dx is 0 and dy is 0 and dz is 0
    throw new Error 'Raycast in zero direction!'
  
  radius /= Math.sqrt (dx * dx) + (dy * dy) + (dz * dz)
  
  console.log stepX, stepY, stepZ, dx, dy, dz, tDeltaX, tDeltaY, tDeltaZ
  
  while true # ((if stepX > 0 then x < wx else x >= 0)) and ((if stepY > 0 then y < wy else y >= 0)) and ((if stepZ > 0 then z < wz else z >= 0))
    # check inside world
    # unless x < 0 or y < 0 or z < 0 or x >= wx or y >= wy or z >= wz
    
    console.log x, y, z
    
    break if callback x, y, z, face
    
    if tMaxX < tMaxY
      if tMaxX < tMaxZ
        break if tMaxX > radius
        
        x += stepX
        
        tMaxX += tDeltaX
        
        face[0] = -stepX
        face[1] = 0
        face[2] = 0
      else
        break if tMaxZ > radius
        
        z += stepZ
        
        tMaxZ += tDeltaZ
        
        face[0] = 0
        face[1] = 0
        face[2] = -stepZ
    else
      if tMaxY < tMaxZ
        break if tMaxY > radius
        
        y += stepY
        
        tMaxY += tDeltaY
        
        face[0] = 0
        face[1] = -stepY
        face[2] = 0
      else
        break if tMaxZ > radius
        
        z += stepZ
        
        tMaxZ += tDeltaZ
        
        face[0] = 0
        face[1] = 0
        face[2] = -stepZ