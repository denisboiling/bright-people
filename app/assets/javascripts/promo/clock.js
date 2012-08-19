function clock()
{

  $('#bri-main-clock-mask, #bri-form, #bri-photographers-all').css({"opacity":"0"});

  $('body').css({"height":"500px"});

  $('#bri-main-clock').find("div.bri-photographer:first").addClass("current");



  $('#bri-main-clock-mask').delay(100).animate({
    opacity: 1
  }, 1500, function() {
    //$(.)

    chain_fade('current', '.bri-photographer', '#bri-main-clock');


    $('#bri-form, #bri-photographers-all').delay(1500).animate({opacity: 1}, 1500);

  });

  function chain_fade(current, target, list)
  {
    $('div'+list).find('.bri-photographer.'+current).fadeIn(150, function() {
    $(this).removeClass(current).next(target).addClass(current);
      chain_fade(current, target, list);
    });
  }


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

  var isiPad = navigator.userAgent.match(/iPad/i) != null;
  var isiPhone = navigator.userAgent.match(/iPhone/i) != null;
  var isiPod = navigator.userAgent.match(/iPod/i) != null;

  if(isiPad == true || isiPhone == true || isiPod == true) {
    var clockHeight = 500
    var clockWidth = 500
    $('#bri-main-clock').css({'top':'50%'}).css({'margin-top':'-250px'})
    //$('#bri-form').css({'width':'250px'}).css({'margin-top:':'-2250px'})

    $('#bri-form')
      .css(
      {
        'top'         : clockHeight*.27 + 'px'
      , 'margin-left' : clockHeight*.3 + 'px'
      , 'font-size'   : clockHeight*.04 + 'px'
      })

  $('#bri-main-clock-mask').css({'width':'500px'}).css({'height':'500px'}).css({'margin':'auto'}).css({'margin-top':'-45px'}).css({'margin-left':'205px'})
  }
  else { 
    var clockHeight = clientHeight()
    var clockWidth = clientWidth()

    $('#bri-form')
      .css(
      {
        'top'         : clientHeight()*.3 + 'px'
      , 'margin-left' : clientHeight()*.3 + 'px'
      , 'font-size'   : clientHeight()*.04 + 'px'
      })

  }


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
    , 'top'   : clockHeight*.038 + 'px'
    , 'width' : clientWidth()*.076 + 'px'
    })

    $('.bri-photographer[data-position=3]').css (
    { 
      'left'  : clientWidth()*.349  + 'px'
    , 'top'   : clockHeight*.131 + 'px'
    , 'width' : clientWidth()*.074  + 'px'
    })

    $('.bri-photographer[data-position=4]').css (
    { 
      'left'  : clientWidth()*.337  + 'px'
    , 'top'   : clockHeight*.262 + 'px'
    , 'width' : clientWidth()*.061  + 'px' 
    })
    $('.bri-photographer[data-position=5]').css (
    { 
      'left'  : clientWidth()*.339  + 'px'
    , 'top'   : clockHeight*.397 + 'px'
    , 'width' : clientWidth()*.068  + 'px'
    })
    $('.bri-photographer[data-position=6]').css (
    { 
      'left'  : clientWidth()*.362  + 'px'
    , 'top'   : clockHeight*.497 + 'px'
    , 'width' : clientWidth()*.077  + 'px'
    })
    $('.bri-photographer[data-position=7]').css (
    { 
      'left'  : clientWidth()*.411  + 'px'
    , 'top'   : clockHeight*.577 + 'px'
    , 'width' : clientWidth()*.073  + 'px'
    })
    $('.bri-photographer[data-position=8]').css (
    { 
      'left'  : clientWidth()*.48  + 'px'
    , 'top'   : clockHeight*.622 + 'px'
    , 'width' : clientWidth()*.064  + 'px'
    })
    $('.bri-photographer[data-position=9]').css (
    { 
      'left'  : clientWidth()*.543  + 'px'
    , 'top'   : clockHeight*.594 + 'px'
    , 'width' : clientWidth()*.069  + 'px'
    })
    $('.bri-photographer[data-position=10]').css(
    { 
      'left'  : clientWidth()*.592  + 'px'
    , 'top'   : clockHeight*.518 + 'px'
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

          $(this).toggleClass('active')
          if($(this).hasClass('active')) { 
            $(this).html('Скрыть всех фотографов') 
            $('.bri-number').addClass('hidden')
            $('.bri-photo').removeClass('hidden')
          }
          else { 
            $(this).html('Выбрать всех фотографов') 
            $('.bri-number').removeClass('hidden')
            $('.bri-photo').addClass('hidden')
          }
	  return false
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
