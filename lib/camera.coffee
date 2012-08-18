Body = require './body'

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
  
  update: ->
    super
    
    mat4.perspective @fov, @aspect, @near, @far, @projection
    
    mat4.inverse @model, @view