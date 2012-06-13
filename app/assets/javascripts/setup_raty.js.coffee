window.setup_raty = ->
  
  if $(".rating_readonly").length > 0
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
      url: if document.URL.match(/\/[A-Za-z0-9]+\//)[0] == "/activities/" then '/activities/vote' else document.URL+ (if activity then ('/' + activity) else "") + '/vote'
      data: {rating: rating, id: (if !activity then document.URL.match(/(\d+)$/)[0] else activity), contest_id: document.URL.match(/(\d+)/)[0]}
      success: (data) ->
        $("span#vote-count").replaceWith(data)

  if $(".rating").length > 0
    rating = $(".rating").attr('data-rating')
    id = if document.URL.match(/\/[A-Za-z0-9]+\//)[0] == "/activities/" then $(".rating").attr('data-activity-id') else $(".rating").attr('data-membership-id')
    lock = $(".rating").attr('data-lock')
    $(".rating").raty
      path: '/assets/raty'
      score: rating
      click: (score, evt) ->
        if lock == "true"
          $("#register_dialog").removeClass('hidden')
        else
          send_rating(score, id)
