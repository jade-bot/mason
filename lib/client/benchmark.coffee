{terraform, Volume} = require '../mason'

module.exports = ->
  for i in [1...20]
    console.time i
    volume = new Volume
    terraform volume
    volume.extract()
    console.timeEnd i