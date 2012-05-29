window.setup_rating = ->
  for n in [1,2,3,4,5]
    $(".activity_rate#{n}_link").bind 'click', (event) ->
      event.preventDefault()
      
      regex = /activities\/(\d+)/
      activity_id = regex.exec(window.location.href)[1]
      $.ajax
        type: 'PUT',
        url: "/activities/#{activity_id}/vote",
        data: { rate: n }
    
    $(".contest_rate#{n}_link").bind 'click', (event) ->
      
      contest_id = /contests\/(\d+)/.exec(window.location.href)[1]
      membership_id = /members\/(\d+)/.exec(window.location.href)[1]
      $.ajax
        type: 'PUT',
        url: "/contests/#{contest_id}/members/#{membership_id}/vote",
        data: { rate: n }