Entity = require './entity'

module.exports = class Mesh extends Entity
  constructor: (args = {}) ->
    super
    
    @texture = args.texture
    
    @count = args.count
    
    @position = vec3.create args.position or []
    @rotation = vec3.create args.rotation or []
  
  upload: (gl) ->
    @positionBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @positionBuffer
    gl.bufferData gl.ARRAY_BUFFER, (new Float32Array @vertices), gl.STATIC_DRAW
    @positionBuffer.itemSize = 3
    @positionBuffer.numItems = 24 * @count
    
    @normalBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @normalBuffer
    gl.bufferData gl.ARRAY_BUFFER, (new Float32Array @normals), gl.STATIC_DRAW
    @normalBuffer.itemSize = 3
    @normalBuffer.numItems = 24 * @count
    
    @coordBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @coordBuffer
    gl.bufferData gl.ARRAY_BUFFER, (new Float32Array @coords), gl.STATIC_DRAW
    @coordBuffer.itemSize = 2
    @coordBuffer.numItems = 24 * @count
    
    @colorBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @colorBuffer
    gl.bufferData gl.ARRAY_BUFFER, (new Float32Array @colors), gl.STATIC_DRAW
    @colorBuffer.itemSize = 4
    @colorBuffer.numItems = 24 * @count
    
    @indexBuffer = gl.createBuffer()
    gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @indexBuffer
    gl.bufferData gl.ELEMENT_ARRAY_BUFFER, (new Uint16Array @indices), gl.STATIC_DRAW
    @indexBuffer.itemSize = 1
    @indexBuffer.numItems = 36 * @count