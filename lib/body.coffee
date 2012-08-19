Entity = require './entity'

tempMat3 = mat3.create()
tempMat4 = mat4.create()
tempQuat4 = quat4.create()
tempVec3 = vec3.create()

module.exports = class Body extends Entity
  constructor: (args = {}) ->
    super
    
    @position ?= args.position or [0, 0, 0]
    
    @rotation ?= args.rotation or [0, 0, 0, 1]
    
    @velocity ?= args.velocity or vec3.create()
    
    @model ?= args.model or mat4.create()
    
    @scale ?= args.scale or [1, 1, 1]
    
    @up ?= args.up or [0, 1, 0]
    @_up ?= [0, 1, 0]
    @right ?= args.right or [1, 0, 0]
    @_right ?= [1, 0, 0]
    @forward ?= args.forward or [0, 0, 1]
    @_forward ?= [0, 0, 1]
    
    @sync()
  
  sync: (time) ->
    mat4.fromRotationTranslation @rotation, @position, @model
    quat4.multiplyVec3 @rotation, @_up, @up
    quat4.multiplyVec3 @rotation, @_right, @right
    quat4.multiplyVec3 @rotation, @_forward, @forward
  
  update: (time = 0) ->
    @sync time
  
  lookTo: (position) ->
    mat4.lookAt @position, position, @up, tempMat4
    mat4.toMat3 tempMat4, tempMat3
    mat3.toQuat4 tempMat3, @rotation
    @emit 'rotate'
  
  lookAt: (target) ->
    @lookTo target.position
  
  translate: (distance, axis) ->
    quat4.multiplyVec3 @rotation, axis, tempVec3
    vec3.scale tempVec3, distance, tempVec3
    vec3.add @position, tempVec3, @position
    @emit 'translate'
  
  translateX: (distance) -> @translate distance, vec3.xUnit
  translateY: (distance) -> @translate distance, vec3.yUnit
  translateZ: (distance) -> @translate distance, vec3.zUnit
  
  rotate: (angle, axis) ->
    quat4.fromAngleAxis angle, axis, tempQuat4
    quat4.multiply @rotation, tempQuat4, @rotation
    @emit 'rotate'
  
  rotateX: (angle) -> @rotate angle, vec3.xUnit
  rotateY: (angle) -> @rotate angle, vec3.yUnit
  rotateZ: (angle) -> @rotate angle, vec3.zUnit
  
  rotateGlobal: (angle, axis) ->
    quat4.fromAngleAxis angle, axis, tempQuat4
    quat4.multiply tempQuat4, @rotation, @rotation
    @emit 'rotate'
  
  rotateGlobalX: (angle) -> @rotateGlobal angle, vec3.xUnit
  rotateGlobalY: (angle) -> @rotateGlobal angle, vec3.yUnit
  rotateGlobalZ: (angle) -> @rotateGlobal angle, vec3.zUnit