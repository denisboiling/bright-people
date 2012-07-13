#= require active_admin/base
#= require cocoon
#= require autocomplete-rails
#= require wysihtml5-0.3.0.min
#= require advanced
#= require jquery-ui-timepicker-addon
#= require jquery-ui-timepicker-ru
#= require chosen.jquery.min
#= require admin/edit_map

setup_picture_urls = ->
  return if $("span.get_host_url").length == 0
  $("span.get_host_url").each ->
    $(this).text("http://images.bright-people.ru#{$(this).text()}")

setup_activity_categories = ->
  return if $("select#activity_is_educational").length == 0
  $("select#activity_is_educational").bind 'change', ->
    chose =  $(this + '' + ':selected').val()
    $.ajax '/admin/activities/get_categories',
      type: 'GET'
      data: {is_educational: chose }
      success: (response) ->
        $("select#activity_direction_tag_ids").html(response)
  
setup_schedule = ->
  return if $("ul.schedule_days").length == 0
  days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday',
          'saturday', 'sunday']
  
  update_fields = (values) ->
    for day in days
      chunks = []
      $("li[data-day-name=#{day}] .time_block").each ->
        start = $(this).find('.time_start').val()
        end = $(this).find('.time_end').val()
        chunks.push {start: start, end: end}
      $("#activity_#{day}").val JSON.stringify(chunks)
  
  add_interval = ($li, value) ->
    block = $('<div class="time_block">')
    $li.append(block)
    block.append('<input class="time_start">')
    block.append('<input class="time_end">')
    block.append('<a href="#" class="close_time_box_link">x</a>')
    block.find("input").timepicker(ampm: false, onSelect: update_fields)
    if (value)
      block.find('.time_start').val(value.start)
      block.find('.time_end').val(value.end)
  
  old = {}
  for day in days
    val = $("#activity_#{day}").val()
    old[day]  = JSON.parse(val) unless val == ''
    old[day] ?= []
    for interval in old[day]
      $li = $("li[data-day-name=#{day}]")
      add_interval($li, interval)
  
  $('.close_time_box_link').live 'click', (event) ->
    event.preventDefault()
    $(this).closest('.time_block').remove()
    update_fields()
  
  $('.time_start, .time_end').live 'focusout', ->
    update_fields()
    
  $('.schedule_day_link').bind 'click', (event) ->
    event.preventDefault()
    
    $li = $(this).closest('li')
    add_interval($li)

setup_chosen = ->
  if $("select.chosen_autocomplete").length >= 1
    $("select.chosen_autocomplete").chosen()

setup_photos_removing = ->
  $('a.remove_video').live 'click', () ->
    object_id = $(this).attr('data-video-id')
    $.ajax '/staff/delete_video',
        type: 'DELETE'
        dataType: 'json'
        data: {object_id: object_id}
    $(this).parent('.video').remove()
    false

  $('a.remove_photo').live 'click', () ->
    object_class = $(this).attr('data-class')
    object_id = $(this).attr('data-photo-id')
    $.ajax '/staff/delete_photo',
        type: 'DELETE'
        dataType: 'json'
        data: {object_id: object_id, object_class: object_class}
    $(this).parent('.thumb').remove()
    false

$ ->
  setup_photos_removing()
  setup_chosen()
  setup_schedule()
  setup_picture_urls()
  setup_activity_categories()
  # if document.URL.substr(0, 39) is "http://bp.balticit.ru/admin/activities"

