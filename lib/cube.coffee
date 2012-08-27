Face = require './face'
Mesh = require './mesh'

template = {}

template.vertices = vertices = [
  [0, 0, 0]
  [0, 0, 1]
  [0, 1, 0]
  [0, 1, 1]
  [1, 0, 0]
  [1, 0, 1]
  [1, 1, 0]
  [1, 1, 1]
]

template.faces = faces = [
  new Face vertices: [vertices[0], vertices[1], vertices[2], vertices[3]], normal: [-1, +0, +0]
  new Face vertices: [vertices[5], vertices[4], vertices[7], vertices[6]], normal: [+1, +0, +0]
  
  new Face vertices: [vertices[5], vertices[1], vertices[4], vertices[0]], normal: [+0, -1, +0]
  new Face vertices: [vertices[3], vertices[7], vertices[2], vertices[6]], normal: [+0, +1, +0]
  
  new Face vertices: [vertices[4], vertices[0], vertices[6], vertices[2]], normal: [+0, +0, -1]
  new Face vertices: [vertices[1], vertices[5], vertices[3], vertices[7]], normal: [+0, +0, +1]
]

for key, index in ['left', 'right', 'bottom', 'top', 'back', 'front']
  faces[index].key = key

module.exports = class Cube extends Mesh
  constructor: (args = {}) ->
    super
    
    @template = template
    
    @aabb =
      min: [0, 0, 0]
      max: [1, 1, 1]
    
    @extract()
  
  extract: ->
    extractFace = (face, i, j, k, mesh) ->
      {vertices} = face
      [a, b, c, d] = vertices
      
      # texturing face, type, coords
      
      coords =
        left: 0
        bottom: 0
        right: 1
        top: 1
      {left, bottom, right, top} = coords
      
      alpha = 1
      
      # lighting face, neighbors, light
      light =
        al: 1
        bl: 1
        cl: 1
        dl: 1
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
    
    for face in faces
      extractFace face, 0, 0, 0, this