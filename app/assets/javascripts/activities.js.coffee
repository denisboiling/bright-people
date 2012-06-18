window.setup_activities_list = ->

  $(".remote_action").bind 'change', ->
    $("#remote_form").submit()

  $("form#remote_form").bind "ajax:success", (xhr, data, status) ->
    $("div.activities").html(data)
    window.setup_raty()

  $("a.order_by").bind 'click', ->
    if $(this).hasClass('bold') then $(this).removeClass('bold') else $(this).addClass('bold')
    $("input#order_by").val($(this).attr('data-order'))
    $("form#remote_form").submit()
    false

  $("a.clear_link").live 'click', ->
    val = $(this).attr('data-val')
    option = $('select#metro option[value="' + val + '"]')
    $("select#select_metro").append($(option).removeAttr('selected'))
    $(this).remove()
    $("#remote_form").submit()
    false

  $("select.faker-select").bind 'change', ->
    id = $(this).attr('id')
    selected = $("##{id} :selected")
    val = $(selected).val()
    text = $(selected).text()
    selected_div = $("div." + $(this).attr('data-selected'))
    select_select = $("#" + $(this).attr('data-select'))
    $(selected_div).append("<a class='clear_link' href='' data-val=#{val}>#{text}</a> ")
    $(select_select).append(selected)
    $("#remote_form").submit()

window.setup_activities_approval = ->
  $('.approve_activity_link').bind 'click', (event) ->
    event.preventDefault()
    $('#activity_approve_dialog').removeClass('hidden')
