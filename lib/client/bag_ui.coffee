module.exports = ({keyboard, bag}) ->
  show = no
  
  keyboard.on 'press', (event) ->
    if event.key is 'b'
      if show is no
        show = yes
        ($ '.bag').show()
      else
        show = no
        ($ '.bag').hide()
  
  bag.on 'add', (item) ->
    $('.bag').empty()
    
    rows = []
    numRows = Math.floor (bag.items.length / 4)
    for rowIndex in [0...numRows + 1]
      rows[rowIndex] = row = $ '<div class="row-fluid row-bag">'
      ($ '.bag').append row
    
    for item, index in bag.items
      rowIndex = Math.floor (index / 4)
      row = rows[rowIndex]
      
      slot = $ '<div class="span3">'
      slot.text item.key
      row.append slot
      
      slot.attr 'id', "#{index}:#{item.key}"
      
      slot.attr 'draggable', 'true'
    
      slot.bind 'dragstart', (e) ->
        e = e.originalEvent
        e.dataTransfer.effectAllowed = 'copy'
        e.dataTransfer.setData 'id', this.id
        e.dataTransfer.setData 'text', item.key
  
  ($ '.toolbar').bind 'dragover', (e) ->
    e.preventDefault()
    e = e.originalEvent
    ($ this).addClass 'over'
    e.dataTransfer.dropEffect = 'copy'
    return false
  
  ($ '.toolbar').bind 'dragleave', (e) ->
    ($ this).removeClass 'over'
  
  ($ '.toolbar').bind 'drop', (e) ->
    e.stopPropagation()
    e = e.originalEvent
    
    el = $ (document.getElementById (e.dataTransfer.getData 'id'))
    ($ e.target).data 'key', (e.dataTransfer.getData 'text')
    ($ e.target).text (e.dataTransfer.getData 'text')