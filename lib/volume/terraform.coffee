blocks = require '../../blocks'

Voxel = require '../voxel'

noise = new SimplexNoise

module.exports = terraform = (min, max, volume) ->
  console.time 'terraform'
  
  for i in [min[0]...max[0]]
    for j in [min[1]...max[1]]
      for k in [min[2]...max[2]]
        
        x = i / 16
        y = j / 16
        z = k / 16
        
        if j < 16
          
          if (noise.noise3D x, y, z) < 0.25 and (noise.noise3D i / 8, j / 8, k / 8) < 0.25
            # volume.set i, j, k, blocks.air
          else
            if Math.random() > 0.95
              volume.set i, j, k, blocks.diamond
            else
              volume.set i, j, k, blocks.stone
        
        # if 16 <= j < 31
        # volume.set i, j, k, blocks.dirt
        else
          if j < ((noise.noise2D i / 16, k / 16) * 4 + 30)
            volume.set i, j, k, blocks.dirt
  
  for i in [min[0]...max[0]]
    for k in [min[2]...max[2]]
      highest = 0
      
      for j in [min[1]...max[1]]
        highest = j if volume.get i, j, k
      
      if (volume.get i, highest, k) is blocks.dirt
        volume.set i, highest, k, blocks.grass
        
  #       if j is 64
  #         type = null
          
  #         for key in ['tree', 'books', 'chest', 'crafting_table', 'wood', 'furnace', 'piston', 'glass']
  #           if Math.random() < 0.025
  #             type ?= blocks[key]
          
  #         continue unless type?
        
  #       type = blocks.grass if j is 63
  #       type = blocks.dirt if j < 63
  #       type = blocks.stone if j < 50
        
  #       if j < 50
  #         if Math.random() < 0.05
  #           type = blocks.diamond
          
  #         if Math.random() < 0.05
  #           type = blocks.coal
          
  #         if Math.random() < 0.05
  #           type = blocks.gold
          
  #         if Math.random() < 0.05
  #           type = blocks.iron
          
  #         continue if Math.random() < 0.1
        
  #       if type is blocks.tree
  #         trees.push cube
  #         continue
        
  #       cube =
  #         id: uuid()
  #         type: type or blocks[Object.keys(blocks)[Math.floor (Math.random() * Object.keys(blocks).length)]]
  #         position: [i, j, k]
  #       cube.key = "#{cube.position[0]}:#{cube.position[1]}:#{cube.position[2]}"
  #       volume.voxels[cube.key] = cube
  
  # for tree in trees
  #   height = (Math.random() * 10) + 5
    
  #   for i in [tree.position[1]...tree.position[1] + height]
  #     cube =
  #       id: uuid()
  #       type: blocks.tree
  #       position: [tree.position[0], i, tree.position[2]]
  #     cube.key = "#{cube.position[0]}:#{cube.position[1]}:#{cube.position[2]}"
  #     volume.voxels[cube.key] = cube
    
  #   for i in [-1..1]
  #     for j in [-1..1]
  #       for k in [-1..1]
  #         if Math.random() > 0.25
  #           leaf =
  #             id: uuid()
  #             type: blocks.leaf
  #             position: [tree.position[0] + i, tree.position[1] + j + height, tree.position[2] + k]
  #           leaf.key = "#{leaf.position[0]}:#{leaf.position[1]}:#{leaf.position[2]}"
  #           volume.voxels[leaf.key] = leaf
  
  console.timeEnd 'terraform'