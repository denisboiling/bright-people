function festival ()
{
  $(document).ready(function()
  {
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
      deeplinking: false,
      callback: function(){
    $('#bri-form-photo').val('');
    window.push_history();
      },
      changepicturecallback: function(){
    console.log("open");
    window.fbAsyncInit();
    window.vk_init("Яркие Люди", location.href, $("#pp_full_res img").attr("src"));
    $("a.twitter-share-button").attr("data-url", location.href)
    $.getScript('http://platform.twitter.com/widgets.js');
      },
      social_tools: '<div class="count_view"></div> \
                           <div class="download_pic"><a></a></div> \
                           <div class="pp_social"> \
                             <div class="soc_like_button"> \
                               <div class="fb-like" data-send="false" data-layout="button_count" data-width="450" data-show-faces="true"></div> \
                             </div> \
                             <div class="soc_like_button"> \
                               <div class="g-plusone" data-size="medium" data-href="' + location.href + '"></div> \
                             </div> \
                             <div class="soc_like_button"> \
                               <a href="https://twitter.com/share" class="twitter-share-button" data-lang="ru" data-url="" target="_blank">Твитнуть</a> \
                             </div> \
                             <div class="soc_like_button"> \
                               <div id="vk_like"></div> \
                             </div> \
                             <div class="soc_like_button"> \
                               <div id="vk_share"></div> \
                             </div> \
                           </div>'
  })
    }

    window.pretty_init_photo()

    var imgs   = $('#am-container').find('img')
    ,   total  = imgs.length
    ,   loaded = 0

    imgs
      .each(function()
      {
        $(this)
          .load(function()
          {
            loaded++
            if (loaded == total)
            {
              /*$('#am-container')
                .montage(
                {
                  minsize     : true
                , fillLastRow : false
                , fixedHeight : 110
                , minw        : 110
                })*/
              window.pretty_init_photo()
            }
          })
      })

    $('#bri-fest-events div.bri-item ')
      .mouseenter(function()
      {
        $('#bri-fest-events .bri-sub').hide()

        $(this).find('a:first').stop().animate
        (
          { fontSize: '200%', color: '#c74866' }
        , 150
        , function ()
          {            
            var margin  = $(this).width()
            $(this).siblings('.bri-sub')
              .css({ left: margin+'px' })
              .show()
          }
        )
      })
      .mouseleave(function()
      {
        $(this).find('.bri-sub').hide()

        $(this).find('a:first').stop().animate
        (
          { fontSize: '100%' }
        , 150
        )
      });
     })

}