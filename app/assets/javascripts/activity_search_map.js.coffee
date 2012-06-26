window.setup_activity_search_map = ->
  window.mapGeoObjects = new Array
  return if $('#activity_map').length == 0

  ymaps.ready ->
    myCircle = new ymaps.Circle([[0,0],0])
    window.window.myMap = new ymaps.Map("activity_map", {
      center: [55.76, 37.64],
      zoom: 12,
      type: "yandex#map",
      behaviors: [ "default", "scrollZoom" ]
      }
    )
    window.myMap.controls.add('zoomControl')
      .add('typeSelector')
      .add('smallZoomControl', {right: 5, top: 75})

    window.myMap.events.add "click", (e) ->
      unless window.myMap.balloon.isOpen()
        window.myMap.geoObjects.each ->
          window.myMap.geoObjects.remove myCircle
        i = 0
        while i < window.mapGeoObjects.length
          window.myMap.geoObjects.remove window.mapGeoObjects[i]
          i++
        coords = e.get("coordPosition")
        window.myMap.balloon.open coords,
          contentBody: "Вы здесь!"
        $('#coords_input').val(coords.join())
        $("#remote_form").submit()
        myCircle = new ymaps.Circle([
                  coords,
                  2500
              ]);
        window.myMap.geoObjects.add(myCircle);
        myCircle.events.add 'click', (e) ->
          window.myMap.balloon.close()
          j = 0
          window.myMap.geoObjects.remove myCircle
          while j < window.mapGeoObjects.length
            window.myMap.geoObjects.remove window.mapGeoObjects[j]
            j++
          $('#coords_input').val('')
          window.mapGeoObjects=[]

      else
        window.myMap.balloon.close()
        i = 0
        window.myMap.geoObjects.remove myCircle
        while i < window.mapGeoObjects.length
          window.myMap.geoObjects.remove window.mapGeoObjects[i]
          i++
        $('#coords_input').val('')
        window.mapGeoObjects=[]


window.render_placemarks = ->
  window.mapGeoObjects=[]
  $('.preview_catalog').each ->
    activity_coords = $(this).attr('data-coords').split(/, |,/)
    myPlacemark = new ymaps.Placemark(activity_coords, {
            iconContent: "<a href=\"" + $(this).find('a').attr('href') + "\">"+$(this).find('.name').text()+"</a>"
        }, {
            draggable: false,
            preset: 'twirl#blueStretchyIcon'
    })
    window.mapGeoObjects.push(myPlacemark)
    window.myMap.geoObjects.add(myPlacemark);
