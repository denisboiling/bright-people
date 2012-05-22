$ ->
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

    ymaps.ready init