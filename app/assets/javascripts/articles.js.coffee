window.setup_ajax_articles_loading = ->
  return if $('.journal_post').length == 0
  
  regex = /page=(\d+)/
  window._page =
    if regex.test(window.location.href)
      parseInt regex.exec(window.location.href)[1]
    else
      1
  
  update_articles = ->
    $.ajax
      url: '/articles',
      type: 'GET',
      data:
        remote: true
        page: window._page
        category_id: window._articles_category_id
      success: (response) ->
        $('.journal_post').html(response)
  
  $('.rubric_list a.article, .personality_wrapper a.cat').live 'click', (event) ->
    event.preventDefault()
    window._articles_category_id = $(this).attr('data-id')
    update_articles()

  # open pages with selected categories
  $('.pager .page a').bind 'click', (event) ->
    event.preventDefault()
    page = $(this).text()
    url = "/articles?page=#{page}"
    if window._articles_category_id
      url += "&category_id=#{window._articles_category_id}"
    window.location.href = url


  $('a#news').live 'click', (event) ->
    event.preventDefault()
    $.ajax
      url: '/news',
      type: 'GET',
      data:
        remote: true
        page: window._page
      success: (response) ->
        $('.journal_post').html('<div class="title">Новости</div>'+response)
    
