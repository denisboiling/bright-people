window.setup_participants_list = ->
  return if $('.main_participants .item').length == 0

  a = []
  $("[id^=lightbox_hook_]").each ->
    a.push $(this).attr("id").split("_")[2]

  i = 0
  while i < a.length
    $("a[rel='participant_"+a[i].toString()+"[gallery]']").prettyPhoto(social_tools: false)
    $('#pikame_'+a[i].toString()).PikaChoose(carousel: true, autoPlay: false)
    i++

  $('.pika-stage').addClass('hidden')
  
  $('.main_participants .item').live 'mouseover', (event) ->
    $(this).stop().animate { width: '50%' }
    $(this).siblings().stop().animate { width: '23%' }
  
  $('.participant_photo').live 'click', (event) ->
    event.preventDefault()
    $(this).parent().find("[id^=lightbox_hook_]").children(':first').trigger('click')
    
  $('#participants_map_toggle').click ->
    map = $(this).prev()
    if ( map.hasClass('opened') )
      map.children('img').attr( 'src', map.attr('data-small') )
#      map.stop().animate( { height: '300px', backgroundColor: '#aaa' }, 'fast' )
    else      
      map.children('img').attr( 'src', map.attr('data-large') )
#      map.stop().animate( { height: '60px', backgroundColor: '#ccc' }, 'fast' )
    map.toggleClass('opened')