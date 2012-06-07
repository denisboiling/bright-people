window.setup_ajax_articles_loading = ->
  return if $('.articles_container').length == 0
  
  regex = /page=(\d+)/
  window._page =
    if regex.test(window.location.href)
      parseInt regex.exec(window.location.href)[1]
    else
      1
  
  update_articles = ->
    data =
      remote: true,
      page: window._page,
      categories_ids: window._articles_categories.join(',')
    
    $.ajax
      url: '/articles',
      type: 'GET',
      data: data,
      success: (response) ->
        $('.common .articles_container').html(response)
  
  $('.articles_category input[type=checkbox]').bind 'change', ->
    window._articles_categories = []
    for elt in $('.articles_category input[type=checkbox]') when $(elt).is(':checked')
      window._articles_categories.push $(elt).attr('data-id')
    update_articles()