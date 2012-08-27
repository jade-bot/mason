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

template.earVertices = earVertices = [
  [0, 0, 0]
  [0, 0, 0.25]
  [0, 0.25, 0]
  [0, 0.25, 0.25]
  [0.25, 0, 0]
  [0.25, 0, 0.25]
  [0.25, 0.25, 0]
  [0.25, 0.25, 0.25]
]

template.snoutVertices = snoutVertices = [
  [0, 0, 0]
  [0, 0, 0.25]
  [0, 0.25, 0]
  [0, 0.25, 0.25]
  [0.5, 0, 0]
  [0.5, 0, 0.25]
  [0.5, 0.25, 0]
  [0.5, 0.25, 0.25]
]

template.legVertices = legVertices = [
  [0, 0, 0]
  [0, 0, 0.25]
  [0, 1, 0]
  [0, 1, 0.25]
  [0.25, 0, 0]
  [0.25, 0, 0.25]
  [0.25, 1, 0]
  [0.25, 1, 0.25]
]

template.snoutFaces = snoutFaces = [
  new Face vertices: [snoutVertices[0], snoutVertices[1], snoutVertices[2], snoutVertices[3]], normal: [-1, +0, +0]
  new Face vertices: [snoutVertices[5], snoutVertices[4], snoutVertices[7], snoutVertices[6]], normal: [+1, +0, +0]
  
  new Face vertices: [snoutVertices[5], snoutVertices[1], snoutVertices[4], snoutVertices[0]], normal: [+0, -1, +0]
  new Face vertices: [snoutVertices[3], snoutVertices[7], snoutVertices[2], snoutVertices[6]], normal: [+0, +1, +0]
  
  new Face vertices: [snoutVertices[4], snoutVertices[0], snoutVertices[6], snoutVertices[2]], normal: [+0, +0, -1]
  new Face vertices: [snoutVertices[1], snoutVertices[5], snoutVertices[3], snoutVertices[7]], normal: [+0, +0, +1]
]

template.earFaces = earFaces = [
  new Face vertices: [earVertices[0], earVertices[1], earVertices[2], earVertices[3]], normal: [-1, +0, +0]
  new Face vertices: [earVertices[5], earVertices[4], earVertices[7], earVertices[6]], normal: [+1, +0, +0]
  
  new Face vertices: [earVertices[5], earVertices[1], earVertices[4], earVertices[0]], normal: [+0, -1, +0]
  new Face vertices: [earVertices[3], earVertices[7], earVertices[2], earVertices[6]], normal: [+0, +1, +0]
  
  new Face vertices: [earVertices[4], earVertices[0], earVertices[6], earVertices[2]], normal: [+0, +0, -1]
  new Face vertices: [earVertices[1], earVertices[5], earVertices[3], earVertices[7]], normal: [+0, +0, +1]
]

template.legFaces = legFaces = [
  new Face vertices: [legVertices[0], legVertices[1], legVertices[2], legVertices[3]], normal: [-1, +0, +0]
  new Face vertices: [legVertices[5], legVertices[4], legVertices[7], legVertices[6]], normal: [+1, +0, +0]
  
  new Face vertices: [legVertices[5], legVertices[1], legVertices[4], legVertices[0]], normal: [+0, -1, +0]
  new Face vertices: [legVertices[3], legVertices[7], legVertices[2], legVertices[6]], normal: [+0, +1, +0]
  
  new Face vertices: [legVertices[4], legVertices[0], legVertices[6], legVertices[2]], normal: [+0, +0, -1]
  new Face vertices: [legVertices[1], legVertices[5], legVertices[3], legVertices[7]], normal: [+0, +0, +1]
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

module.exports = class Wolf extends Mesh
  constructor: (args = {}) ->
    super
    
    @template = template
    
    # @aabb =
    #   min: [0, 0, 0]
    #   max: [1, 1, 1]
    
    @extract()
  
  extract: ->
    extractFace = (face, i, j, k, mesh, coords) ->
      {vertices} = face
      [a, b, c, d] = vertices
      
      # texturing face, type, coords
      
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
    
    coords =
      left: 0.046875
      bottom: 0.3125
      right: 0.171875
      top: 0.125
    for face in faces
      extractFace face, 0, 0, 0, this, coords
    
    coords =
      left: 0.046875
      bottom: 0.3125
      right: 0.171875
      top: 0.125
    for face in snoutFaces
      extractFace face, 0, 0, +0.5, this, coords
    
    coords =
      left: 0.4375
      bottom: 0.21875
      right: 0.5625
      top: 0
    for face in faces
      extractFace face, 0, 0, -0.5, this, coords
    
    coords =
      left: 0.25
      bottom: 0.53125
      right: 0.34375
      top: 0.4375
    for face in earFaces then extractFace face, -0.25, 1, -0.25, this, coords
    for face in earFaces then extractFace face, 0.25, 1, -0.25, this, coords
    
    for i in [-1..1]
      for k in [-1..1]
        continue if i is 0 or k is 0
        
        coords =
          left: 0
          bottom: 0.875
          right: 0.03125
          top: 0.625
        
        for face in legFaces
          extractFace face, (i * 0.5) + 0.5, -1, (k * 0.5) + 0.5, this, coords