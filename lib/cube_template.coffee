Face = require './face'

module.exports = template = {}

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