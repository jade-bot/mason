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
    
    @drawMode = WebGLRenderingContext.LINES
    
    @extract()
  
  extract: ->
    @data = []
    
    for vertex, index in @vertices
      @data.push vertex[0], vertex[1], vertex[2]
      @data.push 0, 0
      color = @colors[index]
      @data.push color[0], color[1], color[2], color[3]
    
    @count = 12