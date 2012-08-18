template = require './template'
lighting = require './lighting'
texturing = require './texturing'

blocks = require '../../blocks'

adjacent = vec3.create()

coords = {}

light = {}

neighbors = {}

support = require '../support'

extractFace = (face, i, j, k, type, mesh, neighbors) ->
  {vertices} = face
  [a, b, c, d] = vertices
  
  texturing face, type, coords
  
  {left, bottom, right, top} = coords
  
  alpha = 1
  
  lighting face, neighbors, light
  {al, bl, cl, dl} = light
  
  mesh.data.push a[0] + i, a[1] + j, a[2] + k
  mesh.data.push left, bottom
  mesh.data.push al, al, al, alpha
  
  mesh.data.push b[0] + i, b[1] + j, b[2] + k
  mesh.data.push right, bottom
  mesh.data.push bl, bl, bl, alpha
  
  mesh.data.push c[0] + i, c[1] + j, c[2] + k
  mesh.data.push left, top
  mesh.data.push cl, cl, cl, alpha
  
  mesh.data.push d[0] + i, d[1] + j, d[2] + k
  mesh.data.push right, top
  mesh.data.push dl, dl, dl, alpha
  
  mesh.data.push c[0] + i, c[1] + j, c[2] + k
  mesh.data.push left, top
  mesh.data.push cl, cl, cl, alpha
  
  mesh.data.push b[0] + i, b[1] + j, b[2] + k
  mesh.data.push right, bottom
  mesh.data.push bl, bl, bl, alpha
  
  mesh.count += 6

module.exports = extract = (voxel, i, j, k, volume, mesh) ->
  for x in [-1..1]
    for y in [-1..1]
      for z in [-1..1]
        continue if y is 0 and y is 0 and z is 0
        neighbors[support.chunkKey x, y, z] = volume.get i + x, j + y, k + z
  
  for face in template.faces
    # continue unless (vec3.dot face.normal, camera.forward) > 0
    neighbor = volume.get i + face.normal[0], j + face.normal[1], k + face.normal[2]
    continue if neighbor?
    extractFace face, i, j, k, voxel, mesh, neighbors