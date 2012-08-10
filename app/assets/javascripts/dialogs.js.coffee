window.setup_dialogs = ->
  $('.dialog_block .close').bind 'click', ->
    $(this).closest('.dialog_block').addClass('hidden')
    false
    
window.setup_notify = ->
  $(document).ready ->
    window.setTimeout (->
        $(".notify").fadeOut 'fast', -> $(this).detach()
    ), 3000