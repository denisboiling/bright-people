function photos ()
{

  $(document).ready(function()
  {
    $('#bri-hd-switch')
      .click(function()
      {
        $(this).toggleClass('active')

        $('.am-wrapper').toggleClass('bri-hd')
        $('.am-wrapper .bri-checkbox').fadeToggle('fast')

        return false
      })

    $('.am-wrapper.bri-hd .bri-checkbox')
      .live( 'click', function()
      {
        $(this).parent().toggleClass('active')

        // TODO: REWRITE THIS ACCORDING TO THE MAX'S SCRIPT!!!111
        if ( $(this).hasClass('active') )
        {
          var ids = JSON.parse( window.localStorage.get('photos') )
          ids.push( $(this).parent().parent().attr('data-id') )
          window.localStorage.set('photos', JSON.stringify('photos'))
        }

        // TODO: IF THERE ONE OR MORE PHOTOS SELECTED - SHOW DOWNLOAD ICON!!1

        return false
      })

    $('#bri-hd-download')
      .click(function()
      {
        // Do the twist!
      })

  function addPhotographer (el) {
    var id   = el.attr('data-id')
    ,   list = $('#bri-form-photographers').val()

    list = ( !list.length )? [] : list.split(',') 
    list.push(id)

    $('#bri-form-photographers').val( list.join(',')  ).change()
  }

  function removePhotographer (el) {
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

    $('#bri-form-photographers').val( list.join(',')  ).change()

  }

    $('.bri-photographer')
      .click(function() {
	if ($(this).hasClass("active")){
	    removePhotographer($(this))
	} else {
	    addPhotographer($(this))
	}
        $(this).toggleClass('active')
        $(this).find('.bri-photo').slideToggle('fast')
        $(this).find('.bri-camera').slideToggle('fast')

        return false
      })

    $('#bri-photographers-select-all')
      .click(function()
      {
        $('.bri-photographer').each(function(){ 
	    if (! $(this).hasClass("active")){
		$(this).click() 
	    }
	     
	})
	  
      })

    var $container = $('#bri-photos')
    ,   $imgs      = $container.find('img')
    ,   totalImgs  = $imgs.length
    ,   cnt        = 0
        
    $imgs.each(function(i) 
    {
      var $img  = $(this)
      
      $('<img/>')
        .load(function() 
        {
          ++cnt
          if( cnt === totalImgs ) 
          {
            // $imgs.show()

            $container.montage(
            {
              fillLastRow           : true
            , alternateHeight       : true
            , alternateHeightRange  : { min : 90, max : 240 }
            })
          }
        })
        .attr( 'src', $img.attr('src') )
    });

    var clock = 
        new Clock
        (
          // Element
          '#bri-clock'
          // setHour()
        , function (n)
          {
            $('#bri-time .bri-hour').html(n)
            $('#bri-form-hour').val(n).change()
          }
          // setMinute()
        , function(n)
          {
            if ( n < 10 ) n = '0'+n
            $('#bri-time .bri-minute').html(n)
            $('#bri-form-minute').val(n).change()
          }
        )

    // ЧТОБЫ ПОВЕРНУТЬ СТРЕЛКИ ЧАСОВ НА НУЖНОЕ ВРЕМЯ, МОЖНО ИСПОЛЬЗОВАТЬ КОСТЫЛЬ (ВСЯ СОЛЬ В r-60, ГДЕ -60 - ГРАДУС ПОВОРОТА)
    // clock.minuteHand.animate
    //   (
    //     {
    //       transform: 't'+clock.minuteHand.marginLeft+','+clock.minuteHand.marginTop+'r-60,'+clock.minuteHand.hx+','+clock.minuteHand.hy
    //     }
    //   , 500
    //   , '<>'
    //   )
    // clock.hourHand.animate
    //   (
    //     {
    //       transform: 't'+clock.hourHand.marginLeft+','+clock.hourHand.marginTop+'r-120,'+clock.hourHand.hx+','+clock.hourHand.hy
    //     }
    //   , 500
    //   , '<>'
    //   )

    $(function()
    {
      $.Lightbox.construct({
        show_linkback: false,
        show_helper_text: false,
        show_info: true,
        show_extended_info: true,
        download_link: true,
        keys: {
          close: 'z',
          prev: 'q',
          next: 'e'
        },
        opacity: 0.7,
        text: {
          image: 'Фото',
          of: 'из',
          close: 'Закрыть',
          download: 'Загрузить'
    }
  });
  
});
  })

}