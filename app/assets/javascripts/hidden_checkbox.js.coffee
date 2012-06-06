window.setup_hidden_checkbox = ->
  $("label.hidden_checkbox").live 'click', ->
    input = $("#" + $(this).attr('for'))
    if $(input).attr('checked')
      $(input).attr('checked', true)
      $(input).parent().find("span").addClass("active")
    else
      $(input).attr('checked', false)
      $(input).parent().find("span").removeClass("active")
