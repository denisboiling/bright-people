function photos (){

    window.pretty_init_photo = function pretty_init(){
	$("a[rel^='prettyPhoto']").prettyPhoto({
	    animation_speed: 'fast', /* fast/slow/normal */
	    slideshow: false, /* false OR interval time in ms */
	    autoplay_slideshow: false, /* true/false */
	    opacity: 0.80, /* Value between 0 and 1 */
	    show_title: false, /* true/false */
	    autoplay: false,
	    default_width: 500,
	    default_height: 344,
	    allow_resize: true,
	    theme: 'pp_default',
	    gallery_markup: '',
	    changepicturecallback: function(){
		var image_path = $("#pp_full_res img").attr("src");
		$("#link-img").attr("href", image_path);
		$("meta[property='og:image']").attr("content", image_path);
		console.log($("meta[property='og:image']"));
		window.fbAsyncInit();

	    },
	    social_tools: $("div#social_photo").html()
	})
    }

    window.pretty_init_photo()
    
    $('#bri-goto-site').mouseenter(function(){
      $(this).stop().animate({ 'top':'0px'}, 300)
    }).mouseleave(function(){
      $(this).stop().animate({ 'top': '-98px'}, 300)
    })

    $('.bri-photographer').click(function(){
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

    $('#bri-photographers-select-all').click(function(){
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

    var hour = parseInt($('#bri-form-hour').val());
    var minute = parseInt($('#bri-form-minute').val());
    var hour_angle = (hour - 10) * 30 - 420; // 420 and 360 are some magic numbers by author of the script
    var minute_angle = (minute / 5) * 30 - 360;


    hour_colours = ['#fff368','#ffec1d','#ffdd3f','#ffd22d','#fec905','#fcbf07','#ffb400','#ffa800','#f89c1e','#f1900c','#f8820f','#f9760c'];
    base_hour_color = '#c94364';


    minute_colours = ['#ebf736','#e1ed34','#d9e432','#cedb0e','#c7d40c','#c1ce08','#b7c708','#afd247','#a7ca3f','#90c119','#86bd00','#73bc00'];
    base_minute_color = '#e4dacb';
    // ЧТОБЫ ПОВЕРНУТЬ СТРЕЛКИ ЧАСОВ НА НУЖНОЕ ВРЕМЯ, МОЖНО ИСПОЛЬЗОВАТЬ КОСТЫЛЬ (ВСЯ СОЛЬ В r-60, ГДЕ -60 - ГРАДУС ПОВОРОТА)
    clock.minuteHand.animate({
        transform: 't'+clock.minuteHand.marginLeft+','+clock.minuteHand.marginTop+'r' + minute_angle + ','+clock.minuteHand.hx+','+clock.minuteHand.hy
      },
      2500,
      '<>'
    )
    clock.hourHand.animate({
        transform: 't'+clock.hourHand.marginLeft+','+clock.hourHand.marginTop+'r' + hour_angle + ','+clock.hourHand.hx+','+clock.hourHand.hy
      },
      1500,
      '<>'
    )
    // КАК БЛЯТЬ РАСКРАСИТЬ ТО ЧТО ПОД НИМИ
    // reset hours colour
    var arr = $('svg path').slice(0, 12).toArray();
    arr.reverse();
    for(i = 0; i < arr.length; i++) {
      $(arr[i]).attr('stroke', base_hour_color )
    }
    // set hour colours
    $(arr[hour - 10]).attr('stroke', hour_colours[hour - 10]);

    // set minutes colour

    arr = $('svg path').slice(12, 24).toArray();
    arr.reverse();
    for(i = 0; i < arr.length; i++) {
      $(arr[i]).attr('stroke', base_minute_color )
    }
    // set minutes colours
    $(arr[ minute / 5 ]).attr('stroke', minute_colours[minute/5]);

    // в задницу такие костыли
}
