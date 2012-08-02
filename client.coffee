pages =
  edit: -> require './client/edit'
  play: -> require './client/play'

if window.location.hash.length > 0
  page = window.location.hash[1..]
  
  console.log 'paging', page
  
  pages[page]? page