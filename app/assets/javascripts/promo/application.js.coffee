#= require jquery
#= require promo/libs/prefixfree.min
#= require promo/libs/modernizr-2.5.3.min
#= require promo/libs/raphael-min
#= require promo/libs/jquery.montage.min
#= require_directory .

mark_photo_as_views = (photo_id) ->
  console.log "dsadsad"
  # viewed = if localStorage.viewed == ""
  #            localStorage.viewed = JSON.stringify([])
  #          else
  #            JSON.parse(localStorage.viewed)
  # for i 

$ ->
  window.setup_download_photos()
  mark_photo_as_views()