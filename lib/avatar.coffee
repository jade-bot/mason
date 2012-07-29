Mesh = require './mesh'

module.exports = class Avatar extends Mesh
  constructor: (args = {}) ->
    super
    
    @vertices = []
    @normals = []
    @coords = []
    @indices = []
    @colors = []
    
    @vertices.push 0, 0, 0
    @vertices.push 1, 0, 0
    @vertices.push 1, 1, 0
    @vertices.push 0, 1, 0
    
    @normals.push 0, 0, 1
    @normals.push 0, 0, 1
    @normals.push 0, 0, 1
    @normals.push 0, 0, 1
    
    @coords.push 0.125, 0.125 * 2
    @coords.push 0.125 * 2, 0.125 * 2
    @coords.push 0.125 * 2, 0.125
    @coords.push 0.125, 0.125
    
    @indices.push 0, 1, 2
    @indices.push 0, 2, 3
    
    @colors.push 0, 0, 0, 1
    @colors.push 0, 0, 0, 1
    @colors.push 0, 0, 0, 1
    @colors.push 0, 0, 0, 1
    
    @count = 2
    
    @volume = args.volume
    
    @cell = "#{Math.floor @position[0]}:#{Math.floor @position[1]}:#{Math.floor @position[2]}"
    @previousCell = "#{Math.floor @position[0]}:#{Math.floor @position[1]}:#{Math.floor @position[2]}"
    
    @previousPosition = vec3.create @position
  
  update: (time) ->
    super
    
    @below = "#{Math.floor @position[0]}:#{(Math.floor @position[1]) - 1}:#{Math.floor @position[2]}"
    
    unless @volume.voxels[@below]?
      vec3.add @velocity, [0, -time * 9.81, 0]
    else
      # @position[1] = Math.floor @position[1]
      @velocity[1] = 0
      if (@position[1] - (Math.floor @position[1])) > 0.9
        @position[1] = Math.ceil @position[1]

    @cell = "#{Math.floor @position[0]}:#{Math.floor @position[1]}:#{Math.floor @position[2]}"
    
    if @volume.voxels[@cell]?
      vec3.set @previousPosition, @position
    
    @previousCell = @cell
    vec3.set @position, @previousPosition
    
    # @scale = [10, 10, 10]