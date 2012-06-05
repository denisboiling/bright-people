window.setup_activities_list = ->

  $(".remote_action").bind 'change', ->
    form = $("#remote_form")
    form.submit()

  $("form#remote_form").bind "ajax:success", (xhr, data, status) ->
    $("div.activities").html(data)
    window.setup_raty()

  $("a.order_by").bind 'click', ->
    $("input#order_by").val($(this).attr('data-order'))
    $("form#remote_form").submit()
    false