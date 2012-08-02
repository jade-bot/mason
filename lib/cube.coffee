Mesh = require './mesh'

module.exports = cube = class Cube extends Mesh
  constructor: (args = {}) ->
    super
    
    @size = 1
    
    @vertices = [
      [-(@size / 2), -(@size / 2), -(@size / 2)]
      [-(@size / 2), -(@size / 2), +(@size / 2)]
      [-(@size / 2), +(@size / 2), -(@size / 2)]
      [-(@size / 2), +(@size / 2), +(@size / 2)]
      [+(@size / 2), -(@size / 2), -(@size / 2)]
      [+(@size / 2), -(@size / 2), +(@size / 2)]
      [+(@size / 2), +(@size / 2), -(@size / 2)]
      [+(@size / 2), +(@size / 2), +(@size / 2)]
    ]
    
    @faces = [
      [0, 1, 2, 3]
      [5, 4, 7, 6]
      [3, 7, 2, 6]
      [0, 4, 1, 5]
      [1, 5, 3, 7]
      [4, 0, 6, 2]
    ]
    
    @extract()
    
    # setInterval =>
    #   @rotateY 0.01
    # , 15
  
  upload: (gl) ->
    @buffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @buffer
    gl.bufferData gl.ARRAY_BUFFER, (new Float32Array @data), gl.STATIC_DRAW
    @buffer.size = 5
    @buffer.count = 36
  
  extract: ->
    @data = []
    
    for face in @faces
      @data.push @vertices[face[0]][0], @vertices[face[0]][1], @vertices[face[0]][2]
      @data.push 0, 0
      @data.push 1, 0, 0, 1
      @data.push @vertices[face[1]][0], @vertices[face[1]][1], @vertices[face[1]][2]
      @data.push 1, 0
      @data.push 1, 0, 0, 1
      @data.push @vertices[face[2]][0], @vertices[face[2]][1], @vertices[face[2]][2]
      @data.push 0, 1
      @data.push 1, 0, 0, 1
      
      @data.push @vertices[face[2]][0], @vertices[face[2]][1], @vertices[face[2]][2]
      @data.push 0, 1
      @data.push 1, 0, 0, 1
      @data.push @vertices[face[1]][0], @vertices[face[1]][1], @vertices[face[1]][2]
      @data.push 1, 0
      @data.push 1, 0, 0, 1
      @data.push @vertices[face[3]][0], @vertices[face[3]][1], @vertices[face[3]][2]
      @data.push 1, 1
      @data.push 1, 0, 0, 1

cube.vertices =
  front: [
    +0.0, +0.0, +1.0
    +1.0, +0.0, +1.0
    +1.0, +1.0, +1.0
    +0.0, +1.0, +1.0
  ]

  back: [
    +0.0, +0.0, +0.0
    +0.0, +1.0, +0.0
    +1.0, +1.0, +0.0
    +1.0, +0.0, +0.0
  ]

  top: [
    +0.0, +1.0, +0.0
    +0.0, +1.0, +1.0
    +1.0, +1.0, +1.0
    +1.0, +1.0, +0.0
  ]

  bottom: [
    +0.0, +0.0, +0.0
    +1.0, +0.0, +0.0
    +1.0, +0.0, +1.0
    +0.0, +0.0, +1.0
  ]
  
  right: [
    +1.0, +0.0, +0.0
    +1.0, +1.0, +0.0
    +1.0, +1.0, +1.0
    +1.0, +0.0, +1.0
  ]
  
  left: [
    +0.0, +0.0, +0.0
    +0.0, +0.0, +1.0
    +0.0, +1.0, +1.0
    +0.0, +1.0, +0.0
  ]

cube.normals =
  front: [
    +0.0, +0.0, +1.0
    +0.0, +0.0, +1.0
    +0.0, +0.0, +1.0
    +0.0, +0.0, +1.0
  ]
  
  back: [
    +0.0, +0.0, -1.0
    +0.0, +0.0, -1.0
    +0.0, +0.0, -1.0
    +0.0, +0.0, -1.0
  ]
  
  top: [
    +0.0, +1.0, +0.0
    +0.0, +1.0, +0.0
    +0.0, +1.0, +0.0
    +0.0, +1.0, +0.0
  ]
  
  bottom: [
    +0.0, -1.0, +0.0
    +0.0, -1.0, +0.0
    +0.0, -1.0, +0.0
    +0.0, -1.0, +0.0
  ]
  
  right: [
    +1.0, +0.0, +0.0
    +1.0, +0.0, +0.0
    +1.0, +0.0, +0.0
    +1.0, +0.0, +0.0
  ]
  
  left: [
    -1.0, +0.0, +0.0
    -1.0, +0.0, +0.0
    -1.0, +0.0, +0.0
    -1.0, +0.0, +0.0
  ]

cube.coords =
  front: [
    0.0, 0.0
    1.0, 0.0
    1.0, 1.0
    0.0, 1.0
  ]
  
  back: [
    1.0, 0.0
    1.0, 1.0
    0.0, 1.0
    0.0, 0.0
  ]
  
  top: [
    0.0, 1.0
    0.0, 0.0
    1.0, 0.0
    1.0, 1.0
  ]
  
  bottom: [
    1.0, 1.0
    0.0, 1.0
    0.0, 0.0
    1.0, 0.0
  ]
  
  right: [
    1.0, 0.0
    1.0, 1.0
    0.0, 1.0
    0.0, 0.0
  ]
  
  left: [
    0.0, 0.0
    1.0, 0.0
    1.0, 1.0
    0.0, 1.0
  ]

cube.indices =
  front:  [0,  1,  2,  0,  2,  3]
  back:   [4,  5,  6,  4,  6,  7]
  top:    [8,  9,  10, 8,  10, 11]
  bottom: [12, 13, 14, 12, 14, 15]
  right:  [16, 17, 18, 16, 18, 19]
  left:   [20, 21, 22, 20, 22, 23]