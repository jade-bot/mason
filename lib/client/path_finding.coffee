SparseVolume = require '../volume/sparse/volume'

class BreadCrumb
  constructor: (args = {}) ->
    @cost = args.cost or 0
    @position = args.position

delta = vec3.create()
tmp = vec3.create()

surroundings = [
  [0, 0, -1]
  [0, 0, +1]
  [0, -1, 0]
  [0, +1, 0]
  [-1, 0, 0]
  [+1, 0, 0]
]

crumbVolume = new SparseVolume

module.exports = (volume, start, end) ->
  start[0] = Math.floor start[0]
  start[1] = Math.floor start[1]
  start[2] = Math.floor start[2]
  
  end[0] = Math.floor end[0]
  end[1] = Math.floor end[1]
  end[2] = Math.floor end[2]
  
  open = []
  
  crumbVolume.empty()
  
  current = new BreadCrumb position: start
  
  finish = new BreadCrumb position: end
  
  crumbVolume.setVector current.position, current
  
  open.push current
  
  while open.length > 0
    current = open.shift()
    current.closed = yes
    
    for surrounding in surroundings
      vec3.add current.position, surrounding, tmp
      
      unless volume.getVector tmp
        unless crumbVolume.getVector tmp
          node = new BreadCrumb position: tmp
          crumbVolume.setVector tmp, node
        else
          node = crumbVolume.getVector tmp
        
        unless node.closed
          diff = 0
          
          if current.position[0] isnt node.position[0] then diff += 1
          if current.position[1] isnt node.position[1] then diff += 1
          if current.position[2] isnt node.position[2] then diff += 1
          
          vec3.subtract node.position, end, delta
          
          cost = current.cost + diff + (vec3.lengthSquared delta)
          
          if cost < node.cost
            node.cost = cost
            node.next = current
          
          unless node.open
            if node.position[0] is finish.position[0] and node.position[1] is finish.position[1] and node.position[2] is finish.position[2]
              node.next = current
              return node
            
            node.open = yes
            open.push node
   return
