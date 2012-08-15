function photos ()
{

  $(document).ready(function()
  {
    $('.bri-photographer')
      .click(function()
      {
        $(this).toggleClass('active')
        $(this).find('.bri-photo').slideToggle('fast')
        $(this).find('.bri-camera').slideToggle('fast')
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