Mesh = require './mesh'

module.exports = class Line extends Mesh
  constructor: (args = {}) ->
    super
    
    @vertices = []
    @normals = []
    @coords = []
    @indices = []
    @colors = []
    
    @points ?= args.points or []
    
    @color = [1, 0, 1, 1]
    
    @extract()
    
    @mode = WebGLRenderingContext.LINES

  scaffold: ->
    @verts = []
    for i in [0..1]
      for j in [0..1]
        for k in [0..1]
          @verts.push [i, j, k]

    for vertA in @verts
      for vertB in @verts
        unless vertA is vertB
          @points.push vertA
          @points.push vertB

    @extract()
  
  extract: ->
    @vertices.length = 0
    @normals.length = 0
    @coords.length = 0
    @indices.length = 0
    @colors.length = 0

    for point, index in @points
      @vertices.push point...
      @coords.push 0, 0
      @colors.push @color...
      @indices.push index
      @normals.push 0, 1, 0