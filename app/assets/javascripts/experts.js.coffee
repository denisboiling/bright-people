window.setup_prev_next_expert_arrows = ->
  $('.prev_exp, .next_exp').bind 'click', ->
    url = $(this).attr('data-url')
    window.location = url