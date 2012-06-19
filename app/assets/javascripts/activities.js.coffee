check_used_tags = ->
  params = window.location.href.split('?')[1]
  return unless params
  regex = /tag=([\d,]+)/
  return unless regex.test(params)
  ids = regex.exec(params)[1].split(',')
  for id in ids
    $("label[for=direction_tag_#{id}]").find('.sim_check').addClass('active')

window.setup_activities_list = ->
  $(".filter_sorter li label, #only_approved").live 'click', ->
    idCheck = $(this).attr("for")

    if $('#' + idCheck).is(':checked')
      $(this).find("span").removeClass("active");
    else
      $(this).find("span").addClass("active");
  
  $(".remote_action").bind 'change', ->
    $("#remote_form").submit()

  $("form#remote_form").bind "ajax:success", (xhr, data, status) ->
    $("div.activities").html(data)
    window.setup_raty()

  $("a.order_by").bind 'click', (event) ->
    event.preventDefault()
    
    if $(this).hasClass('bold')
      $(this).removeClass('bold')
      $("input#order_by").val("")
    else
      $("a.order_by.bold").each ->
        $(this).removeClass('bold')
      $(this).addClass('bold')
      $("input#order_by").val($(this).attr('data-order'))

    $("form#remote_form").submit()

  $("a.clear_link").live 'click', (event) ->
    event.preventDefault()
    
    val = $(this).attr('data-val')
    # TODO: brrr  
    if $(this).parent('div').hasClass('selected_region')
      option = $('select#region option[value="' + val + '"]')
      $("select#faker-region").append($(option).removeAttr('selected'))  
    else
      option = $('select#metro option[value="' + val + '"]')
      $("select#faker-metro").append($(option).removeAttr('selected'))  
    $(this).remove()
    $("#remote_form").submit()

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
  
  check_used_tags()

window.setup_activities_approval = ->
  $('.approve_activity_link').bind 'click', (event) ->
    event.preventDefault()
    $('#activity_approve_dialog').removeClass('hidden')

window.setup_lightbox = ->
  $("a[rel^='prettyPhoto']").prettyPhoto(social_tools: false)
  $('#pikame').PikaChoose(carousel: true, autoPlay: false)
  
  $('.pikachoose .mask').bind 'click', ->
    PikaChoose = $('#pikame').data('pikachoose')
    element = PikaChoose.active
    class_name = element.attr('data-hook-class')
    $("#lightbox_hook .#{class_name}").trigger('click')
