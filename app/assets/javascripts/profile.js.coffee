window.setup_profile_ajax = ->
  return if $('#update_profile_form').length == 0
  
  $('#user_avatar').live 'change', ->
    $('#update_profile_form').submit()
