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
  
  slots = ($ '.bag').find '[class*="span"]'
  for slot in slots
    slot = $ slot
    slot.attr 'draggable', 'true'
    
    slot.bind 'dragstart', (e) ->
      e = e.originalEvent
      e.dataTransfer.effectAllowed = 'copy'
      e.dataTransfer.setData 'Text', this.id
  
  ($ '.toolbar').bind 'dragover', (e) ->
    e.preventDefault()
    e = e.originalEvent
    this.className = 'over'
    e.dataTransfer.dropEffect = 'copy'
    return false
  
  ($ '.toolbar').bind 'dragleave', (e) ->
    this.className = ''
  
  ($ '.toolbar').bind 'drop', (e) ->
    e.stopPropagation()
    e = e.originalEvent
    
    el = document.getElementById(e.dataTransfer.getData('Text'));
    console.log el
  
  bag.on 'add', (item) ->
    slots = $('.bag').find '[class*="span"]'
    
    # for slot in slots
    # ($ slot).text item
    
    ($ slots[0]).text item