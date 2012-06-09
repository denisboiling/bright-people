window.setup_raty = ->
  
  if $(".rating_readonly")
    for obj in $(".rating_readonly")
      rating =  $(obj).attr('data-rating')
      $(obj).raty
        path: '/assets/raty'
        readOnly: true
        score: rating
        half  : true

  send_rating =(rating,activity) ->
    $.ajax
      type: 'PUT'
      url: '/activities/vote'
      data: {rating: rating, activity_id: activity}
      success: (data) ->
        $("span#vote-count").replaceWith(data)

  if $(".rating")
    rating = $(".rating").attr('data-rating')
    id = $(".rating").attr('data-activity-id')
    lock = $(".rating").attr('data-lock')
    $(".rating").raty
      path: '/assets/raty'
      score: rating
      click: (score, evt) ->
        if lock == "true"
          $("#register_dialog").removeClass('hidden')
        else
          send_rating(score, id)
