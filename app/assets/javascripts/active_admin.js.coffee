#= require active_admin/base
#= require advanced
#= require wysihtml5-0.3.0.min
#= require jquery.timepicker

$ ->
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
