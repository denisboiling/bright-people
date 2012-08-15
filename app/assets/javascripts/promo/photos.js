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

    $('.bri-photographer')
      .click(function()
      {
        $(this).toggleClass('active')
        $(this).find('.bri-photo').slideToggle('fast')
        $(this).find('.bri-camera').slideToggle('fast')

        return false
      })

    $('#bri-photographers-select-all')
      .click(function()
      {
        $('.bri-photographer').each(function(){ $(this).click() })
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