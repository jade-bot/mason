Mesh = require './mesh'

module.exports = class Axes extends Mesh
  constructor: (args = {}) ->
    super
    
    @size = 10
    
    @vertices = [
      [0, 0, 0]
      [@size, 0, 0]
      
      [0, 0, 0]
      [-@size, 0, 0]
      
      [0, 0, 0]
      [0, @size, 0]
      
      [0, 0, 0]
      [0, -@size, 0]
      
      [0, 0, 0]
      [0, 0, @size]
      
      [0, 0, 0]
      [0, 0, -@size]
    ]
    
    @colors = [
      [1, 0, 0, 1]
      [1, 0, 0, 1]

      [0, 1, 1, 1]
      [0, 1, 1, 1]

      [0, 1, 0, 1]
      [0, 1, 0, 1]

      [1, 0, 1, 1]
      [1, 0, 1, 1]

      [0, 0, 1, 1]
      [0, 0, 1, 1]

      [1, 1, 0, 1]
      [1, 1, 0, 1]
    ]
    
    @extract()
  
  upload: (gl) ->
    @buffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @buffer
    gl.bufferData gl.ARRAY_BUFFER, (new Float32Array @data), gl.STATIC_DRAW
    @buffer.size = 3
    @buffer.count = 12

    @mode = gl.LINES
  
  extract: ->
    @data = []
    
    for vertex, index in @vertices
      @data.push vertex[0], vertex[1], vertex[2]
      @data.push 0, 0
      color = @colors[index]
      @data.push color[0], color[1], color[2], color[3]