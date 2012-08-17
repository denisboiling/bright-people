function photos ()
{

  $(document).ready(function()
  {
    $('#bri-hd-switch')
      .click(function()
      {

if($(this).hasClass('active')) {
         
  $("#bri-photos a").lightbox();

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

}
  else {

$("#bri-photods a").lightbox();

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

}

        $(this).toggleClass('active')





        $('.am-wrapper').toggleClass('bri-hd')
        $('.am-wrapper .bri-checkbox').fadeToggle('fast')

        return false
      })

    $('.am-wrapper.bri-hd ')
      .live( 'click', function()
      {
        
        

        $(this).toggleClass('active')

        if($('.am-wrapper.active').length > 0 && $('#bri-hd-switch').hasClass('active') ) { $('#bri-hd-download').show() }
        else { $('#bri-hd-download').hide()}

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

    $('.bri-photographer')
      .click(function()
      {
        $(this).toggleClass('active')
        $(this).find('.bri-photo').slideToggle('fast')
        $(this).find('.bri-camera').slideToggle('fast')
	$("#bri-form-photographers").val(window.choose_photographers());
        $("form#bri-form-photos").submit()
        return false
      })

    $('#bri-photographers-select-all')
      .click(function()
      {

    	$(this).toggleClass('active')
        if ($(this).hasClass('active')) { 
    	    $(this).html('Убрать всех фотографов')
    	    $('.bri-photographer').each(function(){ 
    	    	if (! $(this).hasClass("active")) {
    	    	    $(this).toggleClass('active')
    	    	    $(this).find('.bri-photo').slideToggle('fast')
    	    	    $(this).find('.bri-camera').slideToggle('fast')
    	    	}
    	    })
    	} else { 
    	    $(this).html('Выбрать всех фотографов') 
    	    $('.bri-photographer').each(function() { 
    	    	if ($(this).hasClass("active")){
    	    	    $(this).toggleClass('active')
    	    	    $(this).find('.bri-photo').slideToggle('fast')
    	    	    $(this).find('.bri-camera').slideToggle('fast')
    	    	}
    	    })
      }
      $("#bri-form-photographers").val(window.choose_photographers());
      $("form#bri-form-photos").submit()
      })




    var $container = $('#bri-photos')
    ,   $imgs      = $container.find('img').hide()
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
             $imgs.fadeIn('slow')

             $('#bri-preloader').remove();

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

    // ЧТОБЫ ПОВЕРНУТЬ СТРЕЛКИ ЧАСОВ НА НУЖНОЕ ВРЕМЯ, МОЖНО ИСПОЛЬЗОВАТЬ КОСТЫЛЬ (ВСЯ СОЛЬ В r-60, ГДЕ -60 - ГРАДУС ПОВОРОТА)
     clock.minuteHand.animate
       (
         {
           transform: 't'+clock.minuteHand.marginLeft+','+clock.minuteHand.marginTop+'r-360,'+clock.minuteHand.hx+','+clock.minuteHand.hy
         }
       , 2500
       , '<>'
       )
     clock.hourHand.animate
       (
         {
           transform: 't'+clock.hourHand.marginLeft+','+clock.hourHand.marginTop+'r-420,'+clock.hourHand.hx+','+clock.hourHand.hy
         }
       , 1500
      , '<>'
     )

    




  })

  $(function()
  {
    $("#bri-photos a").lightbox();
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

}
