window.setup_favourite_button = ->
  $("#favourite_link").live 'click', (event) ->
    event.preventDefault()
    $.ajax
      type: 'POST',
      url: '/favourites',
      data: { url: document.URL }
