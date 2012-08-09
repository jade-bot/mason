textures = require './textures'

module.exports = blocks =
  bricks: {}
  chest:
    textures:
      left: textures.chest.side
      right: textures.chest.side
      bottom: textures.chest.cap
      top: textures.chest.cap
      back: textures.chest.side
      front: textures.chest.front
  coal: {}
  cobblestone: {}
  crafting_table:
    textures:
      left: textures.crafting_table.side
      right: textures.crafting_table.side
      bottom: textures.crafting_table.cap
      top: textures.crafting_table.cap
      back: textures.crafting_table.back
      front: textures.crafting_table.front
  dirt: {}
  furnace:
    textures:
      left: textures.furnace.side
      right: textures.furnace.side
      bottom: textures.furnace.cap
      top: textures.furnace.cap
      back: textures.furnace.side
      front: textures.furnace.front
  glass: (transparent: yes)
  gold: {}
  grass:
    textures:
      left: textures.grass.side
      right: textures.grass.side
      bottom: textures.grass.bottom
      top: textures.grass.top
      back: textures.grass.side
      front: textures.grass.side
  iron: {}
  lava: {}
  leaf: (transparent: yes)
  stone: {}
  tree:
    textures:
      left: textures.tree.side
      right: textures.tree.side
      bottom: textures.tree.cap
      top: textures.tree.cap
      back: textures.tree.side
      front: textures.tree.side
  water: {}
  wood: {}

for key, block of blocks
  block.key = key