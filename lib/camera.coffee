Body = require './body'

tempMat4 = mat4.create()

module.exports = class Camera extends Body
  constructor: (args = {}) ->
    super
    
    @fov ?= args.fov or 60
    
    @projection ?= args.projection or mat4.create()
    
    @view ?= args.view or mat4.create()
    
    Object.defineProperty this, 'aspect', get: ->
      window.innerWidth / window.innerHeight
    
    @near ?= args.near or 0.1
    @far ?= args.far or 1000
    
    @offset ?= args.offset or [0, 1.6, 0]
    
    @offsetPosition = vec3.create()
  
  update: ->
    # super
    vec3.add @offset, @position, @offsetPosition
    
    mat4.fromRotationTranslation @rotation, @offsetPosition, tempMat4
    mat4.identity @model
    mat4.scale @model, @scale, @model
    mat4.multiply @model, tempMat4
    quat4.multiplyVec3 @rotation, @_up, @up
    quat4.multiplyVec3 @rotation, @_right, @right
    quat4.multiplyVec3 @rotation, @_forward, @forward
    
    mat4.perspective @fov, @aspect, @near, @far, @projection
    
    mat4.inverse @model, @view