textures = require './textures'

normalTextures = (texture) ->
  left: texture.side
  right: texture.side
  bottom: texture.bottom
  top: texture.top
  back: texture.side
  front: texture.side
frontandCappedTexture = (texture) ->
  left: texture.side
  right: texture.side
  bottom: texture.cap
  top: texture.cap
  back: texture.side
  front: texture.front

module.exports = blocks =
  air: {}
  books:
    textures:
      left: textures.books
      right: textures.books
      bottom: textures.wood
      top: textures.wood
      back: textures.books
      front: textures.books
  brick: {}
  chest: (textures: frontandCappedTexture textures.chest)
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
  diamond: {}
  dirt: {}
  furnace: (textures: frontandCappedTexture textures.furnace)
  glass: (transparent: yes)
  gold: {}
  grass: (textures: normalTextures textures.grass)
  iron: {}
  lava: {}
  leaf: (transparent: yes)
  mail: {}
  motor: (textures: normalTextures textures.motor)
  piston: (textures: normalTextures textures.piston)
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

block.key = key for key, block of blocks

Object.defineProperty blocks, 'map', value: {}

for key, index in Object.keys blocks
  block = blocks[key]
  block.index = index
  blocks.map[index] = block