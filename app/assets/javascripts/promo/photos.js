function photos ()
{

  $(document).ready(function()
  {

    $('#bri-goto-site').mouseenter(function(){
      $(this).stop().animate({ 'top':'0px'}, 300)
    }).mouseleave(function(){
      $(this).stop().animate({ 'top': '-80px'}, 300)
    })

    $('#bri-hd-switch')
      .click(function()
      {

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
        $("#bri-form-photographers").change();

	if ( $('.bri-photographer:not(.active)').length == 10 ) {
	    $('#bri-photographers-select-all').toggleClass('active')
	    $('#bri-photographers-select-all').html('Выбрать всех фотографов')
	}
	if ( $('.bri-photographer.active').length == 10 ) {
	    $('#bri-photographers-select-all').toggleClass('active')
	    $('#bri-photographers-select-all').html('Убрать всех фотографов')
	}
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
      $("#bri-form-photographers").change();
      })


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
	    $('#bri-form-hour').change()

          }
          // setMinute()
        , function(n)
          {
            if ( n < 10 ) n = '0'+n
            $('#bri-time .bri-minute').html(n)
            $('#bri-form-minute').val(n)
	    $('#bri-form-minute').change()
          }
        )

    // ЧТОБЫ ПОВЕРНУТЬ СТРЕЛКИ ЧАСОВ НА НУЖНОЕ ВРЕМЯ, МОЖНО ИСПОЛЬЗОВАТЬ КОСТЫЛЬ (ВСЯ СОЛЬ В r-60, ГДЕ -60 - ГРАДУС ПОВОРОТА)
    /* clock.minuteHand.animate
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
    */

  })



}
