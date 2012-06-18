window.setup_dialogs = ->
  $('.dialog_block .close').bind 'click', ->
    $(this).closest('.dialog_block').addClass('hidden')
    false