window.setup_ajax_news_loading = ->
  return if $('.news_container').length == 0
   
  regex = /page=(\d+)/
  window._page =
    if regex.test(window.location.href)
      parseInt regex.exec(window.location.href)[1]
    else
      1
  
  window._sort = 'created_at'
  
  update_news = ->
    data =
      sort: window._sort
      remote: true,
      page: window._page,
    
    $.ajax
      url: '/news',
      type: 'GET',
      data: data,
      success: (response) ->
        $('.common .news_container').html(response)
    
  # open pages with selected categories
  $('.pager .page a').bind 'click', (event) ->
    event.preventDefault()
    page = $(this).text()
    url = "/news?page=#{page}"
    window.location.href = url
  
  $('.sort_date a').bind 'click', (event) ->
    event.preventDefault()
    window._sort = 'created_at'
    update_news()
  
  $('.sort_comment a').bind 'click', (event) ->
    event.preventDefault()
    window._sort = 'comments_count DESC'
    update_news()
