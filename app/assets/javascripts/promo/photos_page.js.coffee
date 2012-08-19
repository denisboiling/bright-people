window.setup_photos_page = ->

  return unless $("body.photos").length != 0

  $.urlParam = (name) ->
    results = new RegExp("[\\?&]" + name + "=([^&#]*)").exec(window.location.href)
    return "" if results == null
    results[1] or 0

  # OPTIMIZE: brr ugly
  get_by_params =(params) ->
    ret_params = switch params
                   when "photographers"
                     if $.urlParam(params) == "" || $.urlParam(params) == 0
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

  relocate_photos =(div) ->
    container = div
    imgs = container.find("img")
    totalImgs = imgs.length
    cnt = 0
    imgs.each (i) ->
      img = $(this)
    
      $("<img/>").load(->
        ++cnt
        if cnt is totalImgs
          container.montage
            fillLastRow: true
            alternateHeight: true
            alternateHeightRange:
              min: 90
              max: 240
      ).attr "src", img.attr("src")

  append_photos =() ->
    return false if typeof(window.append) == "undefined" || window.append == false
    true

  set_page_one =() ->
    $("#bri-form-page").val(1)

  active_photographers_by_params =() ->
    return if get_by_params('photographers') == "" || get_by_params('photographers') == []
    photographer_ids = get_by_params('photographers')
    for id in photographer_ids
      photographer = $("div.bri-photographer[data-id='#{id}']")
      photographer.toggleClass('active')
      photographer.find('.bri-photo').slideToggle('fast')
      photographer.find('.bri-camera').slideToggle('fast')
    if photographer_ids.length == 10
      $('#bri-photographers-select-all')
        .toggleClass('active')
        .html('Убрать всех фотографов')

  all_downloaded =() ->
    return false if typeof(window.all_downloaded) == "undefined" || window.all_downloaded == false
    true
      
  set_all_downloaded =() ->
    $("div.am-container#am-container").html("") unless append_photos()
    $("#bri-preloader").hide()
    set_page_one()
    window.all_downloaded = true

  # Update div to add hd download function and find all early selected photos
  activated_hd_div =(div) ->
    photos_div = div.find(".bri-photo-box")
    div.find(".bri-photo-box").addClass('bri-hd')
    div.find(".bri-photo-box .bri-checkbox").fadeToggle('fast')
    ids = JSON.parse(window.localStorage.choose_photos)
    return if ids.length == 0
    for id in ids
      photos_div.find("a[data-id='#{id}']").parents(".bri-photo-box.bri-hd").first().addClass('active')
    $('#bri-hd-download').show()

  deactivated_hd_div =(div) ->
    photos_div = div.find(".bri-photo-box")
    div.find(".bri-photo-box").removeClass('bri-hd active')
    div.find(".bri-photo-box .bri-checkbox").fadeToggle('fast')
    $('#bri-hd-download').hide()

  # HD functional is on?
  bri_hd_sw_on =() ->
    $('#bri-hd-switch').hasClass('active')

  # Logic when user check or uncheck "HD on/off"
  bri_hd_sw =() ->
    $('#bri-hd-switch').live 'click', ->
      if bri_hd_sw_on()
        deactivated_hd_div($("#bri-photos"))
      else
        activated_hd_div($("#bri-photos"))

      $(this).toggleClass('active')
      false

  # Mark or Unmark photo for download
  bri_hd_photo =(div) ->
    ids = JSON.parse(window.localStorage.choose_photos)
    id = div.find('a').attr('data-id')
    unless div.hasClass('active')
      ids.push(id)
    else
      ids.shift(ids.indexOf(id))

    window.localStorage.choose_photos = JSON.stringify(ids)
    div.toggleClass('active')

    if JSON.parse(window.localStorage.choose_photos).length > 0
      $('#bri-hd-download').show()
    else
      $('#bri-hd-download').hide()

    console.log("Selected photos #{window.localStorage.choose_photos}")

  # Back to normal view. Remove all memories about HD download functional
  remove_bri_hd_download =() ->
    localStorage.choose_photos = JSON.stringify([])
    $('#bri-hd-switch').removeClass('active')
    deactivated_hd_div($("#bri-photos"))
    $('#bri-hd-download').hide()

# BIND LIVE
  active_photographers_by_params()
  relocate_photos($("#bri-photos"))
  $("div.hidden-photos").removeClass('hidden-photos')
  bri_hd_sw()

  $('.bri-photo-box.bri-hd').live 'click', ->
    bri_hd_photo($(this))

  $("a#bri-hd-download").live 'click', ->
    photos = JSON.parse(localStorage.choose_photos)
    $.ajax
      type: 'POST',
      url: '/photos/download',
      data: "ids" : photos
      success: (data) ->
        $("body").append("<iframe src='#{data}' style='display: none;' ></iframe>")
        remove_bri_hd_download()
    false


  $(window).scroll ->
    return if all_downloaded()
    if $(window).scrollTop() + $(window).height() > $(document).height() - 200
      $("#bri-form-page").val(parseInt($("#bri-form-page").val()) + 1)
      window.append = true
      $("form#bri-form-photos").submit()

  $("#bri-form-hour, #bri-form-minute, #bri-form-photographers").bind 'change', ->
    window.append = false
    window.all_downloaded = false
    set_page_one()
    $(this).parents("form:first").submit()

  $("form#bri-form-photos").bind 'ajax:success', (event, xhr) ->
    if xhr == ""
      set_all_downloaded()
    else
      if append_photos()
        $("div.am-container#am-container").append("<div class='hidden-photos'>#{xhr}</div>")
        relocate_photos($("div.hidden-photos"))
        activated_hd_div($("div.hidden-photos")) if bri_hd_sw_on()

        $("div.hidden-photos").removeClass('hidden-photos')
      else
        $("div.am-container#am-container").html("")
        $("div.am-container#am-container").append("<div class='hidden-photos'>#{xhr}</div>")
        relocate_photos($("div.hidden-photos"))
        activated_hd_div($("div.hidden-photos")) if bri_hd_sw_on()
  
        $("div.hidden-photos").removeClass('hidden-photos')
  
  $("form#bri-form-photos").bind 'submit', ->
    $("#bri-form-photographers").val(window.choose_photographers())
    true