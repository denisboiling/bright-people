window.add_comment = ->

  $('a.create_comment').live 'click', (event) ->
    data_id = $(this).attr('data-id')
    ancestor = $(this).parent();
    $(this).replaceWith("<div class='add_comment'>"+$('.add_comment').html()+"</div>")
    if data_id
      ancestor.find('input.submit_comment').attr('data-id', data_id)
    false

  $('input.submit_comment').live 'click', (event) ->
    parent_id = $(this).attr('data-id')
    relation = document.URL.match(/\/[A-Za-z0-9]+\//)[0].match(/[A-Za-z0-9]+/)[0]
    switch (relation)
      when "news" then relation = "News"
      when "articles" then relation = "Article"
      when "interviews" then relation = "Interview"
      when "contests" then relation = "ContestMembership"
    relation_id = document.URL.match(/(\d+)$/)[0]
    if parent_id
      subcomment = $(this).parent().parent()
      textarea = $(subcomment).find('textarea')
    else
      textarea = $(this).parent().parent().find('textarea')

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
          $(subcomment.parent().parent().find('>ul')).append(data)
          $(subcomment).replaceWith("<a class='create_comment reply' data-id=" + parent_id + " href=''>Ответить на комментарий</a>")
        else
          $("div.treeview").append("<ul>"+data+"</ul>")
