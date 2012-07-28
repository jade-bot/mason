uuid = require 'node-uuid'

require './lib/math'
require './lib/shim'

mason = require './mason'
{Keyboard, Volume, Camera} = mason

keyboard = new Keyboard
keyboard.bind document

blocks = require './blocks'

camera = new Camera position: [0, 16, 10]

gl = null
shaderProgram = undefined
glassTexture = undefined
mvMatrix = mat4.create()
mvMatrixStack = []
pMatrix = mat4.create()
xRot = 0
xSpeed = 0
yRot = 0
ySpeed = -24
z = -15.0
blending = off
alpha = 1.0
lighting = on
lightingDirection = [-0.25, -0.25, -1.0]
directional = [0.5, 0.5, 0.5]
ambient = [0.2, 0.2, 0.2]

shaders = require 'shaders'

getShader = (gl, {type, source} = {}) ->
  shader = gl.createShader type
  gl.shaderSource shader, source
  gl.compileShader shader
  return shader

initShaders = ->
  fragmentShader = getShader gl, type: gl.FRAGMENT_SHADER, source: shaders['fragment.glsl']
  vertexShader = getShader gl, type: gl.VERTEX_SHADER, source: shaders['vertex.glsl']
  
  shaderProgram = gl.createProgram()
  gl.attachShader shaderProgram, vertexShader
  gl.attachShader shaderProgram, fragmentShader
  gl.linkProgram shaderProgram
  
  alert "Could not initialise shaders" unless gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)
  gl.useProgram shaderProgram
  
  shaderProgram.positionAttribute = gl.getAttribLocation shaderProgram, 'aPosition'
  gl.enableVertexAttribArray shaderProgram.positionAttribute
  
  shaderProgram.normalAttribute = gl.getAttribLocation shaderProgram, 'aNormal'
  gl.enableVertexAttribArray shaderProgram.normalAttribute
  
  shaderProgram.coordAttribute = gl.getAttribLocation shaderProgram, 'aCoord'
  gl.enableVertexAttribArray shaderProgram.coordAttribute
  
  shaderProgram.colorAttribute = gl.getAttribLocation shaderProgram, 'aColor'
  gl.enableVertexAttribArray shaderProgram.colorAttribute
  
  shaderProgram.pMatrixUniform = gl.getUniformLocation shaderProgram, 'uPMatrix'
  shaderProgram.mvMatrixUniform = gl.getUniformLocation shaderProgram, 'uMVMatrix'
  shaderProgram.nMatrixUniform = gl.getUniformLocation shaderProgram, 'uNMatrix'
  shaderProgram.samplerUniform = gl.getUniformLocation shaderProgram, 'uSampler'
  shaderProgram.useLightingUniform = gl.getUniformLocation shaderProgram, 'uUseLighting'
  shaderProgram.ambientColorUniform = gl.getUniformLocation shaderProgram, 'uAmbientColor'
  shaderProgram.lightingDirectionUniform = gl.getUniformLocation shaderProgram, 'uLightingDirection'
  shaderProgram.directionalColorUniform = gl.getUniformLocation shaderProgram, 'uDirectionalColor'
  shaderProgram.alphaUniform = gl.getUniformLocation shaderProgram, 'uAlpha'

handleLoadedTexture = (texture) ->
  gl.pixelStorei gl.UNPACK_FLIP_Y_WEBGL, off
  gl.bindTexture gl.TEXTURE_2D, texture
  gl.texImage2D gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, texture.image
  gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST
  gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST
  gl.generateMipmap gl.TEXTURE_2D
  gl.bindTexture gl.TEXTURE_2D, null

initTexture = ->
  texture = gl.createTexture()
  texture.image = new Image
  texture.image.onload = ->
    handleLoadedTexture texture
  
  texture.image.src = '/terrain.png'
  
  return texture

mvPushMatrix = ->
  copy = mat4.create()
  mat4.set mvMatrix, copy
  mvMatrixStack.push copy

mvPopMatrix = ->
  throw "Invalid popMatrix!"  if mvMatrixStack.length is 0
  mvMatrix = mvMatrixStack.pop()

setMatrixUniforms = ->
  gl.uniformMatrix4fv shaderProgram.pMatrixUniform, false, pMatrix
  gl.uniformMatrix4fv shaderProgram.mvMatrixUniform, false, mvMatrix

  normalMatrix = mat3.create()
  mat4.toInverseMat3 mvMatrix, normalMatrix
  mat3.transpose normalMatrix
  gl.uniformMatrix3fv shaderProgram.nMatrixUniform, false, normalMatrix

degToRad = (degrees) ->
  degrees * Math.PI / 180

entities = []

initBuffers = (texture) ->
  for i in [-1..1]
    for k in [-1..1]
      volume = new Volume texture: texture, blocks: blocks, position: [i * 16, 0, k * 16]
      volume.upload gl
      entities.push volume

