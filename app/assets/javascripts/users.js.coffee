# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.setup_email_dialog = ->
  return unless $.cookie('email_dialog')
  
  $('#email_dialog').dialog
    modal: true,
    closeOnEscape: false,
    open: (event, ui) -> # hide close button
      $(this).parent().find(".ui-dialog-titlebar-close").hide()
  
  $('#update_email_form').live 'ajax:error', (event, xhr) ->
    html = xhr.responseText
    $('#email_dialog').html(html)
  
  $('#update_email_form').live 'ajax:success', (event, xhr) ->
    $('#email_dialog').dialog('close')