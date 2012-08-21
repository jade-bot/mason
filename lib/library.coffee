Entity = require './entity'
Material = require './material'

module.exports = class Library extends Entity
  constructor: (args = {}) ->
    super
    
    @shaderSources = require 'shaders'
    
    @resources ?= args.resources
    
    @materials ?= args.materials or {}
    
    for key, data of @resources.materials
      @materials[key] = material = new Material
        key: key
        shaders:
          vertex: @loadShader "#{data.program}.vertex.glsl"
          fragment: @loadShader "#{data.program}.fragment.glsl"
      
      material.on 'load', => @emit 'load'
      
      material.image = @loadImage data.image, (error) ->
        material.emit 'load'
  
  loadImage: (src, callback = ->) ->
    image = new Image
    
    image.addEventListener 'load', -> callback null
    
    image.src = src
    
    return image
  
  loadShader: (key, callback = ->) ->
    source = @shaderSources[key]
    
    callback null, source
    
    return source