# xUnit = [1, 0, 0]
# yUnit = [0, 1, 0]

# pos = [0, -12, -40]

drawScene = ->
  gl.viewport 0, 0, gl.viewportWidth, gl.viewportHeight
  
  gl.clear gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT
  
  camera.update()
  
  mat4.perspective 45, gl.viewportWidth / gl.viewportHeight, 0.1, 1000.0, pMatrix
  
  mat4.identity mvMatrix
  # mat4.translate mvMatrix, pos
  # mat4.rotate mvMatrix, degToRad(xRot), xUnit
  # mat4.rotate mvMatrix, degToRad(yRot), yUnit

  mvPushMatrix mvMatrix
  
  for entity in entities
    entity.update()
    
    mat4.multiply camera.view, entity.model, mvMatrix

    gl.bindBuffer gl.ARRAY_BUFFER, entity.positionBuffer
    gl.vertexAttribPointer shaderProgram.positionAttribute, entity.positionBuffer.itemSize, gl.FLOAT, false, 0, 0
    gl.bindBuffer gl.ARRAY_BUFFER, entity.normalBuffer
    gl.vertexAttribPointer shaderProgram.normalAttribute, entity.normalBuffer.itemSize, gl.FLOAT, false, 0, 0
    gl.bindBuffer gl.ARRAY_BUFFER, entity.coordBuffer
    gl.vertexAttribPointer shaderProgram.coordAttribute, entity.coordBuffer.itemSize, gl.FLOAT, false, 0, 0
    gl.bindBuffer gl.ARRAY_BUFFER, entity.colorBuffer
    gl.vertexAttribPointer shaderProgram.colorAttribute, entity.colorBuffer.itemSize, gl.FLOAT, false, 0, 0
    
    gl.activeTexture gl.TEXTURE0
    gl.bindTexture gl.TEXTURE_2D, entity.texture
    gl.uniform1i shaderProgram.samplerUniform, 0
    
    if blending
      gl.blendFunc gl.SRC_ALPHA, gl.ONE
      gl.enable gl.BLEND
      gl.disable gl.DEPTH_TEST
      gl.uniform1f shaderProgram.alphaUniform, alpha
    else
      gl.disable gl.BLEND
      gl.enable gl.DEPTH_TEST
    
    gl.uniform1i shaderProgram.useLightingUniform, lighting
    
    if lighting
      gl.uniform3f shaderProgram.ambientColorUniform, ambient[0], ambient[1], ambient[2]
      
      adjustedLD = vec3.create()
      vec3.normalize lightingDirection, adjustedLD
      vec3.scale adjustedLD, -1
      gl.uniform3fv shaderProgram.lightingDirectionUniform, adjustedLD
      gl.uniform3f shaderProgram.directionalColorUniform, directional[0], directional[1], directional[2]
    
    gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, entity.indexBuffer
    setMatrixUniforms()
    gl.drawElements gl.TRIANGLES, entity.indexBuffer.numItems, gl.UNSIGNED_SHORT, 0

handleInput = (delta) ->
  # z -= 0.05 if keyboard.keys.map.w
  # z += 0.05  if keyboard.keys.map.s
  
  delta *= 0.1
  
  ySpeed -= delta if keyboard.keys.map.a
  ySpeed += delta if keyboard.keys.map.d
  xSpeed -= delta if keyboard.keys.map.w
  xSpeed += delta if keyboard.keys.map.s
  
  xSpeed *= 0.90
  ySpeed *= 0.90
  
  if Math.abs(xSpeed) < 0.5 then xSpeed = 0
  if Math.abs(ySpeed) < 0.5 then ySpeed = 0

lastTime = 0

animate = ->
  timeNow = Date.now()
  
  unless lastTime is 0
    elapsed = timeNow - lastTime
    xRot = (xSpeed * elapsed) / 1000.0
    yRot = (ySpeed * elapsed) / 1000.0
    
    camera.rotateGlobalY yRot
    camera.rotateX xRot
    
    handleInput elapsed
  
  lastTime = timeNow

tick = ->
  requestAnimationFrame tick
  
  animate()
  drawScene()

document.addEventListener 'DOMContentLoaded', ->
  canvas = document.getElementById 'canvas'

  canvas.setAttribute 'width', window.innerWidth
  canvas.setAttribute 'height', window.innerHeight
  
  gl = canvas.getContext 'experimental-webgl', alpha: true
  gl.viewportWidth = canvas.width
  gl.viewportHeight = canvas.height
  
  initShaders()
  texture = initTexture()
  initBuffers texture
  
  gl.clearColor 0.0, 0.0, 0.0, 0.75
  gl.enable gl.DEPTH_TEST
  gl.enable gl.CULL_FACE
  
  tick()