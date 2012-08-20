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
		(function(d, s, id) {
		    var js, fjs = d.getElementsByTagName(s)[0];
		    if (d.getElementById(id)) return;
		    js = d.createElement(s); js.id = id;
		    js.src = "//connect.facebook.net/ru_RU/all.js#xfbml=1&appId=359292310775946";
		    fjs.parentNode.insertBefore(js, fjs);
		}(document, "script", "facebook-jssdk"));
      },
	    social_tools: '<div class="count_view"></div><div class="download_pic"><a></a></div><div class="pp_social"> \
<div class="soc_like_button"> \
<script type="text/javascript" src="http://userapi.com/js/api/openapi.js?45"></script>\
<script type="text/javascript">\
  VK.init({apiId: 2953652, onlyWidgets: true});\
</script>\
<!-- Put this div tag to the place, where the Like block will be -->\
<div id="vk_like"></div>\
<script type="text/javascript">\
VK.Widgets.Like("vk_like", {type: "button", height: 22}, {data_id});\
</script>\
</div> \
<div class="soc_like_button"> \
<div id="vk_share">\
<script type="text/javascript">VK.Share.button(false,{type: "round_nocount", text: "Поделиться"});</script>\
</div> \
</div> \
<div class="soc_like_button"> \
  <iframe src="http://www.facebook.com/plugins/like.php?href={location_href}&amp;send=false&amp;layout=button_count&amp;width=80&amp;show_faces=false&amp;action=like&amp;locale=en_US&amp;colorscheme=light&amp;font&amp;height=20" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:80px; height:20px;" allowTransparency="true"></iframe> \
</div>\
<div class="soc_like_button"> \
<!-- Вставьте этот тег в заголовок или непосредственно перед закрывающим тегом . -->\
<script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script>\
<!-- Поместите этот тег туда, где должна отображаться кнопка +1. -->\
<div class="g-plusone" data-size="medium" data-href="{location_uri_g}"></div> \
</div> \
<div class="soc_like_button"> <link href="http://stg.odnoklassniki.ru/share/odkl_share.css" rel="stylesheet"><a class="odkl-share-oc" href={location_href} onclick="ODKL.Share(this);return false;" ><span>0</span></a><script src="http://stg.odnoklassniki.ru/share/odkl_share.js" type="text/javascript" ></script></div> \
<div class="soc_like_button"> \
<a href="https://twitter.com/share" class="twitter-share-button" href="{location_href}" data-lang="ru">Твитнуть</a> \
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script> \
</div>' /* html or false to disable */
    })
    }

    window.pretty_init_photo()
    
    $('#bri-goto-site').mouseenter(function(){
      $(this).stop().animate({ 'top':'0px'}, 300)
    }).mouseleave(function(){
      $(this).stop().animate({ 'top': '-98px'}, 300)
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