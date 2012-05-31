window.setup_slider = ->
  $("#menu .current").mouseenter(->
    $("#menu .sub_menu").fadeIn 100
  ).mouseleave ->
    $("#menu .sub_menu").fadeOut 100

  $("div.magazine_tab div.mag_tabs:first").show()

  $("div.magazine_control li a").live "click", ->
    currentTab = $(this).attr("rel")
    $("div.magazine_tab div.mag_tabs").hide()
    $("div.magazine_tab").find("#" + currentTab).show()
    false

  $("#nested_slider .slider_control li a").mouseenter ->
    currentSlider = $(this).attr("rel")
    $("#nested_slider .slider").fadeOut 300
    $("#nested_slider #" + currentSlider).fadeIn 300

  $("#slider_news").slides
    next: "next"
    prev: "prev"

  $("#slider_user").slides
    next: "next"
    prev: "prev"