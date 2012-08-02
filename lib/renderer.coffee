Entity = require './entity'

module.exports = class Renderer extends Entity
  getShader: (type, source) ->
    shader = @gl.createShader type
    @gl.shaderSource shader, source
    @gl.compileShader shader
    
    return shader
  
  load: ->
    shaders = require 'shaders'
    
    @vertexShader = @getShader @gl.VERTEX_SHADER, shaders['basic.vertex.glsl']
    @fragmentShader = @getShader @gl.FRAGMENT_SHADER, shaders['basic.fragment.glsl']
    
    @program = @gl.createProgram()
    @program.attributes = {}
    @program.uniforms = {}
    @gl.attachShader @program, @vertexShader
    @gl.attachShader @program, @fragmentShader
    @gl.linkProgram @program

    @gl.useProgram @program
    
    @program.uniforms.projection = @gl.getUniformLocation @program, 'uProjection'
    @program.uniforms.view = @gl.getUniformLocation @program, 'uView'
    @program.uniforms.model = @gl.getUniformLocation @program, 'uModel'

    @program.uniforms.color = @gl.getUniformLocation @program, 'uColor'
    
    @program.attributes.position = @gl.getAttribLocation @program, 'aPosition'
    @gl.enableVertexAttribArray @program.attributes.position

    @program.attributes.coord = @gl.getAttribLocation @program, 'aCoord'
    @gl.enableVertexAttribArray @program.attributes.coord
    
    @program.attributes.color = @gl.getAttribLocation @program, 'aColor'
    @gl.enableVertexAttribArray @program.attributes.color
  
  reset: ->
    @gl.clearColor 0.0, 0.0, 0.0, 0.9
    @gl.enable @gl.DEPTH_TEST
    @gl.enable @gl.CULL_FACE
  
  render: (simulation, camera) ->
    @gl.viewport 0, 0, @gl.viewportWidth, @gl.viewportHeight
    
    @gl.clear @gl.COLOR_BUFFER_BIT | @gl.DEPTH_BUFFER_BIT
    
    camera.update()
    
    for key, entity of simulation.entities
      if (not entity.buffer?) or entity.dynamic
        entity.upload @gl
      
      unless entity.culling is off
        @gl.enable @gl.CULL_FACE
      else
        @gl.disable @gl.CULL_FACE
      
      entity.update? 0
      
      @gl.uniformMatrix4fv @program.uniforms.projection, false, camera.projection
      @gl.uniformMatrix4fv @program.uniforms.view, false, camera.view
      @gl.uniformMatrix4fv @program.uniforms.model, false, entity.model
      
      if entity.selected
        @gl.uniform4f @program.uniforms.color, entity.selectedColor[0], entity.selectedColor[1], entity.selectedColor[2], entity.selectedColor[3]
      else
        @gl.uniform4f @program.uniforms.color, entity.color[0], entity.color[1], entity.color[2], entity.color[3]
      
      @gl.bindBuffer @gl.ARRAY_BUFFER, entity.buffer
      # debugger
      @gl.vertexAttribPointer @program.attributes.position, 3, @gl.FLOAT, false, 36, 0
      @gl.vertexAttribPointer @program.attributes.coord, 2, @gl.FLOAT, false, 36, 12
      @gl.vertexAttribPointer @program.attributes.color, 4, @gl.FLOAT, false, 36, 20
      
      # gl.activeTexture gl.TEXTURE0
      # gl.bindTexture gl.TEXTURE_2D, entity.texture.texture
      # gl.uniform1i shaderProgram.samplerUniform, 0
      
      @gl.drawArrays (if entity.mode? then entity.mode else @gl.TRIANGLES), 0, entity.buffer.count
      
      if entity.selected
        @gl.enable @gl.VERTEX_PROGRAM_POINT_SIZE
        @gl.enable @gl.POINT_SMOOTH
        @gl.uniform4f @program.uniforms.color, 1, 1, 0, 1
        @gl.drawArrays @gl.POINTS, 0, entity.buffer.count
        # @gl.disable @gl.VERTEX_PROGRAM_POINT_SIZE
  
  setup: ->
    @gl = @canvas.getContext 'experimental-webgl', alpha: on
    @gl.viewportWidth = window.innerWidth
    @gl.viewportHeight = window.innerHeight
    
    # @scrub.ctx = ctx = @scrub.getContext '2d'
    # ctx.font = 'normal 35px Verdana'
    # ctx.fillStyle = 'rgba(0, 0, 0, 255)'
    # ctx.fillRect 0,0, 512, 512
    # ctx.lineWidth = 5
    # ctx.strokeStyle = 'rgba(0,0,0,255)'
    # ctx.textAlign = 'center'
    # ctx.textBaseline = 'middle'
    
    # ctx.save()
    # ctx.clearRect 0, 0, 512, 512
    # ctx.fillStyle = 'rgba(0, 0, 0, 255)'
    # ctx.fillRect 0, 0, 512, 512
    # ctx.fillStyle = 'rgba(255, 255, 255, 255)'
    # ctx.strokeText 'test', 150, 150
    # ctx.fillText 'test', 150, 150
    # set texture
    # ctx.restore()
  
  constructor: (args = {}) ->
    super
    
    @canvas = args.canvas

    @scrub = args.scrub
    
    @setup()
    
    @load()
    
    @reset()
    
    tick = =>
      requestAnimationFrame tick
      
      @emit 'tick'
    
    tick()