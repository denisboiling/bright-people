(function()
{
  function clientWidth ()
  {
    var h

    if (window.innerWidth) 
      h = window.innerWidth
    else if (document.documentElement && document.documentElement.clientWidth) 
      h = document.documentElement.clientWidth
    else if (document.body)
      h = document.body.clientWidth

    return h
  }

  function clientHeight ()
  {
    var h

    if (window.innerHeight) 
      h = window.innerHeight
    else if (document.documentElement && document.documentElement.clientHeight) 
      h = document.documentElement.clientHeight
    else if (document.body)
      h = document.body.clientHeight

    return h
  }

  function addPhotographer (el)
  {
    el.children('.bri-number').addClass('hidden')
    el.children('.bri-photo').removeClass('hidden')

    var id   = el.attr('data-id')
    ,   list = $('#bri-form-photographers').val()

    list = ( !list.length )? [] : list.split(',') 
    list.push(id)

    $('#bri-form-photographers').val( list.join(',')  )
  }

  function removePhotographer (el)
  {
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
    
    $('#bri-form-photographers').val( list.join(',')  )

    el.children('.bri-number').removeClass('hidden')
    el.children('.bri-photo').addClass('hidden')
  }

  function setHour (n)
  {
    $('#bri-time .bri-hour').html(n)
    $('#bri-form-hour').val(n)
  }

  function setMinute (n)
  {
    if ( n < 10 ) n = '0'+n
    $('#bri-time .bri-minute').html(n)
    $('#bri-form-minute').val(n)
  }

  $(document).ready(function()
  {
    $('.bri-photographer')
      .css(
      {
        'margin-left' : -clientWidth()*.035 +'px'
      , 'font-size'   : clientHeight()*.015 +'px'
      })
      .click(function()
      {
        if ( $(this).children('.bri-photo').hasClass('hidden') )
          addPhotographer( $(this) )
        else
          removePhotographer( $(this) )
      })

    $('.bri-photographer[data-id=1]').css (
    { 
      'left'  : clientWidth()*.448  + 'px' 
    , 'width' : clientWidth()*.0665 + 'px'
    })

    $('.bri-photographer[data-id=2]').css (
    { 
      'left'  : clientWidth()*.388 + 'px'
    , 'top'   : clientHeight()*.038 + 'px'
    , 'width' : clientWidth()*.076 + 'px'
    })

    $('.bri-photographer[data-id=3]').css (
    { 
      'left'  : clientWidth()*.349  + 'px'
    , 'top'   : clientHeight()*.131 + 'px'
    , 'width' : clientWidth()*.074  + 'px'
    })

    $('.bri-photographer[data-id=4]').css (
    { 
      'left'  : clientWidth()*.337  + 'px'
    , 'top'   : clientHeight()*.262 + 'px'
    , 'width' : clientWidth()*.061  + 'px' 
    })
    $('.bri-photographer[data-id=5]').css (
    { 
      'left'  : clientWidth()*.339  + 'px'
    , 'top'   : clientHeight()*.397 + 'px'
    , 'width' : clientWidth()*.068  + 'px'
    })
    $('.bri-photographer[data-id=6]').css (
    { 
      'left'  : clientWidth()*.362  + 'px'
    , 'top'   : clientHeight()*.497 + 'px'
    , 'width' : clientWidth()*.077  + 'px'
    })
    $('.bri-photographer[data-id=7]').css (
    { 
      'left'  : clientWidth()*.411  + 'px'
    , 'top'   : clientHeight()*.577 + 'px'
    , 'width' : clientWidth()*.073  + 'px'
    })
    $('.bri-photographer[data-id=8]').css (
    { 
      'left'  : clientWidth()*.48  + 'px'
    , 'top'   : clientHeight()*.622 + 'px'
    , 'width' : clientWidth()*.064  + 'px'
    })
    $('.bri-photographer[data-id=9]').css (
    { 
      'left'  : clientWidth()*.543  + 'px'
    , 'top'   : clientHeight()*.594 + 'px'
    , 'width' : clientWidth()*.069  + 'px'
    })
    $('.bri-photographer[data-id=10]').css(
    { 
      'left'  : clientWidth()*.592  + 'px'
    , 'top'   : clientHeight()*.518 + 'px'
    , 'width' : clientWidth()*.0775  + 'px'
    })

    $('#bri-photographers-all')
      .css(
      {
        'padding'   : clientHeight()*.01 + 'px' +' 0 0 '+ clientHeight()*.035 + 'px'
      , 'font-size' : clientHeight()*.02 + 'px'
      })
      .click(function()
      {        
        $('#bri-form-photographers').val('')

        $('.bri-photographer')
          .each(function()
          {
            addPhotographer( $(this) )
          })
      })

    $('#bri-form')
      .css(
      {
        'top'         : clientHeight()*.3 + 'px'
      , 'margin-left' : clientHeight()*.3 + 'px'
      , 'font-size'   : clientHeight()*.04 + 'px'
      })

  })




  // Scale SVG manually
  function replacer(str, p, offset, s) 
  {
    var ratio = (clientHeight())/1330+.1
    return Math.round( parseFloat(p)*ratio*100 ) /100;
  }

  // To radians
  function rad (angle)
  {
    return angle * 2 * Math.PI / 360
  }

  var hourHandPath   = 'M 15.31 7.33 C 20.01 4.49 25.96 8.24 26.19 13.51 C 28.48 41.32 30.83 69.12 33.01 96.94 C 33.83 106.55 21.36 113.28 13.42 108.46 C 10.56 106.84 7.61 104.63 6.71 101.30 C 5.81 98.63 6.21 95.78 6.37 93.04 C 8.10 66.70 9.77 40.35 11.49 14.01 C 11.63 11.39 13.05 8.71 15.31 7.33 Z'
  ,   minuteHandPath = 'M 9.55 10.14 C 9.65 6.76 12.03 2.87 15.89 3.46 C 20.32 3.27 21.87 8.30 21.82 11.90 C 23.95 64.26 26.26 116.62 28.23 168.98 C 23.97 167.44 19.58 165.88 14.97 166.09 C 10.82 166.07 6.88 167.52 3.10 169.07 C 5.38 116.10 7.30 63.12 9.55 10.14 Z'

  // Drawing arc
  function arc(center, radius, startAngle, endAngle) 
  {
    angle = startAngle;
    coords = toCoords(center, radius, angle);
    path = "M " + coords[0] + " " + coords[1];
    while(angle<=endAngle) {
        coords = toCoords(center, radius, angle);
        path += " L " + coords[0] + " " + coords[1];
        angle += 1;
    }
    return path;
  }
    function toCoords(center, radius, angle) {
        var radians = (angle/180) * Math.PI;
        var x = center[0] + Math.cos(radians) * radius;
        var y = center[1] + Math.sin(radians) * radius;
        return [x, y];
    }

  $(document).ready(function()
  {
    var width         = Math.round( $('#bri-main-mask').height()*.5 )
    ,   height        = width
    ,   cx            = Math.round( height/2 )
    ,   cy            = Math.round( height/2 )
    ,   minuteStroke  = height*.045
    ,   minuteRadius  = (height-minuteStroke-1-height*.2)/2
    ,   minuteColor   = '#e4dacb'
    ,   minuteSegment = 360/12
    ,   hourStroke    = height*.075
    ,   hourRadius    = (height-1-hourStroke*2-minuteStroke*9)/2
    ,   hourColor     = '#c94364'
    ,   hourSegment   = Math.round(360/13)+1
    ,   fontSize      = height*.04


    var marginLeft, marginTop, hx, hy, i, angle, x, y, tmpLabel, tmpSet, segment, sumAngle, colors

    // SVG top margin
    $('#bri-svg')
      .css( 'margin-top', (height*.406)+'px')

    // Init SVG
    var Clock = Raphael( 'bri-svg', width, height )
    ,   minuteClock = new Clock.set()
    ,   hourClock = new Clock.set()



    // Minute digits
    colors = ['#ebf736','#e1ed34','#d9e432','#cedb0e','#c7d40c','#c1ce08','#b7c708','#afd247','#a7ca3f','#90c119','#86bd00','#73bc00']
    angle = -90
    for ( i=0; i<12; i++ )
    {
      tmpSet = new Clock.set()

      // Segment
      segment = Clock.path( arc( [cx,cy], minuteRadius, angle, angle+minuteSegment ) )
      segment.clickColor = colors[i]
      segment.angle      = angle
      segment.time       = i*5 
      segment.attr(
        {
          'stroke-width' : minuteStroke,
          'stroke'       : (!i)? colors[i] : minuteColor
        })
        .hover(function()
        {
          this.attr('cursor','pointer')
        })
        .click(function()
        {
          var color = this.attr('stroke')
          ,   time  = this.time
          minuteClock.forEach(function(item)
          {
            item.attr( 'stroke', minuteColor )
          })
          this.attr( 'stroke', this.clickColor )

          minuteHand.animate
          (
            {
              transform: 't'+minuteHand.marginLeft+','+minuteHand.marginTop+'r'+(minuteHand.angle+this.angle)+','+minuteHand.hx+','+minuteHand.hy
            }
          , 500
          , '<>'
          , function()
            { 
              minuteHand.angle = this.angle 
              setMinute(time)
            }
          )
        })
      minuteClock.push(segment)

      // Digit
      x = (minuteRadius+height*.06)*Math.cos( rad(angle) )
      y = (minuteRadius+height*.06)*Math.sin( rad(angle) )
      tmpLabel = Clock.print( cx+x, cy+y, i*5, Clock.getFont('a_FuturaRoundDemi'), fontSize )
                  .attr( 'fill', minuteColor )
      tmpLabel.transform('t-'+(tmpLabel.getBBox().width/2+1)+',0')

      minuteClock.push(tmpSet)

      angle += minuteSegment
    }

    // Hour digits
    angle = -150
    colors = ['#fff368','#ffec1d','#ffdd3f','#ffd22d','#fec905','#fcbf07','#ffb400','#ffa800','#f89c1e','#f1900c','#f8820f','#f9760c','#ed5900']
    for ( i=0; i<12; i++ )
    {
      tmpSet = new Clock.set()

      // Segment
      segment = Clock.path( arc( [cx,cy], hourRadius, angle, angle+hourSegment+1 ) )
      segment.clickColor = colors[i]
      segment.angle      = angle
      segment.time       = 10+i
      segment
        .attr(
        {
          'stroke-width' : hourStroke,
          'stroke'       : (!i)? colors[i] : hourColor
        })
        .hover(function()
        {
          this.attr('cursor','pointer')
        })
        .click(function()
        {
          var color = this.attr('stroke')
          ,   time  = this.time
          hourClock.forEach(function(item)
          {
            item.attr( 'stroke', hourColor )
          })
          this.attr( 'stroke', this.clickColor )

          hourHand.animate
          (
            {
              transform: 't'+hourHand.marginLeft+','+hourHand.marginTop+'r'+(hourHand.angle+this.angle+1.5)+','+hourHand.hx+','+hourHand.hy
            }
          , 500
          , '<>'
          , function()
            { 
              hourHand.angle = this.angle
              setHour(time)
            }
          )
        })
      hourClock.push(segment)

      // Digit
      x = (hourRadius+height*.06)*Math.cos( rad(angle) )
      y = (hourRadius+height*.06)*Math.sin( rad(angle) )
      tmpLabel = Clock.print( cx+x, cy+y, i+10, Clock.getFont('a_FuturaRoundDemi'), fontSize )
                  .attr( 'fill', hourColor )
      tmpLabel.transform('t-'+(tmpLabel.getBBox().width/2+1)+',0')

      angle += hourSegment
    }

    // Last segment
    Clock.path( arc( [cx,cy], hourRadius, angle, angle+hourSegment+1 ) )
      .attr(
      {
        'stroke-width' : hourStroke,
        'stroke'       : hourColor
      })
      .toBack()

    // Last digit
    x = (hourRadius+height*.06)*Math.cos( rad(angle) )
    y = (hourRadius+height*.06)*Math.sin( rad(angle) )
    tmpLabel = Clock.print( cx+x, cy+y, i+10, Clock.getFont('a_FuturaRoundDemi'), fontSize )
                .attr( 'fill', hourColor )
    tmpLabel.transform('t-'+(tmpLabel.getBBox().width/2+1)+',0')



    // Set of objects
    var minuteHand  = Clock.path( minuteHandPath.replace( /([0-9\.]+)/g, replacer ) )
    ,   hourHand    = Clock.path( hourHandPath.replace( /([0-9\.]+)/g, replacer ) )

    // Minute hand  
    minuteHand
      .attr(
      {
        'fill'         : minuteColor
      , 'stroke-width' : minuteStroke/8
      , 'stroke'       : '#fff'
      })

    // Centering
    minuteHand.angle      = 90
    minuteHand.marginLeft = cx - minuteHand.getBBox().width / 2 - minuteHand.getBBox().x
    minuteHand.marginTop  = cy - minuteHand.getBBox().height*1.02 - minuteHand.getBBox().y
    minuteHand.hx         = minuteHand.getBBox().width*.64
    minuteHand.hy         = minuteHand.getBBox().height*1.04
    minuteHand.transform('t'+minuteHand.marginLeft+','+minuteHand.marginTop)

    // Hour hand
    hourHand
      .attr(
      {
        'fill'         : hourColor 
      , 'stroke-width' : hourStroke/8
      , 'stroke'       : '#fff'
      })

    // Centering
    hourHand.angle      = 90
    hourHand.hx         = hourHand.getBBox().width*.75
    hourHand.hy = hourHand.getBBox().height*.95
    hourHand.marginLeft = cx - hourHand.getBBox().width / 2 - hourHand.getBBox().x
    hourHand.marginTop  = cy - hourHand.getBBox().height*.9 - hourHand.getBBox().y
    hourHand.transform('t'+marginLeft+','+marginTop)

    // Rotating
    hourHand.transform( 't'+hourHand.marginLeft+','+hourHand.marginTop+'r-55.4,'+hourHand.hx+','+hourHand.hy )
  })

})(jQuery)