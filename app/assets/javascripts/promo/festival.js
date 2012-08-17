function festival ()
{

  $(document).ready(function()
  {
    function bezier(xa, ya, xb, yb, xc, yc, xd, yd)
    {

      return ['M'+xa, ya, 'C'+xb, yb, xc, yc, xd, yd].join(' ')
    }

    // Init SVG for drawing curves
    var paper = Raphael( 'bri-bezier', $('#bri-fest-events').width(), $('#bri-fest-events').height() )


    $('#bri-fest-events > div.bri-item > a')
      .mouseover(function()
      {
        $('#bri-fest-events .bri-sub').hide()

      //  $(this).parent('div').next().find('a').animate
        //(
        //  { fontSize: '150%', color: '#c74866' }, 150)

        $(this).animate
        (
          { fontSize: '200%', color: '#c74866' }
        , 150
        , function ()
          {
            var margin  = $(this).width()
            $(this).siblings('.bri-sub')
              .css({ left: margin+'px' })
              .show()

            paper.setSize( $('#bri-fest-events').width(), $('#bri-fest-events').height() )

            start = [ $(this).offset().left, $(this).offset().top+$(this).height()/2 ]

            pos = []
            $(this).siblings('.bri-sub').children('div')
              .each(function()
              {
                pos.push( [ $(this).position().left+margin+100, start[1]+$(this).position().top-$(this).height()/2 ] )
              })

            for (var i=0; i<pos.length; i++)
            {
              console.log(start[0], start[1], pos[i][0]/2, start[1], pos[i][0]/2, pos[i][1], pos[i][0], pos[i][1])
              paper.path(bezier( start[0], start[1], pos[i][0]/2, start[1], pos[i][0]/2, pos[i][1], pos[i][0], pos[i][1] ))
                .attr('stroke','#c74866')
            }

          }
        )
      })
      .mouseout(function()
      {
        paper.clear()

        $(this).siblings('.bri-sub').hide()

        $(this).animate
        (
          { fontSize: '100%' }
        , 150
        )


        //$(this).parent('div').next().find('a').animate
        //(
       //   { fontSize: '100%' }
      //  , 150
      //  )

      })


      $(".cat_link").live("click", function(event){
        event.preventDefault();
        var category_title = $(this).text();
        $.ajax({
          url: "/festival",
          data: { category: category_title }
        });
      });
  })

}