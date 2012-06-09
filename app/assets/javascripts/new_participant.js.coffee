window.setup_new_participant_form_button = ->
  $('input[value="Отправить"]').bind 'click', ->
    $('#new_contest_membership').submit()
    $('.thanks').removeClass('hidden')
