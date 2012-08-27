support = require '../support'

module.exports = collision = {}

testInterval = (s1, f1, s2, f2) -> !(s2 > f1 || s1 > f2)

testAABB = (a, b) ->
  return false unless testInterval a.min[0], a.max[0], b.min[0], b.max[0]
  return false unless testInterval a.min[1], a.max[1], b.min[1], b.max[1]
  return false unless testInterval a.min[2], a.max[2], b.min[2], b.max[2]
  return true

temp = vec3.create()
voxel = vec3.create()
dimensions = [1, 1, 1]
a = min: vec3.create(), max: vec3.create()
b = min: vec3.create(), max: vec3.create()
offset = [0, -1.6, 0]

collision.collide = (subject, volume) ->
  vec3.set subject.position, temp
  vec3.add offset, temp
  
  support.voxelVector temp, voxel
  
  vec3.set voxel, a.min
  vec3.set voxel, a.max
  vec3.add dimensions, a.max
  
  for i in [voxel[0]-1..voxel[0]+1]
    for j in [voxel[1]-1..voxel[1]+1]
      for k in [voxel[2]-1..voxel[2]+1]
        continue unless (volume.get i, j, k)?
        
        b.min[0] = i ; b.min[1] = j ; b.min[2] = k
        vec3.set b.min, b.max
        vec3.add dimensions, b.max
        
        return [i, j, k] if testAABB a, b
  
  return false