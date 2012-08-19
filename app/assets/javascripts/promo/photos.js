function photos ()
{

  $(document).ready(function()
  {

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
      social_tools: '<div class="count_view"></div><div class="download_pic"><a http="'+$(this).attr('data-big')+'"></div><div class="pp_social"> \
<div class="soc_like_button"> \
<script type="text/javascript" src="http://userapi.com/js/api/openapi.js?45"></script>\
<script type="text/javascript">\
  VK.init({apiId: 2953652, onlyWidgets: true});\
</script>\
<!-- Put this div tag to the place, where the Like block will be -->\
<div id="vk_like"></div>\
<script type="text/javascript">\
VK.Widgets.Like("vk_like", {type: "button", height: 22}, '+$(this).attr('data-id')+');\
</script>\
</div> \
<iframe src="http://www.facebook.com/plugins/like.php?locale=en_US&href={location_href}&amp;layout=button_count&amp;show_faces=true&amp;width=500&amp;action=like&amp;font&amp;colorscheme=light&amp;height=23" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:500px; height:23px;" allowTransparency="true"></iframe>\
<div class="soc_like_button"> \
<div id="fb-root"></div>\
<script>(function(d, s, id) {\
  var js, fjs = d.getElementsByTagName(s)[0];\
  if (d.getElementById(id)) return;\
  js = d.createElement(s); js.id = id;\
  js.src = "//connect.facebook.net/ru_RU/all.js#xfbml=1&appId=359292310775946";\
  fjs.parentNode.insertBefore(js, fjs);\
}(document, "script", "facebook-jssdk"));</script>\
<div class="fb-like" data-send="true" data-href="'+location.href+'" data-layout="button_count" data-width="230" data-show-faces="false"></div>\
</div>\
<div class="soc_like_button"> \
<!-- Вставьте этот тег в заголовок или непосредственно перед закрывающим тегом . -->\
<script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script>\
<!-- Поместите этот тег туда, где должна отображаться кнопка +1. -->\
<div class="g-plusone" data-size="medium" data-href="'+location.href+'"></div> \
</div> \
<div class="soc_like_button"> <link href="http://stg.odnoklassniki.ru/share/odkl_share.css" rel="stylesheet"><a class="odkl-share-oc" href='+location.href+' onclick="ODKL.Share(this);return false;" ><span>0</span></a><script src="http://stg.odnoklassniki.ru/share/odkl_share.js" type="text/javascript" ></script></div> \
<div class="soc_like_button"><a href="http://twitter.com/share" class="twitter-share-button" data-count="none">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script></div> \
</div>' /* html or false to disable */
    });




    $('#bri-goto-site').mouseenter(function(){
      $(this).stop().animate({ 'top':'0px'}, 300)
    }).mouseleave(function(){
      $(this).stop().animate({ 'top': '-80px'}, 300)
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
