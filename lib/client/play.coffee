terraform = require '../terraform'
extract = require '../volume_extractor'

module.exports = ({Volume, Avatar, Client}, resources) ->
  client = new Client resources: resources
  {simulation, library, camera, keyboard, mouse} = client
  
  simulation.on 'tick', -> camera.emit 'request:movement'
  
  vec3.set [8, 74, 18], camera.position
  # client.camera.lookTo [8, 64, 8]
  
  volume = new Volume material: library.materials.terrain
  terraform volume
  extract volume
  simulation.add volume
  
  (require './controls')
    subject: camera
    keyboard: keyboard
    mouse: mouse
  
  # extensions = (require './extensions') gl
  # ui = (require './play_ui') extensions