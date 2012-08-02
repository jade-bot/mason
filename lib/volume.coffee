uuid = require 'node-uuid'

cubeTemplate = require './cube'

Mesh = require './mesh'

module.exports = class Volume extends Mesh
  constructor: (args = {}) ->
    super
    
    @blocks = args.blocks
    
    @voxels = {}
    
    @vertices = []
    @normals = []
    @coords = []
    @indices = []
    @colors = []
    
    @terraform()
    @extract()
  
  extract: ->
    faces = 0
    adjacent = vec3.create()
    
    for own cubeKey, cube of @voxels
      fm =
        front:  [+0, +0, +1]
        back:   [+0, +0, -1]
        top:    [+0, +1, +0]
        bottom: [+0, -1, +0]
        right:  [+1, +0, +0]
        left:   [-1, +0, +0]
      
      for side, normal of fm
        vec3.add normal, cube.position, adjacent
        
        next = @voxels["#{adjacent[0]}:#{adjacent[1]}:#{adjacent[2]}"]
        
        if next? and not next?.type.transparent
          continue
        
        template =
          vertices: cubeTemplate.vertices[side]
          normals: cubeTemplate.normals[side]
          coords: cube.type.coords[side] # cubeTemplate.coords[side]
          indices: cubeTemplate.indices[side]
        
        color = [0, 0, 0, 1]
        
        for vertex in [0...template.vertices.length] by 3
          @vertices.push template.vertices[vertex + 0] + cube.position[0] # + @position[0]
          @vertices.push template.vertices[vertex + 1] + cube.position[1] # + @position[1]
          @vertices.push template.vertices[vertex + 2] + cube.position[2] # + @position[2]
        
        for normal in template.normals
          @normals.push normal
        
        for coord in template.coords
          @coords.push coord
        
        for index in [0, 1, 2, 0, 2, 3] # template.indices
          @indices.push index + (faces * 4)
        
        for i in [0...4]
          @colors.push color[0] ; @colors.push color[1] ; @colors.push color[2] ; @colors.push color[3]
        
        faces++
    
    @faces = faces
    @count = faces
  
  terraform: ->
    woods = []
    
    for i in [0...16]
      for j in [0...128]
        for k in [0...16]
          if j > 64
            continue
          
          if j is 64
            type = null
            
            if Math.random() < 0.01
              type ?= @blocks.wood
            
            if Math.random() < 0.05
              type ?= @blocks.chest

            if Math.random() < 0.05
              type ?= @blocks.crafting_table

            if Math.random() < 0.05
              type ?= @blocks.planks

            if Math.random() < 0.05
              type ?= @blocks.furnace

            if Math.random() < 0.05
              type ?= @blocks.bush

            if Math.random() < 0.05
              type ?= @blocks.glass

            continue unless type?
          
          type = @blocks.grass if j is 63
          type = @blocks.dirt if j < 63
          type = @blocks.stone if j < 50
          
          if j < 50
            if Math.random() < 0.05
              type = @blocks.coal

            if Math.random() < 0.05
              type = @blocks.gold

            if Math.random() < 0.05
              type = @blocks.iron
            
            continue if Math.random() < 0.1

          if type is @blocks.wood
            woods.push cube
            continue
          
          cube =
            id: uuid()
            type: type or @blocks[Object.keys(@blocks)[Math.floor (Math.random() * Object.keys(@blocks).length)]]
            position: [i, j, k]
          cube.key = "#{cube.position[0]}:#{cube.position[1]}:#{cube.position[2]}"
          @voxels[cube.key] = cube
    
    for wood in woods
      height = (Math.random() * 10) + 5
      
      for i in [wood.position[1]...wood.position[1] + height]
        cube =
          id: uuid()
          type: @blocks.wood
          position: [wood.position[0], i, wood.position[2]]
        cube.key = "#{cube.position[0]}:#{cube.position[1]}:#{cube.position[2]}"
        @voxels[cube.key] = cube
      
      for i in [-1..1]
        for j in [-1..1]
          for k in [-1..1]
            if Math.random() > 0.25
              leaf =
                id: uuid()
                type: @blocks.leaf
                position: [wood.position[0] + i, wood.position[1] + j + height, wood.position[2] + k]
              leaf.key = "#{leaf.position[0]}:#{leaf.position[1]}:#{leaf.position[1]}:#{leaf.position[2]}"
              @voxels[leaf.key] = leaf