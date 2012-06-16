# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.setup_email_dialog = ->
  return unless $.cookie('email_dialog')
  
  $('#update_email_dialog form').live 'ajax:error', (event, xhr) ->
    html = xhr.responseText
    $('#update_email_dialog .dialog_form').html(html)
  
  $('#update_email_dialog form').live 'ajax:success', (event, xhr) ->
    $('#update_email_dialog').addClass('hidden')
  
  $('#update_email_dialog').removeClass('hidden')

window.setup_logout_link = ->
  $('.logout_link').bind 'click', (event) ->
    event.preventDefault()
    
    $.ajax url: '/users/sign_out', type: 'DELETE', success: ->
      window.location.reload()
