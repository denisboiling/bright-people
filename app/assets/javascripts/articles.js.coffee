window.setup_ajax_articles_loading = ->
  return if $('.journal_post').length == 0
  
  window._articles_category = "";
  
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
      category: window._articles_category
    
    $.ajax
      url: '/articles',
      type: 'GET',
      data: data,
      success: (response) ->
        $('.journal_post').html(response)
  
  $('.rubric_list a').on 'click', (event) ->
    event.preventDefault()
    window._articles_category = if window._articles_category == $(this).text() then "" else $(this).text()
    update_articles()
  
  # open pages with selected categories
  $('.pager .page a').bind 'click', (event) ->
    event.preventDefault()
    page = $(this).text()
    url = "/articles?page=#{page}"
    if window._articles_category
      url += "&category=#{window._articles_category}"
    window.location.href = url
