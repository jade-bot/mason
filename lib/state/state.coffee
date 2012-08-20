class State extends Entity
  constructor: (args = {}) ->
    super
    
    @enter = args.enter
    @exit = args.exit
    
    @key = args.key