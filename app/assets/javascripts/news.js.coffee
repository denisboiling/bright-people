window.setup_news_lightbox = ->
  return if $('#news').length == 0
  
  $("a[rel^='prettyPhoto']").prettyPhoto(social_tools: false)
  $('#pikame').PikaChoose(carousel: true, autoPlay: false)
  
  $('.pikachoose .mask').bind 'click', ->
    PikaChoose = $('#pikame').data('pikachoose')
    element = PikaChoose.active
    class_name = element.attr('data-hook-class')
    $("#lightbox_hook .#{class_name}").trigger('click')

  $('.pika-imgnav .previous').live 'click', ->
    PikaChoose = $('#pikame').data('pikachoose')
    element = PikaChoose.active
    class_name = element.attr('data-hook-class')
    $("#lightbox_hook .#{class_name}").trigger('click')

  $('.pika-imgnav .next').live 'click', ->
    PikaChoose = $('#pikame').data('pikachoose')
    element = PikaChoose.active
    class_name = element.attr('data-hook-class')
    $("#lightbox_hook .#{class_name}").trigger('click')
