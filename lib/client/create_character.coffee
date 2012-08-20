Character = require '../character'

module.exports = ({db, charactersModal, createCharacterModal}) ->
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
  
  db.characters.on 'add', ->
    charactersModal.find('.characters').empty()
    
    for id, character of db.characters.members then do (id, character) =>
      li = $ "<li>#{character.name}</li>"
      li.on 'click', ->
        db.character = character
        
        charactersModal.modal 'hide'
        characterModal.modal 'show'
      
      charactersModal.find('.characters').append li