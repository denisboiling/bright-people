window.setup_load_activity_comments = ->

  toogle_load_button =(button) ->
    if button.hasClass('hidden')
      button.removeClass('hidden')
      button.parent().find(".loading").remove()
    else
      button.addClass('hidden')
      button.parent().append("<div class='loading'></div>")

  $("a.load_comments").live 'click', ->
    link = $(this)
    regex = /activities\/(\d+)/
    activity_id = regex.exec(window.location.href)[1]
    page = parseInt($(this).attr('data-page')) + 1
    type = $(this).attr('data-type')
    $.ajax
      type: 'GET',
      url: "/activities/#{activity_id}/get_comments",
      data: { page: page, type: type, id: activity_id }
      success: (data) ->
        if data
          toogle_load_button(link.parent())
          link.closest('div.comment').find('ul').append(data)
          link.attr('data-page', page)
      beforeSend: (xhr) ->
        toogle_load_button(link.parent())
    false