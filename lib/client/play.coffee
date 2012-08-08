terraform = require '../terraform'
extract = require '../volume_extractor'

module.exports = ({Volume, Avatar, Client}, resources) ->
  client = {simulation, library, camera} = new Client resources: resources
  
  vec3.set [8, 74, 18], camera.position
  # client.camera.lookTo [8, 64, 8]
  
  volume = new Volume material: library.materials.terrain
  terraform volume
  extract volume
  simulation.add volume
  
  # extensions = (require './extensions') gl
  # ui = (require './play_ui') extensions