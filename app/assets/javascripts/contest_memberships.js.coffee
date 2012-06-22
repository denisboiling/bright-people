window.setup_ajax_contest_memberships_loading = ->
  return if $('.memberships_container').length == 0
   
  regex = /page=(\d+)/
  window._page =
    if regex.test(window.location.href)
      parseInt regex.exec(window.location.href)[1]
    else
      1
  
  window._sort = 'created_at'
  
  update_contest_memberships = ->
    data =
      sort: window._sort
      remote: true,
      page: window._page,
    
    $.ajax
      url: document.URL.split("?")[0],
      type: 'GET',
      data: data,
      success: (response) ->
        $('.common .memberships_container').html(response)
    
  # open pages with selected categories
  $('.pager .page a').live 'click', (event) ->
    event.preventDefault()
    page = $(this).text()
    url = document.URL.split("?")[0]+"?page=#{page}"
    url = url + "&sort="+window._sort if window._sort
    window.location.href = url
  
  $('.sort_date a').bind 'click', (event) ->
    event.preventDefault()
    window._sort = 'created_at'
    update_contest_memberships()
  
  $('.sort_comment a').bind 'click', (event) ->
    event.preventDefault()
    window._sort = 'comments_count DESC'
    update_contest_memberships()

  $('.sort_rating a').bind 'click', (event) ->
    event.preventDefault()
    window._sort = 'rating DESC'
    update_contest_memberships()

window.setup_member_lightbox = ->
  return if $('.work_detail').length == 0

  $('.work_detail .right_part .thumb').live 'click', ->
    $("#lightbox_hook .light_box_pic").trigger('click')
