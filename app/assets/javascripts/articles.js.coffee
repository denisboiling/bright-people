window.setup_ajax_articles_loading = ->
  return if $('.articles_container').length == 0
  
  window._articles_categories = []
  
  regex = /page=(\d+)/
  window._page =
    if regex.test(window.location.href)
      parseInt regex.exec(window.location.href)[1]
    else
      1
  
  window._sort = 'created_at'
  
  update_articles = ->
    data =
      sort: window._sort
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
  
  # open pages with selected categories
  $('.pager .page a').bind 'click', (event) ->
    event.preventDefault()
    page = $(this).text()
    url = "/articles?page=#{page}"
    if window._articles_categories.length != 0
      url += "&categories_ids=#{window._articles_categories.join(',')}"
    window.location.href = url
  
  $('.sort_date a').bind 'click', (event) ->
    event.preventDefault()
    window._sort = 'created_at'
    update_articles()
  
  $('.sort_comment a').bind 'click', (event) ->
    event.preventDefault()
    window._sort = 'comments_count'
    update_articles()