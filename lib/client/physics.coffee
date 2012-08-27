blocks = require '../../blocks'

intersect = require '../intersect'

collision = require './collision'

tempVec3 = vec3.create()
move = vec3.create()

findCell = (position, cell) ->
  cell[0] = Math.floor position[0]
  cell[1] = Math.floor position[1]
  cell[2] = Math.floor position[2]

sameCell = (a, b) ->
  return unless a[0] is b[0]
  return unless a[1] is b[1]
  return unless a[2] is b[2]
  return true

module.exports = ({volume, simulation, subject}) ->
  simulation.gravity = [0, -9.81, 0]
  
  subject.track =
    onGround: false
  
  simulation.on 'tick', ->
    for entity in simulation.entities when entity.dynamic
      unless entity.onGround?
        vec3.add entity.velocity, simulation.gravity
      
      vec3.set entity.velocity, tempVec3
      vec3.scale tempVec3, 0.001
      
      vec3.add entity.delta, tempVec3, move
            
      if entity.track?
        for axis in [0..2]
          from = subject.position[axis]
          subject.position[axis] += move[axis]
          if collision.collide entity, volume
            subject.position[axis] = from
            if axis is 1
              subject.track.onGround = yes
              subject.velocity[1] = 0
          else
            if axis is 1
              subject.track.onGround = no