Entity = require '../entity'

module.exports = (auth) ->
  ui = new Entity
  
  modals =
    auth: $ '#auth'
  
  modals.auth.modal 'show'
  
  modals.auth.find('.login-btn').click ->
    auth.login
      alias: (modals.auth.find '.login-pane .alias').val()
      secret: (modals.auth.find '.login-pane .secret').val()
    , (error) ->
      if error
        (modals.auth.find '.login-pane .secret-control-group').addClass 'error'
        (modals.auth.find '.login-pane .alias-control-group').addClass 'error'
      else
        (modals.auth.find '.login-pane .secret-control-group').removeClass 'error'
        (modals.auth.find '.login-pane .alias-control-group').removeClass 'error'
        modals.auth.fadeOut()
  
  modals.auth.find('.join-btn').click ->
    auth.join
      alias: (modals.auth.find '.join-pane .alias').val()
      email: (modals.auth.find '.join-pane .email').val()
      secret: (modals.auth.find '.join-pane .secret').val()
    , (errors) ->
      if errors?
        (modals.auth.find '.join-pane .control-group').removeClass 'error'
        (modals.auth.find '.join-pane .control-group').find('.help-inline').empty()
        
        if errors.secret? then (modals.auth.find '.join-pane .secret-control-group').addClass 'error'
        if errors.alias? then (modals.auth.find '.join-pane .alias-control-group').addClass 'error'
        if errors.email? then (modals.auth.find '.join-pane .email-control-group').addClass 'error'
        
        for key, error of errors
          (modals.auth.find ".join-pane .#{key}-control-group").find('.help-inline').text error
      else
        (modals.auth.find '.join-pane .secret-control-group').removeClass 'error'
        (modals.auth.find '.join-pane .alias-control-group').removeClass 'error'
        (modals.auth.find '.join-pane .email-control-group').removeClass 'error'
        
        modals.auth.fadeOut()
  
  # characterModal = $ '#character'
  # characterModal.data 'update', ->
  #   if character = db.selectedCharacter
  #     characterModal.find('.name').val character.name
  
  # createCharacterModal = $ '#create-character'
  
  # charactersModal = $ '#characters'
  
  
  
  # 
  
  # client.io.on 'join', (user) ->
  #   client.io.emit 'login',
  #     alias: user.alias
  #     secret: user.secret
  
  # client.io.on 'login', (user, ids) ->
  #   db.online = new Collection id: ids.online
  #   persist.collection db.online
    
  #   (require './presence')
  #     client: client
    
  #   modal.modal 'hide'
    
  #   charactersModal.modal 'show'
    
  #   (require './create_character') createCharacterModal: createCharacterModal, charactersModal: charactersModal, db: db
  #   (require './play_character') createCharacterModal: createCharacterModal, charactersModal: charactersModal, db: db
  
  return ui