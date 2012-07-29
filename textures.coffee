EPSILON = 0.0025

module.exports = textures =
  planks:
    left: (1 / 16) * 4 + EPSILON
    top: EPSILON
    right: (1 / 16) * 5 - EPSILON
    bottom: (1 / 16) - EPSILON

  grass:
    left: (1 / 16) * 3 + EPSILON
    top: EPSILON
    right: (1 / 16) * 4 - EPSILON
    bottom: (1 / 16) - EPSILON
  
  sapling:
    left: (1 / 16) * 15 + EPSILON
    top: EPSILON
    right: (1 / 16) * 16 - EPSILON
    bottom: (1 / 16) - EPSILON

  leaf:
    left: (1 / 16) * 4 + EPSILON
    top: (1 / 16 * 3) + EPSILON
    right: (1 / 16) * 5 - EPSILON
    bottom: (1 / 16 * 4) - EPSILON
  
  wood:
    left: (1 / 16) * 4 + EPSILON
    top: (1 / 16) + EPSILON
    right: (1 / 16) * 5 - EPSILON
    bottom: (1 / 16 * 2) - EPSILON
  
  trunk:
    left: (1 / 16) * 5 + EPSILON
    top: (1 / 16) + EPSILON
    right: (1 / 16) * 6 - EPSILON
    bottom: (1 / 16 * 2) - EPSILON
  
  dirt:
    left: (1 / 16) * 2 + EPSILON
    top: EPSILON
    right: (1 / 16) * 3 - EPSILON
    bottom: (1 / 16) - EPSILON
  
  crafting_table_top:
    left: (1 / 16) * 11 + EPSILON
    top: (1 / 16 * 2) + EPSILON
    right: (1 / 16) * 12 - EPSILON
    bottom: (1 / 16 * 3) - EPSILON
  
  crafting_table_side:
    left: (1 / 16) * 11 + EPSILON
    top: (1 / 16 * 3) + EPSILON
    right: (1 / 16) * 12 - EPSILON
    bottom: (1 / 16 * 4) - EPSILON

  crafting_table_front:
    left: (1 / 16) * 12 + EPSILON
    top: (1 / 16 * 3) + EPSILON
    right: (1 / 16) * 13 - EPSILON
    bottom: (1 / 16 * 4) - EPSILON
  
  chest_front:
    left: (1 / 16) * 11 + EPSILON
    top: (1 / 16) + EPSILON
    right: (1 / 16) * 12 - EPSILON
    bottom: (1 / 16 * 2) - EPSILON
  
  chest_side:
    left: (1 / 16) * 10 + EPSILON
    top: (1 / 16) + EPSILON
    right: (1 / 16) * 11 - EPSILON
    bottom: (1 / 16 * 2) - EPSILON
  
  chest_top:
    left: (1 / 16) * 9 + EPSILON
    top: (1 / 16) + EPSILON
    right: (1 / 16) * 10 - EPSILON
    bottom: (1 / 16 * 2) - EPSILON
  
  furnace_front:
    left: (1 / 16) * 12 + EPSILON
    top: (1 / 16 * 2) + EPSILON
    right: (1 / 16) * 13 - EPSILON
    bottom: (1 / 16 * 3) - EPSILON
  
  furnace_side:
    left: (1 / 16) * 13 + EPSILON
    top: (1 / 16 * 2) + EPSILON
    right: (1 / 16) * 14 - EPSILON
    bottom: (1 / 16 * 3) - EPSILON
  
  furnace_top:
    left: (1 / 16) * 14 + EPSILON
    top: (1 / 16 * 3) + EPSILON
    right: (1 / 16) * 15 - EPSILON
    bottom: (1 / 16 * 4) - EPSILON

  gold:
    left: EPSILON
    top: (1 / 16 * 2) + EPSILON
    right: (1 / 16) - EPSILON
    bottom: (1 / 16 * 3) - EPSILON

  iron:
    left: (1 / 16) + EPSILON
    top: (1 / 16 * 2) + EPSILON
    right: (1 / 16) * 2 - EPSILON
    bottom: (1 / 16 * 3) - EPSILON
  
  coal:
    left: (1 / 16) * 2 + EPSILON
    top: (1 / 16 * 2) + EPSILON
    right: (1 / 16) * 3 - EPSILON
    bottom: (1 / 16 * 3) - EPSILON
  
  stone:
    left: (1 / 16) + EPSILON
    top: EPSILON
    right: (1 / 16) * 2 - EPSILON
    bottom: (1 / 16) - EPSILON
  
  bush:
    left: (1 / 16) * 7 + EPSILON
    top: (1 / 16 * 2) + EPSILON
    right: (1 / 16) * 8 - EPSILON
    bottom: (1 / 16 * 3) - EPSILON

textures.generateCoords = (texture) ->
  coords =
    front: [
      texture.left, texture.bottom
      texture.right, texture.bottom
      texture.right, texture.top
      texture.left, texture.top
    ]
    
    back: [
      texture.right, texture.bottom
      texture.right, texture.top
      texture.left, texture.top
      texture.left, texture.bottom
    ]
    
    top: [
      texture.left, texture.top
      texture.left, texture.bottom
      texture.right, texture.bottom
      texture.right, texture.top
    ]
    
    bottom: [
      texture.right, texture.top
      texture.left, texture.top
      texture.left, texture.bottom
      texture.right, texture.bottom
    ]
    
    right: [
      texture.right, texture.bottom
      texture.right, texture.top
      texture.left, texture.top
      texture.left, texture.bottom
    ]
    
    left: [
      texture.left, texture.bottom
      texture.right, texture.bottom
      texture.right, texture.top
      texture.left, texture.top
    ]