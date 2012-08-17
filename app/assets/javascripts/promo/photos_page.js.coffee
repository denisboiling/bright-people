window.setup_photos_page = ->

  return unless $("body.photos").length != 0

  $.urlParam = (name) ->
    results = new RegExp("[\\?&]" + name + "=([^&#]*)").exec(window.location.href)
    return "" if results == null
    results[1] or 0

  get_by_params =(params) ->
    ret_params = switch params
                   when "photographers"
                     if $.urlParam(params) == ""
                       []
                     else
                       $.urlParam(params).split('%2C')
                   else
                     $.urlParam(params)

  window.choose_photographers =() ->
    choose = []
    $("div.bri-photographer.active").each ->
      choose.push($(this).attr('data-id'))
    choose

  relocate_photos =() ->
    $container = $("div.hidden-photos")
    $imgs = $container.find("img")
    totalImgs = $imgs.length
    cnt = 0
    $imgs.each (i) ->
      $img = $(this)
    
      # $imgs.show()
      $("<img/>").load(->
        ++cnt
        if cnt is totalImgs
          $container.montage
            fillLastRow: true
            alternateHeight: true
            alternateHeightRange:
              min: 90
              max: 240

      ).attr "src", $img.attr("src")

  append_photos =() ->
    return false if typeof(window.append) == "undefined" || window.append == false
    true

  set_page_one =() ->
    $("#bri-form-page").val(1)

  active_photographers_by_params =() ->
    return if get_by_params('photographers') == "" || get_by_params('photographers') == []
    for id in get_by_params('photographers')
      photographer = $("div.bri-photographer[data-id='#{id}']")
      photographer.toggleClass('active')
      photographer.find('.bri-photo').slideToggle('fast')
      photographer.find('.bri-camera').slideToggle('fast')

# BIND LIVE
  active_photographers_by_params()

  $(window).scroll ->
    if $(window).scrollTop() + $(window).height() > $(document).height() - 100
      $("#bri-form-page").val(parseInt($("#bri-form-page").val()) + 1)
      window.append = true
      $("form#bri-form-photos").submit()


  $("#bri-form-hour, #bri-form-minute, #bri-form-photographers").bind 'change', ->
    window.append = false
    set_page_one()
    $(this).parents("form:first").submit()

  $("form#bri-form-photos").bind 'ajax:success', (event, xhr) ->
    if xhr == ""
      $("#bri-preloader").hide()
      $("div.am-container#am-container").html("") unless append_photos()
    else
      if append_photos()
        $("div.am-container#am-container").append("<div class='hidden-photos'>#{xhr}</div>")
      else
        $("div.am-container#am-container").html("<div class='hidden-photos'>#{xhr}</div>")        
      relocate_photos()
      $("div.hidden-photos").removeClass('hidden-photos')


  $("form#bri-form-photos").bind 'submit', ->
    $("#bri-form-photographers").val(window.choose_photographers())
    true