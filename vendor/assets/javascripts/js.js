$(document).ready(function(){

	$(".personality_slider").slides({
		next: 'next',
		prev: 'prev'
	});


    $(window).bind('scroll',function () {
        var scrollT = $(window).scrollTop();
        if(scrollT >= 680){
        	$(".rubric_wrapp").addClass("fixed");
        }
        else{
        	$(".rubric_wrapp").removeClass("fixed");
        }
    });


	
    // <![CDATA[ 
    var so = new SWFObject("/assets/header.swf", "bnr_1", "100%", "204"); 
    so.addParam("wmode", "transparent");
    so.write("flashcontent_1"); 		
    // ]]> 
	
	// Opera FIX
	$('.thumb img').each(
        function(i,e){
            $(e).css(
                {
                    'backgroundImage':'url('+e.src+')'
                }
            )
        }
    );

});
