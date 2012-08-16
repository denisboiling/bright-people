function clock()
{
  function clientWidth ()
  {
    var h

    if (window.innerWidth) 
      h = window.innerWidth
    else if (document.documentElement && document.documentElement.clientWidth) 
      h = document.documentElement.clientWidth
    else if (document.body)
      h = document.body.clientWidth

    return h
  }

  function clientHeight ()
  {
    var h

    if (window.innerHeight) 
      h = window.innerHeight
    else if (document.documentElement && document.documentElement.clientHeight) 
      h = document.documentElement.clientHeight
    else if (document.body)
      h = document.body.clientHeight

    return h
  }

  function addPhotographer (el)
  {
    el.children('.bri-number').addClass('hidden')
    el.children('.bri-photo').removeClass('hidden')

    var id   = el.attr('data-id')
    ,   list = $('#bri-form-photographers').val()

    list = ( !list.length )? [] : list.split(',') 
    list.push(id)

    $('#bri-form-photographers').val( list.join(',')  )
  }

  function removePhotographer (el)
  {
    var id   = el.attr('data-id')
    ,   list = $('#bri-form-photographers').val()

    list = list.split(',')

    var deleteId
    for ( var i=0; i< list.length; i++ )
    {
      if ( list[i] == id )
      {
        deleteId = i
        break
      }
    }
    list.splice(i,1)
    
    $('#bri-form-photographers').val( list.join(',')  )

    el.children('.bri-number').removeClass('hidden')
    el.children('.bri-photo').addClass('hidden')
  }

  $(document).ready(function()
  {
    $('.bri-photographer')
      .css(
      {
        'margin-left' : -clientWidth()*.035 +'px'
      , 'font-size'   : clientHeight()*.015 +'px'
      })
      .click(function()
      {
        if ( $(this).children('.bri-photo').hasClass('hidden') )
          addPhotographer( $(this) )
        else
          removePhotographer( $(this) )
      })  

    $('.bri-photographer[data-position=1]').css (
    { 
      'left'  : clientWidth()*.448  + 'px' 
    , 'width' : clientWidth()*.0665 + 'px'
    })

    $('.bri-photographer[data-position=2]').css (
    { 
      'left'  : clientWidth()*.388 + 'px'
    , 'top'   : clientHeight()*.038 + 'px'
    , 'width' : clientWidth()*.076 + 'px'
    })

    $('.bri-photographer[data-position=3]').css (
    { 
      'left'  : clientWidth()*.349  + 'px'
    , 'top'   : clientHeight()*.131 + 'px'
    , 'width' : clientWidth()*.074  + 'px'
    })

    $('.bri-photographer[data-position=4]').css (
    { 
      'left'  : clientWidth()*.337  + 'px'
    , 'top'   : clientHeight()*.262 + 'px'
    , 'width' : clientWidth()*.061  + 'px' 
    })
    $('.bri-photographer[data-position=5]').css (
    { 
      'left'  : clientWidth()*.339  + 'px'
    , 'top'   : clientHeight()*.397 + 'px'
    , 'width' : clientWidth()*.068  + 'px'
    })
    $('.bri-photographer[data-position=6]').css (
    { 
      'left'  : clientWidth()*.362  + 'px'
    , 'top'   : clientHeight()*.497 + 'px'
    , 'width' : clientWidth()*.077  + 'px'
    })
    $('.bri-photographer[data-position=7]').css (
    { 
      'left'  : clientWidth()*.411  + 'px'
    , 'top'   : clientHeight()*.577 + 'px'
    , 'width' : clientWidth()*.073  + 'px'
    })
    $('.bri-photographer[data-position=8]').css (
    { 
      'left'  : clientWidth()*.48  + 'px'
    , 'top'   : clientHeight()*.622 + 'px'
    , 'width' : clientWidth()*.064  + 'px'
    })
    $('.bri-photographer[data-position=9]').css (
    { 
      'left'  : clientWidth()*.543  + 'px'
    , 'top'   : clientHeight()*.594 + 'px'
    , 'width' : clientWidth()*.069  + 'px'
    })
    $('.bri-photographer[data-position=10]').css(
    { 
      'left'  : clientWidth()*.592  + 'px'
    , 'top'   : clientHeight()*.518 + 'px'
    , 'width' : clientWidth()*.0775  + 'px'
    })

    $('#bri-photographers-all')
      .css(
      {
        'padding'   : clientHeight()*.01 + 'px' +' 0 0 '+ clientHeight()*.035 + 'px'
      , 'font-size' : clientHeight()*.02 + 'px'
      })
      .click(function()
      {        
        $('#bri-form-photographers').val('')

        $('.bri-photographer')
          .each(function()
          {
            addPhotographer( $(this) )
          })
      })

    $('#bri-form')
      .css(
      {
        'top'         : clientHeight()*.3 + 'px'
      , 'margin-left' : clientHeight()*.3 + 'px'
      , 'font-size'   : clientHeight()*.04 + 'px'
      })

    // SVG top margin
    $('#bri-svg')
      .css(
      {
        'margin-top' : ($('#bri-main-clock-mask').height()*.18)+'px'
      , 'width'      : ($('#bri-main-clock-mask').height()*.55)+'px'
      , 'height'     : ($('#bri-main-clock-mask').height()*.55)+'px'
      })

    var clock = 
        new Clock
        (
          // Element
          '#bri-svg'
          // setHour()
        , function (n)
          {
            $('#bri-time .bri-hour').html(n)
            $('#bri-form-hour').val(n)
          }
          // setMinute()
        , function(n)
          {
            if ( n < 10 ) n = '0'+n
            $('#bri-time .bri-minute').html(n)
            $('#bri-form-minute').val(n)
          }
        )
    })

}