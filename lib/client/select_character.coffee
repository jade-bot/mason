module.exports = (auth) ->
  {ui, user, client} = auth
  {modals} = ui
  
  user.characters.on 'change', ->
    modals.characters.find('.characters').empty()
    
    for id, character of user.characters.members then do (id, character) =>
      li = $ "<li>#{character.name}</li>"
      li.on 'click', ->
        modals.characters.modal 'hide'
        
        client.emit 'play', character
        
        (require './play_character')
          client: client
          character: character
      
      modals.characters.find('.characters').append li
  
  modals.characters.modal 'show'
  
  modals.characters.find('.create-character-btn').click ->
    modals.characters.modal 'hide'
    
    (require './create_character') auth