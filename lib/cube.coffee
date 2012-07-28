module.exports = cube = {}

cube.vertices =
  front: [
    +0.0, +0.0, +1.0
    +1.0, +0.0, +1.0
    +1.0, +1.0, +1.0
    +0.0, +1.0, +1.0
  ]

  back: [
    +0.0, +0.0, +0.0
    +0.0, +1.0, +0.0
    +1.0, +1.0, +0.0
    +1.0, +0.0, +0.0
  ]

  top: [
    +0.0, +1.0, +0.0
    +0.0, +1.0, +1.0
    +1.0, +1.0, +1.0
    +1.0, +1.0, +0.0
  ]

  bottom: [
    +0.0, +0.0, +0.0
    +1.0, +0.0, +0.0
    +1.0, +0.0, +1.0
    +0.0, +0.0, +1.0
  ]
  
  right: [
    +1.0, +0.0, +0.0
    +1.0, +1.0, +0.0
    +1.0, +1.0, +1.0
    +1.0, +0.0, +1.0
  ]
  
  left: [
    +0.0, +0.0, +0.0
    +0.0, +0.0, +1.0
    +0.0, +1.0, +1.0
    +0.0, +1.0, +0.0
  ]

cube.normals =
  front: [
    +0.0, +0.0, +1.0
    +0.0, +0.0, +1.0
    +0.0, +0.0, +1.0
    +0.0, +0.0, +1.0
  ]
  
  back: [
    +0.0, +0.0, -1.0
    +0.0, +0.0, -1.0
    +0.0, +0.0, -1.0
    +0.0, +0.0, -1.0
  ]
  
  top: [
    +0.0, +1.0, +0.0
    +0.0, +1.0, +0.0
    +0.0, +1.0, +0.0
    +0.0, +1.0, +0.0
  ]
  
  bottom: [
    +0.0, -1.0, +0.0
    +0.0, -1.0, +0.0
    +0.0, -1.0, +0.0
    +0.0, -1.0, +0.0
  ]
  
  right: [
    +1.0, +0.0, +0.0
    +1.0, +0.0, +0.0
    +1.0, +0.0, +0.0
    +1.0, +0.0, +0.0
  ]
  
  left: [
    -1.0, +0.0, +0.0
    -1.0, +0.0, +0.0
    -1.0, +0.0, +0.0
    -1.0, +0.0, +0.0
  ]

cube.coords =
  front: [
    0.0, 0.0
    1.0, 0.0
    1.0, 1.0
    0.0, 1.0
  ]
  
  back: [
    1.0, 0.0
    1.0, 1.0
    0.0, 1.0
    0.0, 0.0
  ]
  
  top: [
    0.0, 1.0
    0.0, 0.0
    1.0, 0.0
    1.0, 1.0
  ]
  
  bottom: [
    1.0, 1.0
    0.0, 1.0
    0.0, 0.0
    1.0, 0.0
  ]
  
  right: [
    1.0, 0.0
    1.0, 1.0
    0.0, 1.0
    0.0, 0.0
  ]
  
  left: [
    0.0, 0.0
    1.0, 0.0
    1.0, 1.0
    0.0, 1.0
  ]

cube.indices =
  front:  [0,  1,  2,  0,  2,  3]
  back:   [4,  5,  6,  4,  6,  7]
  top:    [8,  9,  10, 8,  10, 11]
  bottom: [12, 13, 14, 12, 14, 15]
  right:  [16, 17, 18, 16, 18, 19]
  left:   [20, 21, 22, 20, 22, 23]