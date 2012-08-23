Bag = require '../bag'

module.exports = ({keyboard, character, client}) ->
  character.bag = bag = client.bag = new Bag
  
  bag.ui = (require './bag_ui') keyboard: keyboard, bag: bag