window.setup_organization_map = ->
  return if $('#org_map').length == 0

  x = $('#org_map').attr('data-x')
  y = $('#org_map').attr('data-y')

  ymaps.ready ->
    myMap = new ymaps.Map("org_map", {
      center: [x, y],
      zoom: 16,
      type: "yandex#map",
      behaviors: [ "default", "scrollZoom" ]
      }
    )
    myMap.controls.add('zoomControl')
      .add('typeSelector')
      .add('smallZoomControl', {right: 5, top: 75})

    myPlacemark = new ymaps.Placemark([x,y], {}, {
        draggable: false
      }
    )

    myMap.geoObjects.add(myPlacemark);
