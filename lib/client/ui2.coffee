module.exports = (client, demos) ->
  dom = $ document.body

  demoMenu = $ '<div>'
  demoMenu.css
    width: '100%'
    height: '100%'
    left: 0
    top: 0
    position: 'absolute'
    color: 'rgb(200, 200, 200)'
    'margin-top': 40
  demoMenu.appendTo dom
  
  for demo in demos then do (demo) =>
    el = $ '<li>'
    el.text demo.key
    el.appendTo demoMenu
    
    el.click ->
      demoMenu.fadeOut()
      
      client.runDemo demo
    
    # thumbnail = $ '<img>'
    # thumbnail.attr src: demo.thumbnail
    # thumbnail.css position: 'absolute', left: 0
    # thumbnail.appendTo el
    
    # unless demo.thumbnail
    # demo.thumbnail = 
  
  properties = $ '<ul>'
  properties.css
    width: '25%'
    height: '50%'
    right: 0
    bottom: 0
    position: 'absolute'
    color: 'rgb(200, 200, 200)'
  properties.appendTo dom
  
  inspect = (entity) ->
    properties.empty()
    
    for property in ['position']
      properties.append $ "<li>#{JSON.stringify entity[property]}</li>"
  
  entities = $ '<ul>'
  entities.css
    width: '25%'
    height: '50%'
    left: 0
    bottom: 0
    position: 'absolute'
    color: 'rgb(200, 200, 200)'
  entities.appendTo dom
  
  for key, entity of client.simulation.entities then do (key, entity) =>
    entity.element = $ "<li>#{entity.id}</li>"
    
    entities.append entity.element
    
    entity.element.click ->
      for key, clearingEntity of client.simulation.entities
        clearingEntity.selected = no
      
      entity.selected = yes
      
      inspect entity