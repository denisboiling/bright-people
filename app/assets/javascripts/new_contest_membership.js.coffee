window.setup_new_membership_creation = ->
  return if $('.participation_form').length == 0

  $('.button input').on 'click', (event) ->
    $('.participation_step').addClass('hidden')
    $('.thanks').removeClass('hidden')
