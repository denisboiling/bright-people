window.setup_activity_search_map = ->
  return if $('#activity_map').length == 0

  #ymaps.ready ->
  window.myCircle = new ymaps.Circle([[0,0],0]) unless window.myCircle
  window.myMap = new ymaps.Map("activity_map", {
    center: [55.76, 37.64],
    zoom: 12,
    type: "yandex#map",
    behaviors: [ "default", "scrollZoom" ]
    }
  ) if window.myMap_draw

  window.myMap.controls.add('zoomControl')
    .add('typeSelector')
    .add('smallZoomControl', {right: 5, top: 75}) if window.myMap_draw

  if window.myMap_draw
    window.myMap.events.add "click", (e) ->
      unless window.myMap.balloon.isOpen()
        i = 0
        while i < window.mapGeoObjects.length
          window.myMap.geoObjects.remove window.mapGeoObjects[i]
          i++
        window.mapGeoObjects = []
        window.myMap.geoObjects.remove window.myCircle
        coords = e.get("coordPosition")
        window.myMap.balloon.open coords,{},
          {
            layout: create_map_balloon_layout(),
            shadow: false
          }
        $('#coords_input').val(coords.join())
        $("#remote_form").submit()
        window.myCircle = new ymaps.Circle([
                  coords,
                  2500
              ]);
        window.myMap.geoObjects.add(window.myCircle);
        window.myCircle.events.add 'click', (e) ->
          window.myMap.balloon.close()
          j = 0
          window.myMap.geoObjects.remove window.myCircle
          while j < window.mapGeoObjects.length
            window.myMap.geoObjects.remove window.mapGeoObjects[j]
            j++
          $('#coords_input').val('')
          $("#remote_form").submit()
          window.mapGeoObjects=[]

      else
        window.myMap.balloon.close()
        i = 0
        window.myMap.geoObjects.remove window.myCircle
        while i < window.mapGeoObjects.length
          window.myMap.geoObjects.remove window.mapGeoObjects[i]
          i++
        $('#coords_input').val('')
        $("#remote_form").submit()
        window.mapGeoObjects=[]

  window.myMap_draw = false




window.render_placemarks = (on_map) ->
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
    window.myMap.geoObjects.add(myPlacemark) if on_map;



create_map_balloon_layout = ->
  newBalloonLayout = ymaps.templateLayoutFactory.createClass("<div style=\"background: #f00; position: relative; left: -5px; top: -5px; width: 10px; height: 10px; border-radius: 50%\"></div>​",
    build: ->
      newBalloonLayout.superclass.build.call this
    clear: ->
      newBalloonLayout.superclass.clear.call this
  )
  return newBalloonLayout
