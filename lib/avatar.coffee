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
    
    @culling = off
    
    @jumping = no
  
  update: (time) ->
    super