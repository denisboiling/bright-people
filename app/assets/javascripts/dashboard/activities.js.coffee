$ ->

  $('.rte-zone').rte { media_url : '/assets/rte/', content_css_url : '/assets/rte.css' }

  $('select#activity_metro_station_ids').chosen()
        
  $('#activity_metro_station_ids_chzn .search-field input')
  .focus ->
    $(this).parent().parent().next().find('.chzn-results').show()
  .focusout ->
    # DIRTY HACKZZ, focus doesn't disappears immediately when fading out
    # So click event WILL be triggered :D
    $(this).parent().parent().next().find('.chzn-results').fadeOut('fast')
    
  $('#activity_metro-station_ids .chzn-single span')
  .change -> console.log('yay!')

  # CATEGORY
  $("select#activity_is_educational").bind 'change', ->
    # REFACTOR:
    select_id = $(this).attr('id')
    chose = $("##{select_id} :selected").val()
    $.ajax '/staff/get_categories',
      type: 'GET'
      data: {is_educational: chose }
      success: (response) ->
        $("select#activity_direction_tag_ids").html(response)

  # ADD VIDEO
  $('button#add_video').bind 'click', ->
    video_url = $('input#video_url').val()
    obj_id = $('input#video_url').attr('data-object-id')
    obj_class = $('input#video_url').attr('data-object-class')
    $.ajax '/staff/add_video',
      type: 'POST'
      dataType: 'json'
      data: {object_id: obj_id, object_class: obj_class, video_url: video_url}
      success: (response) ->
        li = "<li><div><div class='circle-delete' data-video-id=#{response['id']}></div>#{response['url']}</div></li>"
        $('ol#video_list').append(li)
        $('input#video_url').val('')
    false

  # DELETE VIDEO
  $('div.circle-delete.video').live 'click', ->
    object_id = $(this).attr('data-video-id')
    $.ajax '/staff/delete_video',
      type: 'DELETE'
      dataType: 'json'
      data: {object_id: object_id}
    $(this).parents("li:first").remove()    
    false

  # DELETE PHOTO
  $('div.circle-delete.photo').bind 'click', ->
    object_class = $(this).attr('data-class')
    object_id = $(this).attr('data-photo-id')
    $.ajax '/staff/delete_photo',
        type: 'DELETE'
        dataType: 'json'
        data: {object_id: object_id, object_class: object_class}
    $(this).parent('.image').remove()
    false

  # SCHEDULE
  input_to_form =(day, json_time) ->
    input = "<input name='activity[#{day}]' value='#{json_time}' type='hidden'>"
    $('form.edit_activity').append(input)

  $('div.save button').bind 'click', ->
    days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday',
           'saturday', 'sunday']
    for day in days
      chunks = []
      $("td[data-day=#{day}] div.data div.time").each ->
        start = $(this).attr('data-start')
        end = $(this).attr('data-end')
        chunks.push {start: start, end: end}
      input_to_form(day, JSON.stringify(chunks))

    $('div.hidden_teacher').remove()
    
  $('#activity-edit-schedule .add').bind 'click', ->
    $('#activity-edit-ok').attr( 'data-day', $(this).parent().attr('data-day') )
    $('#activity-edit-shadow').width(screen.width).height(screen.height).fadeIn 'fast'
    $('#activity-edit-modal').fadeIn 'fast'
    
  $('#activity-edit-shadow').bind 'click', -> $('#activity-edit-modal, #activity-edit-shadow').fadeOut 'fast'
    
  $('#activity-edit-ok').bind 'click', ->
    start = $('#activity-edit-schedule-start.hour').val() + ":" + $('#activity-edit-schedule-start.minute').val()
    end   = $('#activity-edit-schedule-end.hour').val() + ":" + $('#activity-edit-schedule-end.minute').val()
    # Is it okay to embed html like this?
    day = $(this).attr('data-day')

    append_div = "<div class='time' data-start='#{start}' data-end='#{end}'>
                  <div class='circle-delete'></div>
                  <span>#{start} — #{end}</span>
                  </div>"
    # console.log $("#activity-edit-schedule td[data-day='#{day}'] .data:last")
    $("#activity-edit-schedule td[data-day='#{day}'] .data:last").append(append_div)
    $('#activity-edit-modal, #activity-edit-shadow').fadeOut 'fast'
    false
  
  $('#activity-edit-schedule .circle-delete').live 'click', ->
    $(this).parent().detach()

  # TEACHERS

  # When teachers not presents
  $("button.add-first").bind "click", ->
    form = $('div.hidden_teacher').html()
    $("div.teacher").replaceWith(form)
    $(this).parent("div").remove()
    false

  # When teacher present
  $("button.add").live "click", ->
    regex = /activity_teachers_attributes_([\d+])_(\w+)/
    first_element = $('div.hidden_teacher').find('input')[0]
    minor_number = parseInt(regex.exec($(first_element).attr('id'))[1])
    big_number = minor_number + 1

    $('div.hidden_teacher').find('input').each ->
      id = $(this).attr('id')
      new_id = id.replace(minor_number, big_number)
      $(this).attr('id', new_id)

      name = $(this).attr('name')
      new_name = name.replace(minor_number, big_number)
      $(this).attr('name', new_name)

    $('div.hidden_teacher').find('textarea').each ->
      id = $(this).attr('id')
      new_id = id.replace(minor_number, big_number)
      $(this).attr('id', new_id)

      name = $(this).attr('name')
      new_name = name.replace(minor_number, big_number)
      $(this).attr('name', new_name)

    form = $('div.hidden_teacher').html()
    $(this).parent(".button_edit").parent(".teacher").after(form)
    false

  $("button.delete").live "click", ->
    main_div = $(this).parents("div.teacher:first")
    if $(this).attr('data-new') != "true"
      teacher_id = $(this).attr('data-id')
      $.ajax '/dashboard/activity/destroy_teacher',
      type: 'DELETE'
      dataType: 'json'
      data: { id: teacher_id }
    main_div.remove()
    false


  # THIS IS MAP MF!!!

  address_present = ->
    return true if $("input.hidden_coords").val()

  # OPTIMIZE: look ugly
  get_coords = ->
    return [55.75578, 37.615149] unless $("input.hidden_coords").val()
    coords = $("input.hidden_coords").val().split(',')
    if coords[0] == 0 || coords[1] == 0
      return [55.75578, 37.615149]
    else
      return [coords[0], coords[1]]

  set_coords =(coords) ->
    $("input.hidden_coords").val(coords)

  add_controls =(map) ->
    map.controls.add('zoomControl')
      .add('typeSelector')
      .add('smallZoomControl', {right: 5, top: 75})

  # OPTIMIZE: brr looks ugly
  get_name = ->
    $("#organization_title").val() || $("#activity_title").val() || 'Название не указанно'

  get_address = ->
    $("#organization_address").val() || $("#activity_address").val() || 'Адрес не указан'

  open_map = ->
    window.myMap = new ymaps.Map('edit_map',
      center: get_coords()
      zoom: 17
      behaviors: [ "default", "scrollZoom" ]
    )
    add_controls(window.myMap)

  add_ballon =(myMap) ->
    if address_present
      myMap.balloon.open get_coords(),
        contentHeader: get_name()
        contentBody: get_address()
      ,
        closeButton: false

  if $("input.edit_map").length != 0
    $("input.edit_map").replaceWith('<div id="edit_map"></div>')

  if $("div#edit_map").length != 0
    init = ->
      open_map()

      if $("#organization_title").length == 0 && $("#activity_title").length == 0
        myPlacemark = new ymaps.Placemark(get_coords())
        window.myMap.geoObjects.add(myPlacemark)
      else
        add_ballon(window.myMap)

        myMap.events.add "click", (e) ->
          unless myMap.balloon.isOpen()
            coords = e.get("coordPosition")
            set_coords(coords)
            myMap.balloon.open coords,
              contentHeader: get_name()
              contentBody: get_address()
          else
            myMap.balloon.close()
    
    update_coords = ->
      window._coords_update_timeout = null
      
      address = $('#organization_address, #activity_address').val()
      ymaps.geocode(address, results: 1).then (res) ->
        geoObject = res.geoObjects.get(0)
        coords = geoObject.geometry.getCoordinates()
        set_coords(coords)
        myMap.balloon.open coords,
          contentHeader: get_name()
          contentBody: get_address()
    
    $('#organization_address, #activity_address').bind 'keyup', ->
      clearTimeout(window._coords_update_timeout) if window._coords_update_timeout
      window._coords_update_timeout = setTimeout(update_coords, 1000)

    ymaps.ready(init) if typeof(ymaps) != 'undefined'