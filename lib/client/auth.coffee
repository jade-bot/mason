Character = require '../character'
Collection = require '../collection'

module.exports = ({simulation, client, keyboard, mouse, camera, library}) ->
  {db} = client
  
  modal = $ '#login'
  modal.modal 'show'
  
  characterModal = $ '#character'
  characterModal.data 'update', ->
    if character = client.db.selectedCharacter
      characterModal.find('.name').val character.name
  
  createCharacterModal = $ '#create-character'
  
  charactersModal = $ '#characters'
  
  modal.find('.login-btn').click ->
    modal.modal 'hide'
    client.io.emit 'login',
      alias: (modal.find '.login-pane .alias').val()
      secret: (modal.find '.login-pane .secret').val()
  
  loading = $ """
  <div class="progress progress-striped active">
    <div class="bar" style="width: 40%;"></div>
  </div>
  """
  
  modal.find('.join-btn').click ->
    modal.find('.join-pane').append loading
    
    client.io.emit 'join',
      alias: (modal.find '.join-pane .alias').val()
      email: (modal.find '.join-pane .email').val()
      secret: (modal.find '.join-pane .secret').val()
  
  client.io.on 'join', (user) ->
    client.io.emit 'login',
      alias: user.alias
      secret: user.secret
  
  client.io.on 'login', (user, ids) ->
    client.db.online = new Collection id: ids.online
    
    (require './presence')
      client: client
    
    loading.remove()
    
    modal.modal 'hide'
    
    charactersModal.modal 'show'
    
    charactersModal.find('.create-character-btn').click ->
      charactersModal.modal 'hide'
      
      createCharacterModal.modal 'show'
    
    createCharacterModal.find('.create-character-btn').click ->
      createCharacterModal.modal 'hide'
      
      charactersModal.modal 'show'
      
      character = new Character
        name: createCharacterModal.find('.name-input').val()
        class: 'priest'
      client.db.characters.add character
    
    characterModal.find('.play-btn').click ->
      characterModal.modal 'hide'
      
      (require './play_character')
        simulation: simulation
        client: client
        mouse: mouse
        keyboard: keyboard
        library: library
        camera: camera
    
    db.characters.on 'add', ->
      charactersModal.find('.characters').empty()
      
      for id, character of db.characters.members then do (id, character) =>
        li = $ "<li>#{character.name}</li>"
        li.on 'click', ->
          db.character = character
          
          charactersModal.modal 'hide'
          
          characterModal.modal 'show'
        
        charactersModal.find('.characters').append li