module.exports = ({client}) ->
  {db} = client
  
  ul = $ '<ul>'
  ul.addClass 'presence-list'
  ul.appendTo document.body
  
  client.io.on db.online.id, (op, data) ->
    if op is 'add'
      li = $ '<li>'
      li.text data
      li.appendTo ul