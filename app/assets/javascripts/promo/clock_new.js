function Clock ( el, setHour, setMinute )
{
  console.log($(el))

  var obj =
  {
    width               : $(el).width()
  , height              : $(el).height()
  , cx                  : Math.round( $(el).height()/2 )
  , cy                  : Math.round( $(el).height()/2 )
  , hourHandPath        : 'M 15.31 7.33 C 20.01 4.49 25.96 8.24 26.19 13.51 C 28.48 41.32 30.83 69.12 33.01 96.94 C 33.83 106.55 21.36 113.28 13.42 108.46 C 10.56 106.84 7.61 104.63 6.71 101.30 C 5.81 98.63 6.21 95.78 6.37 93.04 C 8.10 66.70 9.77 40.35 11.49 14.01 C 11.63 11.39 13.05 8.71 15.31 7.33 Z'
  , minuteHandPath      : 'M 9.55 10.14 C 9.65 6.76 12.03 2.87 15.89 3.46 C 20.32 3.27 21.87 8.30 21.82 11.90 C 23.95 64.26 26.26 116.62 28.23 168.98 C 23.97 167.44 19.58 165.88 14.97 166.09 C 10.82 166.07 6.88 167.52 3.10 169.07 C 5.38 116.10 7.30 63.12 9.55 10.14 Z'


  /**
   * Transform angle to radians
   */
  , toRadians           : function (angle) { return angle * 2 * Math.PI / 360 }

  /**
   * SVG arc
   */
  , arc : 
      function ( center, radius, startAngle, endAngle ) 
      {
        angle = startAngle;
        coords = this.toCoords(center, radius, angle);
        path = "M " + coords[0] + " " + coords[1];
        while(angle<=endAngle) {
            coords = this.toCoords(center, radius, angle);
            path += " L " + coords[0] + " " + coords[1];
            angle += 1;
        }
        return path;
      }

  , toCoords : 
      function ( center, radius, angle ) 
      {
        var radians = (angle/180) * Math.PI;
        var x = center[0] + Math.cos(radians) * radius;
        var y = center[1] + Math.sin(radians) * radius;
        return [x, y];
      }

  /**
   * Clock hand SVG scale (mega-kostyl)
   */
  , clockHandReplacer :
      function ( str, p, offset, s ) 
      {
        return Math.round( parseFloat(p) * ( (this.height)/639+.1 )*100 ) / 100
      }

  /**
   * Clock base drawing
   */
  , drawClockBase :
      function ( angle, num, radius, segmentAngle, colors, timeMultiplier, strokeWidth, strokeColor, onClick, set )
      {
        for (var i=0; i<num; i++)
        {
          // Clock base segment
          var segment        = obj.paper.path( this.arc( [this.cx,this.cy], radius, angle, angle+segmentAngle ) )
          segment.clickColor = colors[i]
          segment.angle      = angle
          segment.time       = i*timeMultiplier
          segment
            .attr({ 'stroke-width': strokeWidth, 'stroke': ( (!i)? colors[i] : strokeColor ) })
            .hover(function(){ this.attr('cursor','pointer') })
            .click(function(){ onClick(segment) })
            .toBack()
          set.push(segment)

          // Clock base digit
          var x = (radius+strokeWidth+2)*Math.cos( obj.toRadians(angle) )
          ,   y = (radius+strokeWidth+2)*Math.sin( obj.toRadians(angle) )
          ,   tmpLabel = obj.paper.print( obj.cx+x, obj.cy+y, eval(timeMultiplier.replace('%',i)), obj.paper.getFont('a_FuturaRoundDemi'), obj.fontSize )
                      .attr( 'fill', strokeColor )
                      .toFront()
          tmpLabel.transform('t-'+(tmpLabel.getBBox().width/2+1)+',0')

          angle += segmentAngle
        }

        obj.paper.circle( this.cx, this.cy, radius )
          .attr(
          {
            'stroke'       : strokeColor
          , 'stroke-width' : strokeWidth-2
          })
          .toBack()
      }
  }
  
  obj.minuteStroke        = obj.height*.045
  obj.minuteRadius        = (obj.height-obj.minuteStroke-1-obj.height*.2)/2
  obj.minuteStrokeColor   = '#e4dacb'
  obj.minuteSegment       = 360/12
  obj.minuteSegmentColors = ['#ebf736','#e1ed34','#d9e432','#cedb0e','#c7d40c','#c1ce08','#b7c708','#afd247','#a7ca3f','#90c119','#86bd00','#73bc00']
  obj.hourStroke          = obj.height*.075
  obj.hourRadius          = (obj.height-1-obj.hourStroke*2-obj.minuteStroke*9)/2
  obj.hourStrokeColor     = '#c94364'
  obj.hourSegment         = Math.round(360/13)+1
  obj.hourSegmentColors   = ['#fff368','#ffec1d','#ffdd3f','#ffd22d','#fec905','#fcbf07','#ffb400','#ffa800','#f89c1e','#f1900c','#f8820f','#f9760c','#ed5900']
  obj.fontSize            = obj.height*.05

  obj.paper       = Raphael( el.slice(1), this.width, this.height )
  obj.minuteClock = new obj.paper.set()
  obj.hourClock   = new obj.paper.set()

  /**
   * Minute clock base
   */
  obj.drawClockBase 
  (
    -90, 12, obj.minuteRadius, 360/12, obj.minuteSegmentColors, '5*%', obj.minuteStroke, obj.minuteStrokeColor
  , function (segment)
    {
      obj.minuteClock.forEach(function(item)
      {
        item.attr( 'stroke', obj.minuteStrokeColor )
      })
      segment.attr( 'stroke', segment.clickColor )

      obj.minuteHand.animate
      (
        {
          transform: 't'+obj.minuteHand.marginLeft+','+obj.minuteHand.marginTop+'r'+(segment.angle-obj.minuteHand.angle)+','+obj.minuteHand.hx+','+obj.minuteHand.hy
        }
      , 500
      , '<>'
      , function() { setMinute(segment.time) }
      )
    }
  , obj.minuteClock
  )

  /**
   * Minute clock hand
   */
  obj.minuteHand = 
    obj.paper.path
    ( 
      obj.minuteHandPath.replace
      ( 
        /([0-9\.]+)/g
      , function ( str, p, offset, s ) 
        {
          return Math.round( parseFloat(p) * ( (obj.height)/639+.05 )*100 ) / 100
        } 
      ) 
    )
    .attr(
    {
      'fill'         : obj.minuteStrokeColor
    , 'stroke-width' : obj.minuteStroke/8
    , 'stroke'       : '#fff'
    })

  // Centering
  obj.minuteHand.angle      = -90
  obj.minuteHand.marginLeft = obj.cx - obj.minuteHand.getBBox().width / 2 - obj.minuteHand.getBBox().x
  obj.minuteHand.marginTop  = obj.cy - obj.minuteHand.getBBox().height*1.02 - obj.minuteHand.getBBox().y
  obj.minuteHand.hx         = obj.minuteHand.getBBox().width*.64
  obj.minuteHand.hy         = obj.minuteHand.getBBox().height*1.04
  obj.minuteHand.transform('t'+obj.minuteHand.marginLeft+','+obj.minuteHand.marginTop)

  /**
   * Hour clock base
   */
  obj.drawClockBase 
  (
    -150, 12, obj.hourRadius, 360/12, obj.hourSegmentColors, '10+%', obj.hourStroke, obj.hourStrokeColor
  , function (segment)
    {
      obj.hourClock.forEach(function(item)
      {
        item.attr( 'stroke', obj.hourStrokeColor )
      })
      segment.attr( 'stroke', segment.clickColor )

      obj.hourHand.animate
      (
        {
          transform: 't'+obj.hourHand.marginLeft+','+obj.hourHand.marginTop+'r'+(segment.angle-obj.hourHand.angle)+','+obj.hourHand.hx+','+obj.hourHand.hy
        }
      , 500
      , '<>'
      , function()
        { 
          setHour(segment.time)
        }
      )
    }
  , obj.hourClock
  )

  /**
   * Hour clock hand
   */
  obj.hourHand = 
    obj.paper.path
    ( 
      obj.hourHandPath.replace
      ( 
        /([0-9\.]+)/g
      , function ( str, p, offset, s ) 
        {
          return Math.round( parseFloat(p) * ( (obj.height)/639+.08 )*100 ) / 100
        } 
      ) 
    )
    .attr(
    {
      'fill'         : obj.hourStrokeColor
    , 'stroke-width' : obj.hourStroke/8
    , 'stroke'       : '#fff'
    })

  // Centering
  obj.hourHand.angle      = -90
  obj.hourHand.hx         = obj.hourHand.getBBox().width*.75
  obj.hourHand.hy         = obj.hourHand.getBBox().height*.95
  obj.hourHand.marginLeft = obj.cx - obj.hourHand.getBBox().width / 2 - obj.hourHand.getBBox().x
  obj.hourHand.marginTop  = obj.cy - obj.hourHand.hy
  obj.hourHand.transform('t'+obj.hourHand.marginLeft+','+obj.hourHand.marginTop+'r-60,'+obj.hourHand.hx+','+obj.hourHand.hy)

  return obj
}