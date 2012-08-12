template = require './template'
texturing = require './texturing'

adjacent = vec3.create()

coords = {}

extractFace = (face, voxel, mesh) ->
  {vertices} = face
  [a, b, c, d] = vertices
  {position} = voxel
  
  texturing face, voxel, coords
  
  mesh.data.push a[0] + position[0], a[1] + position[1], a[2] + position[2]
  mesh.data.push coords.left, coords.bottom
  mesh.data.push 1, 0, 1, 1
  
  mesh.data.push b[0] + position[0], b[1] + position[1], b[2] + position[2]
  mesh.data.push coords.right, coords.bottom
  mesh.data.push 1, 0, 1, 1
  
  mesh.data.push c[0] + position[0], c[1] + position[1], c[2] + position[2]
  mesh.data.push coords.left, coords.top
  mesh.data.push 1, 0, 1, 1
  
  mesh.data.push d[0] + position[0], d[1] + position[1], d[2] + position[2]
  mesh.data.push coords.right, coords.top
  mesh.data.push 1, 0, 1, 1
  
  mesh.data.push c[0] + position[0], c[1] + position[1], c[2] + position[2]
  mesh.data.push coords.left, coords.top
  mesh.data.push 1, 0, 1, 1
  
  mesh.data.push b[0] + position[0], b[1] + position[1], b[2] + position[2]
  mesh.data.push coords.right, coords.bottom
  mesh.data.push 1, 0, 1, 1
  
  mesh.count += 6

module.exports = extract = (voxel, volume, mesh) ->
  for face in template.faces
    # continue unless (vec3.dot face.normal, camera.forward) > 0
    
    vec3.add face.normal, voxel.position, adjacent
    neighbor = volume.getVector adjacent
    if neighbor? and not neighbor?.type.transparent
      continue
    
    extractFace face, voxel, mesh