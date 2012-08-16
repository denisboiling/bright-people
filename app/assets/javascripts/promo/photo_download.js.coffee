window.setup_download_photos = ->

  # Already marked div as 
  marked_div = (link) ->
    link.attr('data-action', 'unmark')
    link.text('Unmark')
    link.parents("div.photo:first").addClass("marked")

  marked_div_as_div = (id) ->
    div = $("div.photo##{id}")
    marked_div(div.find("div.download a"))

  # Unmarked div
  unmarked_div = (link) ->
    link.attr('data-action', 'mark')
    link.text('Mark')
    link.parents("div.photo:first").removeClass("marked")

  find_and_mark_all_choose = () ->
    return if localStorage.choose_photos == "[]" || ""
    choose_photos = JSON.parse(localStorage.choose_photos)
    for id in choose_photos
      marked_div_as_div(id)

  update_photo_download_count = () ->
    count = JSON.parse(localStorage.choose_photos).length
    $("#photo_download_count").text(count)

  # Bulk mode is active?
  bulk_mode = () ->
    localStorage.choose_photos_checkbox == "true"

  # Show or not marklink
  toogle_mark_link = () ->
    if bulk_mode()
      $("div.photo div").removeClass("hidden")
    else
      $("div.photo div").addClass("hidden")

  # Check checkbox if localStorage checked
  toogle_checkbox = () ->
    if localStorage.choose_photos_checkbox == "true"
      $("input#choose_photos").attr('checked', true)
    else
       $("input#choose_photos").removeAttr('checked')
    toogle_mark_link()


  click_add_link = (link) ->
    photo_div = link.parents("div.photo:first")
    photo_id = photo_div.attr('id')
    choose_photos = JSON.parse(localStorage.choose_photos)
    if link.attr('data-action') == 'mark'
      choose_photos.push(photo_id)
      marked_div(link)
    else
      choose_photos.shift(choose_photos.indexOf(photo_id))
      unmarked_div(link)

    localStorage.choose_photos = JSON.stringify(choose_photos)
    update_photo_download_count()      


# WHEN PAGE LOADED

  console.log localStorage.choose_photos

  if typeof(localStorage.choose_photos) == "undefined" || localStorage.choose_photos == ""
    localStorage.choose_photos = JSON.stringify([])

  find_and_mark_all_choose()
  update_photo_download_count()
  toogle_checkbox()

  $("input#choose_photos").bind 'change', ->
    if $(this).is(':checked')
      localStorage.choose_photos_checkbox = true
    else
      localStorage.choose_photos_checkbox = false
    toogle_mark_link()

  $("div.download a").live 'click', ->
    click_add_link($(this))
    false

  $("#clean-storage").live 'click', ->
    localStorage.choose_photos = JSON.stringify([])

  $("a#hd_download").bind 'click', ->
    photos = JSON.parse(localStorage.choose_photos)
    $.ajax
      type: 'POST',
      url: '/photos/download',
      data: "ids" : photos
      success: (data) ->
        $("body").append("<iframe src='#{data}' style='display: none;' ></iframe>")
        localStorage.choose_photos = JSON.stringify([])
        find_and_mark_all_choose()
        update_photo_download_count()
        toogle_checkbox()
    false