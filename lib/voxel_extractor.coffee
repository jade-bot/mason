template = require './cube_template'

adjacent = vec3.create()

extractFace = (face, voxel, volume) ->
  {vertices} = face
  [a, b, c, d] = vertices
  {position} = voxel
  
  volume.data.push a[0] + position[0], a[1] + position[1], a[2] + position[2]
  volume.data.push 0, 0
  volume.data.push 1, 0, 1, 1
  
  volume.data.push b[0] + position[0], b[1] + position[1], b[2] + position[2]
  volume.data.push 1, 0
  volume.data.push 1, 0, 1, 1
  
  volume.data.push c[0] + position[0], c[1] + position[1], c[2] + position[2]
  volume.data.push 0, 1
  volume.data.push 1, 0, 1, 1
  
  volume.data.push d[0] + position[0], d[1] + position[1], d[2] + position[2]
  volume.data.push 1, 1
  volume.data.push 1, 0, 1, 1
  
  volume.data.push c[0] + position[0], c[1] + position[1], c[2] + position[2]
  volume.data.push 0, 1
  volume.data.push 1, 0, 1, 1
  
  volume.data.push b[0] + position[0], b[1] + position[1], b[2] + position[2]
  volume.data.push 1, 0
  volume.data.push 1, 0, 1, 1
  
  volume.count += 6

module.exports = extract = (voxel, volume) ->
  for face in template.faces
    vec3.add face.normal, voxel.position, adjacent
    neighbor = volume.getVector adjacent
    if neighbor? and not neighbor?.type.transparent
      continue
    
    extractFace face, voxel, volume