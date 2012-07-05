window.setup_participants_list = ->
  return if $('.main_participant').length == 0

  a = []
  $("[id^=lightbox_hook_]").each ->
    a.push $(this).attr("id").split("_")[2]

  i = 0
  while i < a.length
    $("a[rel='participant_"+a[i].toString()+"']").prettyPhoto(social_tools: false)
    $('#pikame_'+a[i].toString()).PikaChoose(carousel: true, autoPlay: false)
    i++

  $('.pika-stage').addClass('hidden')
  
  $('.participant_photo').live 'click', (event) ->
    event.preventDefault()
    PikaChoose = $(this).parent().find("[id^=pikame_]").data('pikachoose')
    element = PikaChoose.active
    class_name = element.attr('data-hook-class')
    $('.participant_photo').first().parent().parent().find("[id^=lightbox_hook_]").find(".#{class_name}").trigger('click')
    $('.pika-stage').addClass('hidden')
