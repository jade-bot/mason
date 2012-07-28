textures = require './textures'

module.exports = blocks =
  dirt:
    coords: textures.generateCoords textures.dirt
  
  leaf:
    coords: textures.generateCoords textures.leaf

  planks:
    coords: textures.generateCoords textures.planks
  
  coal:
    coords: textures.generateCoords textures.coal

  iron:
    coords: textures.generateCoords textures.iron

  gold:
    coords: textures.generateCoords textures.gold

  stone:
    coords: textures.generateCoords textures.stone
  
  grass:
    coords:
      front: [
        textures.grass.left, textures.grass.bottom
        textures.grass.right, textures.grass.bottom
        textures.grass.right, textures.grass.top
        textures.grass.left, textures.grass.top
      ]
      
      back: [
        textures.grass.right, textures.grass.bottom
        textures.grass.right, textures.grass.top
        textures.grass.left, textures.grass.top
        textures.grass.left, textures.grass.bottom
      ]
      
      top: [
        textures.grass.left, textures.grass.top
        textures.grass.left, textures.grass.top
        textures.grass.left, textures.grass.top
        textures.grass.left, textures.grass.top
      ]
      
      bottom: [
        textures.dirt.right, textures.dirt.top
        textures.dirt.left, textures.dirt.top
        textures.dirt.left, textures.dirt.bottom
        textures.dirt.right, textures.dirt.bottom
      ]
      
      right: [
        textures.grass.right, textures.grass.bottom
        textures.grass.right, textures.grass.top
        textures.grass.left, textures.grass.top
        textures.grass.left, textures.grass.bottom
      ]
      
      left: [
        textures.grass.left, textures.grass.bottom
        textures.grass.right, textures.grass.bottom
        textures.grass.right, textures.grass.top
        textures.grass.left, textures.grass.top
      ]
  
  wood:
    coords:
      front: [
        textures.wood.left, textures.wood.bottom
        textures.wood.right, textures.wood.bottom
        textures.wood.right, textures.wood.top
        textures.wood.left, textures.wood.top
      ]
      
      back: [
        textures.wood.right, textures.wood.bottom
        textures.wood.right, textures.wood.top
        textures.wood.left, textures.wood.top
        textures.wood.left, textures.wood.bottom
      ]
      
      top: [
        textures.trunk.left, textures.trunk.top
        textures.trunk.left, textures.trunk.bottom
        textures.trunk.right, textures.trunk.bottom
        textures.trunk.right, textures.trunk.top
      ]
      
      bottom: [
        textures.trunk.right, textures.trunk.top
        textures.trunk.left, textures.trunk.top
        textures.trunk.left, textures.trunk.bottom
        textures.trunk.right, textures.trunk.bottom
      ]
      
      right: [
        textures.wood.right, textures.wood.bottom
        textures.wood.right, textures.wood.top
        textures.wood.left, textures.wood.top
        textures.wood.left, textures.wood.bottom
      ]
      
      left: [
        textures.wood.left, textures.wood.bottom
        textures.wood.right, textures.wood.bottom
        textures.wood.right, textures.wood.top
        textures.wood.left, textures.wood.top
      ]

  crafting_table:
    coords:
      front: [
        textures.crafting_table_front.left, textures.crafting_table_front.bottom
        textures.crafting_table_front.right, textures.crafting_table_front.bottom
        textures.crafting_table_front.right, textures.crafting_table_front.top
        textures.crafting_table_front.left, textures.crafting_table_front.top
      ]
      
      back: [
        textures.crafting_table_side.right, textures.crafting_table_side.bottom
        textures.crafting_table_side.right, textures.crafting_table_side.top
        textures.crafting_table_side.left, textures.crafting_table_side.top
        textures.crafting_table_side.left, textures.crafting_table_side.bottom
      ]
      
      top: [
        textures.crafting_table_top.left, textures.crafting_table_top.top
        textures.crafting_table_top.left, textures.crafting_table_top.bottom
        textures.crafting_table_top.right, textures.crafting_table_top.bottom
        textures.crafting_table_top.right, textures.crafting_table_top.top
      ]
      
      bottom: [
        textures.crafting_table_top.right, textures.crafting_table_top.top
        textures.crafting_table_top.left, textures.crafting_table_top.top
        textures.crafting_table_top.left, textures.crafting_table_top.bottom
        textures.crafting_table_top.right, textures.crafting_table_top.bottom
      ]
      
      right: [
        textures.crafting_table_side.right, textures.crafting_table_side.bottom
        textures.crafting_table_side.right, textures.crafting_table_side.top
        textures.crafting_table_side.left, textures.crafting_table_side.top
        textures.crafting_table_side.left, textures.crafting_table_side.bottom
      ]
      
      left: [
        textures.crafting_table_side.left, textures.crafting_table_side.bottom
        textures.crafting_table_side.right, textures.crafting_table_side.bottom
        textures.crafting_table_side.right, textures.crafting_table_side.top
        textures.crafting_table_side.left, textures.crafting_table_side.top
      ]
  
  chest:
    coords:
      front: [
        textures.chest_front.left, textures.chest_front.bottom
        textures.chest_front.right, textures.chest_front.bottom
        textures.chest_front.right, textures.chest_front.top
        textures.chest_front.left, textures.chest_front.top
      ]
      
      back: [
        textures.chest_side.right, textures.chest_side.bottom
        textures.chest_side.right, textures.chest_side.top
        textures.chest_side.left, textures.chest_side.top
        textures.chest_side.left, textures.chest_side.bottom
      ]
      
      top: [
        textures.chest_top.left, textures.chest_top.top
        textures.chest_top.left, textures.chest_top.bottom
        textures.chest_top.right, textures.chest_top.bottom
        textures.chest_top.right, textures.chest_top.top
      ]
      
      bottom: [
        textures.chest_top.right, textures.chest_top.top
        textures.chest_top.left, textures.chest_top.top
        textures.chest_top.left, textures.chest_top.bottom
        textures.chest_top.right, textures.chest_top.bottom
      ]
      
      right: [
        textures.chest_side.right, textures.chest_side.bottom
        textures.chest_side.right, textures.chest_side.top
        textures.chest_side.left, textures.chest_side.top
        textures.chest_side.left, textures.chest_side.bottom
      ]
      
      left: [
        textures.chest_side.left, textures.chest_side.bottom
        textures.chest_side.right, textures.chest_side.bottom
        textures.chest_side.right, textures.chest_side.top
        textures.chest_side.left, textures.chest_side.top
      ]
  
  furnace:
    coords:
      front: [
        textures.furnace_front.left, textures.furnace_front.bottom
        textures.furnace_front.right, textures.furnace_front.bottom
        textures.furnace_front.right, textures.furnace_front.top
        textures.furnace_front.left, textures.furnace_front.top
      ]
      
      back: [
        textures.furnace_side.right, textures.furnace_side.bottom
        textures.furnace_side.right, textures.furnace_side.top
        textures.furnace_side.left, textures.furnace_side.top
        textures.furnace_side.left, textures.furnace_side.bottom
      ]
      
      top: [
        textures.furnace_top.left, textures.furnace_top.top
        textures.furnace_top.left, textures.furnace_top.bottom
        textures.furnace_top.right, textures.furnace_top.bottom
        textures.furnace_top.right, textures.furnace_top.top
      ]
      
      bottom: [
        textures.furnace_top.right, textures.furnace_top.top
        textures.furnace_top.left, textures.furnace_top.top
        textures.furnace_top.left, textures.furnace_top.bottom
        textures.furnace_top.right, textures.furnace_top.bottom
      ]
      
      right: [
        textures.furnace_side.right, textures.furnace_side.bottom
        textures.furnace_side.right, textures.furnace_side.top
        textures.furnace_side.left, textures.furnace_side.top
        textures.furnace_side.left, textures.furnace_side.bottom
      ]
      
      left: [
        textures.furnace_side.left, textures.furnace_side.bottom
        textures.furnace_side.right, textures.furnace_side.bottom
        textures.furnace_side.right, textures.furnace_side.top
        textures.furnace_side.left, textures.furnace_side.top
      ]