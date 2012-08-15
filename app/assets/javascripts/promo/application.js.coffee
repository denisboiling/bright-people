#= require jquery
#= require jquery_ujs
#= require promo/libs/prefixfree.min
#= require promo/libs/modernizr-2.5.3.min
#= require promo/libs/raphael-min
#= require promo/libs/jquery.montage.min
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


# window.load_more_photos =() ->
#   return unless $("div.am-container#am-container").length != 0
#   $(window).endlessScroll
#     fireOnce: false
#     fireDelay: false
#     callback: (p) ->
#       console.log p

change_bri_form_photos =() ->
  $("form#bri-form-photos input").bind 'change', ->
    $(this).parents("form:first").submit()

  $("form#bri-form-photos").bind 'ajax:success', (event, xhr) ->
    $("div.am-container#am-container").append(xhr)

$ ->
  window.setup_download_photos()
  change_bri_form_photos()
  # window.load_more_photos()
  # mark_photo_as_views()

  
