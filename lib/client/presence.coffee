module.exports = ({client}) ->
  {db} = client
  
  ul = $ '<ul>'
  ul.addClass 'presence-list'
  ul.appendTo document.body