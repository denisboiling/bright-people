window.setup_participants_list = ->
  return if $('.main_participant').length == 0

  $("a[rel^='prettyPhoto']").prettyPhoto(social_tools: false)
  $('#pikame').PikaChoose(carousel: true, autoPlay: false)
  $('.pika-stage').addClass('hidden')
  
  $('.participant_photo').live 'click', (event) ->
    event.preventDefault()
    PikaChoose = $('#pikame').data('pikachoose')
    element = PikaChoose.active
    class_name = element.attr('data-hook-class')
    $("#lightbox_hook .#{class_name}").trigger('click')
    $('.pika-stage').addClass('hidden')
