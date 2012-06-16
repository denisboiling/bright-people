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
	
	
	$("div.soc_widget_tab a").live('click', function(){
		var currentTab = $(this).attr('rel');
		
		$("div.soc_widget_tab a").removeClass("active");
		$(this).addClass("active");
		
		$("div.socialnet div.soc_widget").hide();
		$("div.socialnet").find("#"+currentTab).show();
		return false;
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
