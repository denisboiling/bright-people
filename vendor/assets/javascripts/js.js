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
