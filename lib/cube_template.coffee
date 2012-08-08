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
  new Face vertices: [vertices[4], vertices[5], vertices[6], vertices[7]], normal: [+1, +0, +0]
  # new Face vertices: [vertices[0], vertices[1], vertices[2], vertices[3]], normal: [-1, +0, +0]
  # new Face vertices: [vertices[0], vertices[1], vertices[2], vertices[3]], normal: [-1, +0, +0]
  # new Face vertices: [vertices[0], vertices[1], vertices[2], vertices[3]], normal: [-1, +0, +0]
  # new Face vertices: [vertices[0], vertices[1], vertices[2], vertices[3]], normal: [-1, +0, +0]
]