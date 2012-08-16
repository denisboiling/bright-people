#= require jquery
#= require jquery_ujs
#= require promo/libs/prefixfree.min
#= require promo/libs/modernizr-2.5.3.min
#= require promo/libs/raphael-min
#= require promo/libs/jquery.montage.min
#= require promo/libs/jquery.lightbox.js
#= require promo/libs/jquery.endless-scroll
#= require_directory .

# mark_photo_as_views = () ->
#   $(window).bind 'scrollreachbottom', ->
#     console.log "DDD"
    
#   # viewed = if localStorage.viewed == ""
#   #            localStorage.viewed = JSON.stringify([])
#   #          else
#   #            JSON.parse(localStorage.viewed)
#   # for i


window.load_more_photos =() ->
  return unless $("div.am-container#am-container").length != 0
  $(window).scroll ->
    if $(window).scrollTop() + $(window).height() > $(document).height() - 100
      console.log "dasdasd"
      $("form#bri-form-photos").submit()

change_bri_form_photos =() ->
  $("form#bri-form-photos input").bind 'change', ->
    $(this).parents("form:first").submit()

  $("form#bri-form-photos").bind 'ajax:success', (event, xhr) ->
    $("div.am-container#am-container").append("<div class='hidden-photos'>#{xhr}</div>")
    window.relocate_photos()
    $("div.hidden-photos").removeClass('hidden-photos')

window.relocate_photos =() ->
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


$ ->
  window.setup_download_photos()
  change_bri_form_photos()
  window.load_more_photos()
  # mark_photo_as_views()

  
