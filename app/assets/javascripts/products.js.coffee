# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
searchTimer = null;
doneTypingInterval = 500;

$("#search").bind("keyup", () -> 
  _this = $(this)
  if searchTimer 
    clearTimeout(searchTimer)
  searchTimer = setTimeout((() -> 
      $.ajax(
        type:'get',
        url: '/products.js',
        data: _this.parents("form").serialize()
      )
    ),
    doneTypingInterval
  )
  
  

)