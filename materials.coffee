{Material} = require './mason'

module.exports = materials =
  terrain: (image: '/terrain.png', program: 'terrain')
  line: (program: 'line')
  wolf: (image: '/wolf.png', program: 'terrain')