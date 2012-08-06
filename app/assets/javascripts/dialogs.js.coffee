window.setup_dialogs = ->
  $('.dialog_block .close').bind 'click', ->
    $(this).closest('.dialog_block').addClass('hidden')
    false
    
window.setup_notify = ->
  $(document).ready ->
    # console.log "dasd"
    # TODO: rewrite!!!! error!!!
    # slideUp = window.setTimeout ( ->
    #   $('.notify').animate { marginTop :  } 'normal', -> $(this).detach()
    # )
    # , 5000