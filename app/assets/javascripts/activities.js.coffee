window.setup_activities_list = ->
  return if $('#activities_list').length == 0
  
  # for filtering
  window._activities_params = {}
  hashes = []
  index = window.location.href.indexOf('?')
  if index != -1
    hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&')
  for hash in hashes
    hash = hash.split('=')
    window._activities_params[hash[0]] = hash[1]
  
  link = ->
    url = '/activities'
    pairs = ['remote=true']
    for key, value of window._activities_params
      pairs.push "#{key}=#{value}"
    url += "?" + pairs.join("&")
    url
  
  update_list = ->
    $.ajax
      type: 'GET',
      url: link(),
      success: (content) ->
        $('#activities_list').html(content)
  
  $('.activities_filter_link').bind 'click', (event) ->
    event.preventDefault()
    
    key = $(this).attr('data-key')
    value = $(this).attr('data-value')
    window._activities_params[key] = value
    
    update_list()
  
  $('#activities_metro_station_select').bind 'change', ->
    selected = $(this).val()
    window._activities_params['metro_station_id'] = selected
    
    update_list()
    