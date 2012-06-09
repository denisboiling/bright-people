window.setup_activities_list = ->

  $(".remote_action").bind 'change', ->
    $("#remote_form").submit()

  $("form#remote_form").bind "ajax:success", (xhr, data, status) ->
    $("div.activities").html(data)
    window.setup_raty()

  $("a.order_by").bind 'click', ->
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

  $("select#select_metro").bind 'change', ->
    selected = $("select option:selected").first()
    val = $(selected).val()
    text = $(selected).text()
    $("div.selected_metro").append("<a class='clear_link' href='' " + 'data-val=' + val + ">" + text + "</a> ")
    $("select#metro").append(selected)
    $("#remote_form").submit()

window.setup_activities_approval = ->
  $('.approve_activity_link').bind 'click', (event) ->
    event.preventDefault()
    $('#activity_approve_dialog').removeClass('hidden')
