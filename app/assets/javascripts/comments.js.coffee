window.setup_comments = ->
  $(".add_comment_link").live 'click', (event) ->
    event.preventDefault()
    
    $block = $(this).parent().find('.comment_text_block').first()
    $block.removeClass('hidden')
  
  $('.send_comment_link').live 'click', (event) ->
    event.preventDefault()
    
    url =
      switch
        when /articles\/(\d+)/.test(window.location.href)
          id = /articles\/(\d+)/.exec(window.location.href)[1]
          "/articles/#{id}/comments"
        when /interviews\/(\d+)/.test(window.location.href)
          id = /interviews\/(\d+)/.exec(window.location.href)[1]
          "/interviews/#{id}/comments"
        when /news\/(\d+)/.test(window.location.href)
          id = /news\/(\d+)/.exec(window.location.href)[1]
          "/news/#{id}/comments"
        when /special_projects\/(\d+)/.test(window.location.href)
          id = /special_projects\/(\d+)/.exec(window.location.href)[1]
          "/news/#{id}/comments"
    
    $block = $(this).parent()
    parent_id = $(this).attr('data-id')
    content = $block.find('textarea').val()
    $block.find('textarea').val('')
    $.ajax
      type: 'POST',
      url: url,
      data: {content: content, parent_comment_id: parent_id},
      success: (data) ->
        $block.addClass('hidden')
        $block.parent().find('.nested_comments').first().append(data)
