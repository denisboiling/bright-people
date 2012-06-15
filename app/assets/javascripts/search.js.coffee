window.setup_search_tabs = ->
  return if $(".search_filter").length == 0
  $(".search_filter a").first().addClass('active')
  $(".search_filter a").first().prepend('<span class=\"mask\"></span>')

  $(".pager .page a").live 'click', (event) -> 
    if $(".search_filter .active").text() != 'Все разделы'
      event.preventDefault()
      category = $(".search_filter .active").text()
      data =
        q: $(".search_title span").text().split('\"')[1]
        category: category
        remote: true
        page: $(this).text()

      $.ajax
        url: '/search',
        type: 'GET',
        data: data,
        success: (response) ->
          $('.search_list').html(response)
          $(".pager .page").removeClass('current')
          $(this).parent().addClass('current')

  $(".search_filter a").live 'click', (event) ->
    event.preventDefault()

    if $(this).text() == 'Все разделы'
        category = ''
    else category = $(this).text()
    $(".search_filter a").removeClass('active')
    $(".search_filter a .mask").remove();
    $(this).addClass('active')
    $(this).prepend('<span class=\"mask\"></span>')
    data =
      q: $(".search_title span").text().split('\"')[1]
      category: category
      remote: true

    $.ajax
      url: '/search',
      type: 'GET',
      data: data,
      success: (response) ->
        $('.search_list').html(response)
