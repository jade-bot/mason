Collection = require '../collection'

persist = require '../persist'

module.exports = ({simulation, client, keyboard, mouse, camera, library}) ->
  {db} = client
  
  modal = $ '#login'
  modal.modal 'show'
  
  characterModal = $ '#character'
  characterModal.data 'update', ->
    if character = db.selectedCharacter
      characterModal.find('.name').val character.name
  
  createCharacterModal = $ '#create-character'
  
  charactersModal = $ '#characters'
  
  modal.find('.login-btn').click ->
    modal.modal 'hide'
    client.io.emit 'login',
      alias: (modal.find '.login-pane .alias').val()
      secret: (modal.find '.login-pane .secret').val()
  
  modal.find('.join-btn').click ->
    client.io.emit 'join',
      alias: (modal.find '.join-pane .alias').val()
      email: (modal.find '.join-pane .email').val()
      secret: (modal.find '.join-pane .secret').val()
  
  client.io.on 'join', (user) ->
    client.io.emit 'login',
      alias: user.alias
      secret: user.secret
  
  client.io.on 'login', (user, ids) ->
    db.online = new Collection id: ids.online
    persist.collection db.online
    
    (require './presence')
      client: client
    
    modal.modal 'hide'
    
    charactersModal.modal 'show'
    
    (require './create_character') createCharacterModal: createCharacterModal, charactersModal: charactersModal, db: db
    (require './play_character') createCharacterModal: createCharacterModal, charactersModal: charactersModal, db: db