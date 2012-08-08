uuid = require 'node-uuid'

blocks = require '../blocks'

module.exports = terraform = (volume) ->
  woods = []
  
  for i in [0...16]
    for j in [0...128]
      for k in [0...16]
        if j > 64
          continue
        
        if j is 64
          type = null
          
          if Math.random() < 0.01
            type ?= blocks.wood
          
          if Math.random() < 0.05
            type ?= blocks.chest
          
          if Math.random() < 0.05
            type ?= blocks.crafting_table
          
          if Math.random() < 0.05
            type ?= blocks.planks
          
          if Math.random() < 0.05
            type ?= blocks.furnace
          
          if Math.random() < 0.05
            type ?= blocks.bush
          
          if Math.random() < 0.05
            type ?= blocks.glass
          
          continue unless type?
        
        type = blocks.grass if j is 63
        type = blocks.dirt if j < 63
        type = blocks.stone if j < 50
        
        if j < 50
          if Math.random() < 0.05
            type = blocks.coal
          
          if Math.random() < 0.05
            type = blocks.gold
          
          if Math.random() < 0.05
            type = blocks.iron
          
          continue if Math.random() < 0.1
        
        if type is blocks.wood
          woods.push cube
          continue
        
        cube =
          id: uuid()
          type: type or blocks[Object.keys(blocks)[Math.floor (Math.random() * Object.keys(blocks).length)]]
          position: [i, j, k]
        cube.key = "#{cube.position[0]}:#{cube.position[1]}:#{cube.position[2]}"
        volume.voxels[cube.key] = cube
  
  for wood in woods
    height = (Math.random() * 10) + 5
    
    for i in [wood.position[1]...wood.position[1] + height]
      cube =
        id: uuid()
        type: blocks.wood
        position: [wood.position[0], i, wood.position[2]]
      cube.key = "#{cube.position[0]}:#{cube.position[1]}:#{cube.position[2]}"
      volume.voxels[cube.key] = cube
    
    for i in [-1..1]
      for j in [-1..1]
        for k in [-1..1]
          if Math.random() > 0.25
            leaf =
              id: uuid()
              type: blocks.leaf
              position: [wood.position[0] + i, wood.position[1] + j + height, wood.position[2] + k]
            leaf.key = "#{leaf.position[0]}:#{leaf.position[1]}:#{leaf.position[2]}"
            volume.voxels[leaf.key] = leaf