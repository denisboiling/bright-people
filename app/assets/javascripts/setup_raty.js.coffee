window.setup_raty = ->
  if $(".rating.readonly")
    for obj in $(".rating.readonly")
      rating =  $(obj).attr('data-rating')
      $(obj).raty
        path: '/assets/raty'
        readOnly: true
        score: rating
        half  : true