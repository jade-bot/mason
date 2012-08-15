blocks = require '../../blocks'

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
  # subject.on 'move', ->
  # console.log 'move'
  
  position = [0, 0, 0]
  
  cell = [0, 0, 0]
  lastCell = [0, 0, 0]
  
  findCell subject.position, cell
  findCell subject.position, lastCell
  
  subject.on 'request:movement', ->
    position[0] = subject.position[0]
    position[1] = subject.position[1] - 1.6
    position[2] = subject.position[2]
    
    findCell position, cell
    
    content = volume.getVector cell
    
    if content?
      subject.position[1] = cell[1] + 1 + 1.6
      subject.velocity[1] = 0