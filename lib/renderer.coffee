Entity = require './entity'

module.exports = class Renderer extends Entity
  constructor: (args = {}) ->
    super
    
    @materials ?= args.materials or {}
    
    @canvas = args.canvas
    
    @db = {}
    
    @setup()
    
    @paused = no
    window.addEventListener 'blur', =>
      @paused = yes
      @emit 'pause'
    
    window.addEventListener 'focus', =>
      @paused = no
      @emit 'resume'
    
    tick = =>
      requestAnimationFrame tick
      
      @emit 'tick' unless @paused
    
    tick()
  
  setup: ->
    @gl = @canvas.getContext 'experimental-webgl', alpha: off
    
    @reset()
  
  reset: ->
    @gl.viewport 0, 0, @gl.canvas.width, @gl.canvas.height
    @clearMode = @gl.COLOR_BUFFER_BIT | @gl.DEPTH_BUFFER_BIT
    @gl.clearColor 0, 0, 0, 0.9
    @gl.enable @gl.DEPTH_TEST
    @gl.enable @gl.CULL_FACE
  
  lookup: (entity) ->
    @db[entity.id] ?=
      buffer: null
      program: null
      entity: entity
  
  getShader: (type, source) ->
    shader = @gl.createShader type
    @gl.shaderSource shader, source
    @gl.compileShader shader
    
    return shader
  
  uploadMesh: (mount) ->
    mount.buffer ?= @gl.createBuffer()
    @gl.bindBuffer @gl.ARRAY_BUFFER, mount.buffer
    @gl.bufferData @gl.ARRAY_BUFFER, (new Float32Array mount.entity.data), @gl.STATIC_DRAW
  
  uploadImage: (mount) ->
    {entity} = mount
    {material} = entity
    
    texture = @gl.createTexture()
    
    @gl.pixelStorei @gl.UNPACK_FLIP_Y_WEBGL, off
    
    @gl.bindTexture @gl.TEXTURE_2D, texture
    
    @gl.texImage2D @gl.TEXTURE_2D, 0, @gl.RGBA, @gl.RGBA, @gl.UNSIGNED_BYTE, material.image
    @gl.texParameteri @gl.TEXTURE_2D, @gl.TEXTURE_MAG_FILTER, @gl.NEAREST
    @gl.texParameteri @gl.TEXTURE_2D, @gl.TEXTURE_MIN_FILTER, @gl.NEAREST#NEAREST_MIPMAP_NEAREST
    
    # ext = @gl.getExtension 'WEBKIT_EXT_texture_filter_anisotropic'
    # if ext?
    #   max_anisotropy = @gl.getParameter ext.MAX_TEXTURE_MAX_ANISOTROPY_EXT
    #   max_anisotropy = Math.min 1, max_anisotropy
    #   @gl.texParameterf @gl.TEXTURE_2D, ext.TEXTURE_MAX_ANISOTROPY_EXT, max_anisotropy
    
    @gl.generateMipmap @gl.TEXTURE_2D
    
    @gl.bindTexture @gl.TEXTURE_2D, null
    
    mount.texture = texture
  
  uploadMaterial: (mount) ->
    {entity} = mount
    {material} = entity
    
    @uploadImage mount
    
    program = @gl.createProgram()
    program.attributes = {}
    program.uniforms = {}
    @gl.attachShader program, (@getShader @gl.VERTEX_SHADER, material.shaders.vertex)
    @gl.attachShader program, (@getShader @gl.FRAGMENT_SHADER, material.shaders.fragment)
    @gl.linkProgram program
    @gl.useProgram program
    
    program.uniforms.projection = @gl.getUniformLocation program, 'uProjection'
    program.uniforms.view = @gl.getUniformLocation program, 'uView'
    program.uniforms.model = @gl.getUniformLocation program, 'uModel'
    
    program.uniforms.color = @gl.getUniformLocation program, 'uColor'
    
    program.uniforms.sampler = @gl.getUniformLocation program, 'uSampler'
    
    program.attributes.position = @gl.getAttribLocation program, 'aPosition'
    @gl.enableVertexAttribArray program.attributes.position
    
    program.attributes.coord = @gl.getAttribLocation program, 'aCoord'
    @gl.enableVertexAttribArray program.attributes.coord
    
    program.attributes.color = @gl.getAttribLocation program, 'aColor'
    @gl.enableVertexAttribArray program.attributes.color
    
    mount.program = program
  
  mount: (entity) ->
    mount = @lookup entity
    
    @uploadMesh mount unless mount.buffer?
    @uploadMaterial mount unless mount.program?
    
    return mount
  
  render: (simulation, camera) ->
    @gl.clear @clearMode
    
    camera.update()
    
    for entity in simulation.entities then do (entity) =>
      {texture, buffer, program} = @mount entity
      
      {uniforms, attributes} = program
      
      entity.sync()
      
      @gl.useProgram program
      
      @gl.uniformMatrix4fv uniforms.projection, false, camera.projection
      @gl.uniformMatrix4fv uniforms.view, false, camera.view
      @gl.uniformMatrix4fv uniforms.model, false, entity.model
      
      @gl.bindBuffer @gl.ARRAY_BUFFER, buffer
      
      @gl.vertexAttribPointer attributes.position, 3, @gl.FLOAT, false, 36, 0
      @gl.vertexAttribPointer attributes.coord,    2, @gl.FLOAT, false, 36, 12
      @gl.vertexAttribPointer attributes.color,    4, @gl.FLOAT, false, 36, 20
      
      @gl.activeTexture @gl.TEXTURE0
      @gl.bindTexture @gl.TEXTURE_2D, texture
      @gl.uniform1i uniforms.sampler, 0
      
      @gl.drawArrays entity.drawMode, 0, entity.count
    
    # @gl.finish()