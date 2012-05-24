#= require active_admin/base

#= require cocoon
#= require autocomplete-rails
#= require advanced
#= require wysihtml5-0.3.0
#= require jquery-ui-timepicker-addon
#= require jquery-ui-timepicker-ru

#= require admin/edit_map

setup_schedule = ->
  days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday',
          'saturday', 'sunday']
  
  update_fields = (values) ->
    for day in days
      chunks = values[day] if values
      chunks ?= []
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
  
  $('.schedule_day_link').bind 'click', (event) ->
    event.preventDefault()
    
    $li = $(this).closest('li')
    add_interval($li)
      
  # var JSONSchedule = {"monday":[], "tuesday":[], "wednesday":[], "thursday":[], "friday":[], "saturday":[], "sunday":[]};
  # $('#activity_week').val(JSON.stringify(JSONSchedule));
  # $('#list').find(":button").click(function(){
  #   var day_of_week = $(this).attr('id');
  #   $(this).parent().append("<input id=\"timeinput-first-" + day_of_week +"\" type=\"text\">");
  #   $('#timeinput-first-' + day_of_week).timepicker({ 'step': 15, 'timeFormat': 'H:i' });
  #   $(this).parent().append("<input id=\"timeinput-second-" + day_of_week +"\" type=\"text\">");
  #   $("#timeinput-second-" + day_of_week).timepicker({ 'step': 15, 'timeFormat': 'H:i' });
  #   $(this).parent().append("<button type=\"button\" id=\"save-button-"+day_of_week+"\">Save!</button></li>");
  #   $("#save-button-"+day_of_week).click(function(){
  #     var day_of_week = $(this).parent().find(":button").first().attr('id');
  #     JSONSchedule = JSON.parse($('#activity_week').val());
  #     JSONSchedule[day_of_week].push({start: $('#timeinput-first-'+day_of_week).val(), end: $('#timeinput-second-'+day_of_week).val()});
  #     $('#activity_week').val(JSON.stringify(JSONSchedule));
  #     $('#timeinput-first-'+day_of_week).remove();
  #     $('#timeinput-second-'+day_of_week).remove();
  #     $(this).remove();
  #   });
  # });

setup_wysihtml5_editor = ->
  info_editor = new wysihtml5.Editor "activity_additional_information",
                      toolbar:      "wysihtml5-toolbar-additional-information",
                      parserRules:  wysihtml5ParserRules
  activities_editor = new wysihtml5.Editor "activity_parent_activities", 
                            toolbar: "wysihtml5-toolbar-parent-activities",
                            parserRules: wysihtml5ParserRules

setup_video_removing = ->
    $('a.remove_activity_video').live 'click', () ->
    id = $(this).attr('data-photo-id')
    if id
      # TODO: only in success we should delete div
      $.ajax '/staff/delete_video_by_activity',
        type: 'DELETE',
        dataType: 'json',
        data: {id: id}
      $(this).parent('.nested-fields').remove()
    else
      $(this).parent('.nested-fields').remove()
    return false

  $('a.remove_activity_photo').live 'click', () ->
    id = $(this).attr('data-photo-id')
    if id
      # TODO: only in success we should delete div
      $.ajax '/staff/delete_photo_by_activity',
        type: 'DELETE',
        dataType: 'json',
        data: {id: id}
      $(this).parent('.nested-fields').remove()
    else
      $(this).parent('.nested-fields').remove()
    return false

$ ->
  setup_video_removing()
  setup_wysihtml5_editor()
  setup_schedule()
