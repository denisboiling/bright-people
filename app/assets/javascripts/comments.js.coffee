window.add_comment = ->

  $('a.create_comment').live 'click', (event) ->
    data_id = $(this).attr('data-id')
    ancestor = $(this).parent();
    $(this).replaceWith("<div class='add_comment'>"+$('.add_comment').html()+"</div>")
    if data_id
      ancestor.find('input.submit_comment').attr('data-id', data_id)
    false

  $('input.submit_comment').live 'click', (event) ->
    expert_id = $('#expert_id').val()
    logged_in = $('.is_login').length != 0
    
    if !expert_id and !logged_in
      $("#register_dialog").removeClass('hidden')
      return

    parent_id = $(this).attr('data-id')
    relation = document.URL.match(/\/[_A-Za-z0-9]+\//)[0].match(/[_A-Za-z0-9]+/)[0]
    relation =
      switch (relation)
        when "articles" then "Article"
        when "interviews" then "Interview"
        when "contests" then "ContestMembership"
        when "special_projects" then "SpecialProject"
    
    relation_id = document.URL.match(/(\d+)$/)[0]
    if parent_id
      subcomment = $(this).parent().parent()
      textarea = $(subcomment).find('textarea')
    else
      textarea = $(this).parent().parent().find('textarea')
    
    data =
      parent_id: parent_id,
      relation_type: relation,
      relation_id: relation_id,
      text: $(textarea).val()
    
    data.expert_id = expert_id if expert_id
    
    $.ajax
      type: 'POST',
      url: '/comments',
      data: data
      success: (data) ->
        $(textarea).val('')
        if parent_id
          $(subcomment.parent().parent().find('>ul')).append(data)
          $(subcomment).replaceWith("<a class='create_comment reply' data-id=" + parent_id + " href=''>Ответить на комментарий</a>")
        else
          $(".treeview").removeClass('hidden')
          $("div.treeview").append("<ul>"+data+"</ul>")

      error: () ->
          $(subcomment).replaceWith("<a class='create_comment reply' data-id=" + parent_id + " href=''>Ответить на комментарий</a>")
