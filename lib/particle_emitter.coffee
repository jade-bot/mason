Mesh = require './mesh'

module.exports = class Emitter extends Mesh
  constructor: (args = {}) ->
    super
    
    @particles = []
    
    for i in [0...5000]
      @particles.push
        position: [0, 0, 0] # [Math.random(), Math.random(), Math.random()]
        velocity: [Math.random() * 0.01, Math.random() * 0.01, Math.random() * 0.01]
        color: [Math.random(), Math.random(), Math.random(), 1]
        ttl: Math.random() * 1500
        created: Date.now()
    
    @dynamic = yes

    @update()
  
  update: ->
    super
    
    for particle in @particles
      vec3.add particle.velocity, [0, 0.0005, 0]
      
      vec3.add particle.position, particle.velocity
      vec3.add particle.position, [Math.random() * 0.05, Math.random() * 0.05, Math.random() * 0.05]
      
      particle.color[0] = 0.5 + (Date.now() - particle.created) / particle.ttl
      particle.color[1] = 0.2 + (Date.now() - particle.created) / particle.ttl
      particle.color[2] = 1 - (Date.now() - particle.created) / particle.ttl + 0.25
      
      if (particle.created + particle.ttl) < Date.now()
        particle.position[0] = 0
        particle.position[1] = 0
        particle.position[2] = 0
        particle.velocity[0] = Math.random() * 0.01
        particle.velocity[1] = Math.random() * 0.01
        particle.velocity[2] = Math.random() * 0.01
        particle.created = Date.now()
    
    @data = []
    for particle, index in @particles
      @data.push particle.position...
      @data.push 0, 0
      @data.push particle.color...
  
  upload: (gl) ->
    @buffer ?= gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @buffer
    gl.bufferData gl.ARRAY_BUFFER, (new Float32Array @data), gl.DYNAMIC_DRAW
    @buffer.size = 5
    @buffer.count = 5000
    
    @mode = gl.POINTS