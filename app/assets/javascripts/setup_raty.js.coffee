# TODO: all shit, replace, optimize and be awesome ;)
window.setup_raty = ->
  return if $('.rating, .rating_readonly').length == 0
  
  for obj in $(".rating_readonly")
    rating =  $(obj).attr('data-rating')
    $(obj).raty
      path: '/assets/raty'
      readOnly: true
      score: rating
      half  : true
  
  send_rating = (rating,activity) ->
    url =  if document.URL.match(/\/[A-Za-z0-9]+\//)[0] == "/activities/"
            '/activities/vote'
           else
             document.URL + (activity ? "/" + activity :  "") + '/vote'
    id = if not activity
           document.URL.match(/(\d+)$/)[0]
         else
           activity
    data = 
      rating: rating
      id: id
      contest_id: document.URL.match(/(\d+)/)[0]
    
    $.ajax
      type: 'PUT'
      url: url
      data: data
      success: (data) ->
        $("span#vote-count").replaceWith(data)
        $(".rating").raty('readOnly', true)
        $("a.cancel_rating").removeClass('hidden')

  if $(".rating").length > 0
    rating = $(".rating").attr('data-rating')
    lock = $(".rating").attr('data-lock')
    id = if document.URL.match(/\/[A-Za-z0-9]+\//)[0] == "/activities/"
           $(".rating").attr('data-activity-id')
         else
           $(".rating").attr('data-membership-id')
    readonly = $(".rating").attr('data-already-vote') == "true"
    $(".rating").raty
      path: '/assets/raty'
      score: rating
      readOnly: readonly
      click: (score, evt) ->
        if lock == "true"
          $("#register_dialog").removeClass('hidden')
        else
          send_rating(score, id)

  if $("a.cancel_rating").length > 0
    $("a.cancel_rating").bind 'click', ->
      $(".rating").raty('readOnly', false)
      $(".rating").raty('score', 0)
      $(this).addClass('hidden')
      false