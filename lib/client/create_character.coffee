module.exports = (auth) ->
  {ui, user, client} = auth
  {modals} = ui
  
  modals.createCharacter.modal 'show'
  
  modals.createCharacter.find('.create-character-btn').click ->
    modals.createCharacter.modal 'hide'
    
    user.characters.new
      name: modals.createCharacter.find('.name-input').val()
      class: 'priest'
    
    modals.characters.modal 'show'