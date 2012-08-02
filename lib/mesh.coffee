Entity = require './entity'

module.exports = class Mesh extends Entity
  tempMat3: mat3.create()
  tempMat4: mat4.create()
  tempQuat4: quat4.create()
  tempVec3: vec3.create()
  
  constructor: (args = {}) ->
    super
    
    @texture = args.texture
    
    @count ?= args.count
    
    @position ?= vec3.create args.position or [0, 0, 0]
    @rotation ?= quat4.create args.rotation or [0, 0, 0, 1]
    
    @velocity ?= vec3.create()
    
    @model = mat4.create()
    
    @scale ?= [1, 1, 1]
    
    @up = [0, 1, 0]
    
    @color = [0, 0, 0, 1]
    @selectedColor = [0, 1, 1, 1]

    @vertices ?= []
    @colors ?= []
    @indices ?= []
    @coords ?= []
    @normals ?= []
  
  update: (time = 0) ->
    vec3.set @velocity, @tempVec3
    vec3.scale @tempVec3, time
    vec3.add @position, @tempVec3
    mat4.fromRotationTranslation @rotation, @position, @model
  
  lookAt: (target) ->
    mat4.lookAt @position, @target.position, @up, @tempMat4
    mat4.toMat3 @tempMat4, @tempMat3
    mat3.toQuat4 @tempMat3, @rotation
    @emit 'rotate'
  
  lookTo: (position) ->
    mat4.lookAt @position, position, @up, @tempMat4
    mat4.toMat3 @tempMat4, @tempMat3
    mat3.toQuat4 @tempMat3, @rotation
    @emit 'rotate'
  
  translate: (distance, axis) ->
    quat4.multiplyVec3 @rotation, axis, @tempVec3
    vec3.scale @tempVec3, distance, @tempVec3
    vec3.add @position, @tempVec3, @position
    @emit 'translate'
  
  translateX: (distance) -> @translate distance, vec3.xUnit
  translateY: (distance) -> @translate distance, vec3.yUnit
  translateZ: (distance) -> @translate distance, vec3.zUnit
  
  rotate: (angle, axis) ->
    quat4.fromAngleAxis angle, axis, @tempQuat4
    quat4.multiply @rotation, @tempQuat4, @rotation
    @emit 'rotate'
  
  rotateX: (angle) -> @rotate angle, vec3.xUnit
  rotateY: (angle) -> @rotate angle, vec3.yUnit
  rotateZ: (angle) -> @rotate angle, vec3.zUnit
  
  rotateGlobal: (angle, axis) ->
    quat4.fromAngleAxis angle, axis, @tempQuat4
    quat4.multiply @tempQuat4, @rotation, @rotation
    @emit 'rotate'
  
  rotateGlobalX: (angle) -> @rotateGlobal angle, vec3.xUnit
  rotateGlobalY: (angle) -> @rotateGlobal angle, vec3.yUnit
  rotateGlobalZ: (angle) -> @rotateGlobal angle, vec3.zUnit
  
  upload: (gl) ->
    @positionBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @positionBuffer
    gl.bufferData gl.ARRAY_BUFFER, (new Float32Array @vertices), gl.STATIC_DRAW
    @positionBuffer.itemSize = 3
    @positionBuffer.numItems = 4 * @count
    
    @normalBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @normalBuffer
    gl.bufferData gl.ARRAY_BUFFER, (new Float32Array @normals), gl.STATIC_DRAW
    @normalBuffer.itemSize = 3
    @normalBuffer.numItems = 4 * @count
    
    @coordBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @coordBuffer
    gl.bufferData gl.ARRAY_BUFFER, (new Float32Array @coords), gl.STATIC_DRAW
    @coordBuffer.itemSize = 2
    @coordBuffer.numItems = 4 * @count
    
    @colorBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @colorBuffer
    gl.bufferData gl.ARRAY_BUFFER, (new Float32Array @colors), gl.STATIC_DRAW
    @colorBuffer.itemSize = 4
    @colorBuffer.numItems = 4 * @count
    
    @indexBuffer = gl.createBuffer()
    gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @indexBuffer
    gl.bufferData gl.ELEMENT_ARRAY_BUFFER, (new Uint16Array @indices), gl.STATIC_DRAW
    @indexBuffer.itemSize = 1
    @indexBuffer.numItems = @indices.length

# entities = []

# bleh = {}
# bleh.vertices = []
# for i in [0...100]
#   bleh.vertices.push Math.random(), Math.random(), Math.random()
# bleh.count = bleh.vertices.length / 3
# bleh.buffer = gl.createBuffer()
# bleh.buffer.size = 3
# gl.bindBuffer gl.ARRAY_BUFFER, bleh.buffer
# gl.bufferData gl.ARRAY_BUFFER, (new Float32Array bleh.vertices), gl.STATIC_DRAW
# entities.push bleh