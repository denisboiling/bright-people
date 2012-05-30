window.add_comment = ->

  $('a.create_comment').live 'click', (event) ->
    data_id = $(this).attr('data-id')
    subcomment = $(this).parent('div.subcomment')
    $(this).replaceWith($('div.comment_form').html())
    if data_id
      $(subcomment).find('input.submit_comment').attr('data-id', data_id)
    false

  $('input.submit_comment').live 'click', (event) ->
    parent_id = $(this).attr('data-id')
    if parent_id
      subcomment = $(this).parent('div.subcomment')
      textarea = $(subcomment).find('textarea')
    else
      textarea = $(this).parent().find('textarea')

    $.ajax
      type: 'POST',
      url: '/comments',
      data:
        parent_id: parent_id,
        relation_type: relation,
        relation_id: relation_id,
        text: $(textarea).val()

      success: (data) ->
        $(textarea).val('')
        if parent_id
          $(subcomment).html(data)
        else
          $("div.comments_list").append(data)
