Entity = require './entity'

module.exports = class Face extends Entity
  constructor: (args = {}) ->
    super
    
    @vertices ?= args.vertices or []
    
    @normal ?= args.normal or [0, 0, 0]
    
    @centroid ?= args.centroid or [0, 0, 0]
    
    @computeCentroid()
  
  computeCentroid: ->
    @centroid[0] = 0 ; @centroid[1] = 0 ; @centroid[2] = 0
    vec3.add @vertices[0], @centroid
    vec3.add @vertices[1], @centroid
    vec3.add @vertices[2], @centroid
    vec3.add @vertices[3], @centroid
    vec3.scale @centroid, 0.25