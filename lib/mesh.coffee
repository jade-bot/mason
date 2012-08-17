Body = require './body'

module.exports = class Mesh extends Body
  constructor: (args = {}) ->
    super
    
    @material ?= args.material
    
    @data ?= args.data or new Array
    
    @drawMode ?= args.drawMode or WebGLRenderingContext.TRIANGLES
    
    @count ?= args.count or 0
    
    @visible ?= yes
  
  reset: ->
    @data.length = 0
    @count = 0