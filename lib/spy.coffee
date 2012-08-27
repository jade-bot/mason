  # ($ '.navbar').hide()
  
  # grid = $ """
  # <div class="row-fluid show-grid network-grid">
  #   <div class="span6 server">
  #     <p><i class="icon-hdd"></i></p>
  #     <ul class="collections"></ul>
  #   </div>
  #   <div class="span6 client">
  #     <p><i class="icon-folder-close"></i></p>
  #     <p class="id"></p>
  #   </div>
  # </div>
  # """
  
  # grid.appendTo document.body
  
  # socket = io.connect()
  
  # clientSpan = grid.find '.client'
  # clientSpan.hide()
  
  # socket.on 'client', (client) ->
  #   clientSpan.show()
  #   clientSpan.find('.id').text client.id
  
  # socket.on 'db', (packet) ->
  #   for key, pack of packet
  #     li = $ '<li>'
  #     li.text "#{pack.key} (#{pack.id})"
  #     grid.find('.collections').append li