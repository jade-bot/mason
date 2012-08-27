blocks = require '../../blocks'

module.exports = ({Spool, Avatar, Axes, Client, Character, Collection, Cube}, resources) ->
  ($ '.navbar').hide()
  
  client = new Client resources: resources
  {simulation, library, camera, keyboard, mouse} = client
  
  camera.position = [5, 5, 5]
  camera.lookAt simulation.origin
  
  axes = new Axes material: library.materials.line
  simulation.add axes
  
  toolbar = $ """
  <div class="navbar navbar-fixed-bottom navbar-inverse">
    <div class="navbar-inner">
      <div class="container">
        <ul class="nav toolbar">
          <!--<li><a href="#" data-key="dirt"></a></li>-->
        </ul>
      </div>
    </div>
  </div>
  """
  
  toolbar.appendTo document.body
  
  tools = {}
  tools.cube = ->
    cube = new Cube material: library.materials.line
    simulation.add cube
  
  for tool in ['cube']
    li = $ '<li>'
    li.text 'cube'
    toolbar.find('.toolbar').append li
    
    li.click ->
      tools[tool]()
  
  client.on 'load', ->
    (require './pick')
      simulation: simulation
      camera: camera
      client: client
      mouse: mouse