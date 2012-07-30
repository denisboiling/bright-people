window.setup_favourite_button = ->
  $('.favourite_block_is a').live 'click', ->
    window.location.href = '/dashboard/favorites'
    false
  
  $('.favourite_block_add a').live 'click', (event) ->
    event.preventDefault()

  $('.favourite_block_is').live 'click', ->
    $elt = $(this)
    id = $elt.attr('data-id')
    $.ajax url: "/dashboard/favorites/#{id}", data: { _method: 'DELETE' }, type: 'POST', success: ->
      $elt.removeClass('favourite_block_is')
      $elt.addClass('favourite_block_add')
      $elt.removeAttr('data-id')
      $elt.find('a').text('В избранное')
  
  $('.favourite_block_add').live 'click', ->
    $elt = $(this)
    relation_id = $elt.attr('data-relation-id')
    relation_type = $elt.attr('data-relation-type')
    data = id: relation_id, type: relation_type
    $.ajax url: "/dashboard/favorites", type: 'POST', data: data, success: (data)->
      $elt.removeClass('favourite_block_add')
      $elt.addClass('favourite_block_is')
      $elt.attr('data-id', data.id)
      $elt.find('a').text('Избранное')
