window.setup_prev_next_expert_arrows = ->
  $('.prev_exp, .next_exp').bind 'click', ->
    url = $(this).attr('data-url')
    window.location = url

# for mentions and approved activities
window.setup_expert_tabs = ->
  $('.expert_tab a').bind 'click', (event) ->
    event.preventDefault()
    
    $('.expert_tab').removeClass('active')
    $(this).closest('.expert_tab').addClass('active')
    sel = $(this).closest('.expert_tab').attr('data-for')
    $('.expert_tab_content').addClass('hidden')
    $(".#{sel}").removeClass('hidden')