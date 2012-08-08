cubeTemplate = require './cube'

Mesh = require './mesh'

module.exports = class Volume extends Mesh
  adjacent: vec3.create()
  
  constructor: (args = {}) ->
    super
    
    @voxels = {}
    
    @vertices = []
    @normals = []
    @coords = []
    @indices = []
    @colors = []
    
    @color = [0, 0, 0, 1]
  
  extract: ->
    @vertices.length = 0
    @normals.length = 0
    @coords.length = 0
    @indices.length = 0
    @colors.length = 0
    
    faces = 0
    
    for own cubeKey, cube of @voxels
      for side, normal of cubeTemplate.faces
        vec3.add normal, cube.position, @adjacent
        
        next = @voxels["#{@adjacent[0]}:#{@adjacent[1]}:#{@adjacent[2]}"]
        
        if next? and not next?.type.transparent
          continue
        
        template =
          vertices: cubeTemplate.vertices[side]
          normals: cubeTemplate.normals[side]
          coords: cube.type.coords[side]
          indices: cubeTemplate.indices[side]
        
        for vertex in [0...template.vertices.length] by 3
          @vertices.push template.vertices[vertex + 0] + cube.position[0]
          @vertices.push template.vertices[vertex + 1] + cube.position[1]
          @vertices.push template.vertices[vertex + 2] + cube.position[2]
        
        for normal in template.normals
          @normals.push normal
        
        for coord in template.coords
          @coords.push coord
        
        for index in [0, 1, 2, 0, 2, 3]
          @indices.push index + (faces * 4)
        
        for i in [0...4]
          @colors.push @color...
        
        faces++
    
    @faces = faces
    @count = faces