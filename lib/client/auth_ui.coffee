Entity = require '../entity'

module.exports = (auth) ->
  ui = new Entity
  
  ui.modals = modals =
    auth: $ '#auth'
    characters: $ '#characters'
    createCharacter: $ '#create-character'
  
  modals.auth.modal 'show'
  
  modals.auth.find('.login-pane .test-btn').click ->
    (modals.auth.find '.login-pane .alias').val 'pyro'
    (modals.auth.find '.login-pane .secret').val 'secret'
    
    modals.auth.find('.login-pane .login-btn').click()
  
  modals.auth.find('.join-pane .test-btn').click ->
    (modals.auth.find '.join-pane .alias').val 'pyro'
    (modals.auth.find '.join-pane .email').val 'pyro@feisty.io'
    (modals.auth.find '.join-pane .secret').val 'secret'
    
    modals.auth.find('.join-pane .join-btn').click()
  
  modals.auth.find('.login-btn').click ->
    auth.login
      alias: (modals.auth.find '.login-pane .alias').val()
      secret: (modals.auth.find '.login-pane .secret').val()
    , (error) ->
      if error?
        (modals.auth.find '.login-pane .secret-control-group').addClass 'error'
        (modals.auth.find '.login-pane .alias-control-group').addClass 'error'
        
        # for key, error of errors
        #   (modals.auth.find ".login-pane .#{key}-control-group").find('.help-inline').text error
        
      else
        (modals.auth.find '.login-pane .secret-control-group').removeClass 'error'
        (modals.auth.find '.login-pane .alias-control-group').removeClass 'error'
        
        # modals.auth.fadeOut()
        modals.auth.modal 'hide'
  
  modals.auth.find('.join-btn').click ->
    auth.join
      alias: (modals.auth.find '.join-pane .alias').val()
      email: (modals.auth.find '.join-pane .email').val()
      secret: (modals.auth.find '.join-pane .secret').val()
    , (errors) ->
      if errors?
        (modals.auth.find '.join-pane .control-group').removeClass 'error'
        (modals.auth.find '.join-pane .control-group').find('.help-inline').empty()
        
        (modals.auth.find '.join-pane .secret-control-group').addClass if errors.secret? then 'error' else 'success'
        (modals.auth.find '.join-pane .alias-control-group').addClass if errors.alias? then 'error' else 'success'
        (modals.auth.find '.join-pane .email-control-group').addClass if errors.email? then 'error' else 'success'
        
        for key, error of errors
          (modals.auth.find ".join-pane .#{key}-control-group").find('.help-inline').text error
      else
        (modals.auth.find '.join-pane .secret-control-group').removeClass 'error'
        (modals.auth.find '.join-pane .alias-control-group').removeClass 'error'
        (modals.auth.find '.join-pane .email-control-group').removeClass 'error'
        
        # modals.auth.fadeOut()
        modals.auth.modal 'hide'
  
  return ui