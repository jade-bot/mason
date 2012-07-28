Mesh = require './mesh'

module.exports = class Camera extends Mesh
  constructor: (args = {}) ->
    super
    
    @projection = mat4.create()
    
    @view = mat4.create()
  
  update: ->
    super
    
    mat4.perspective 60, (window.innerWidth / window.innerHeight), 0.1, 1000, @projection
    
    mat4.inverse @model, @view