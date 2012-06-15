$(document).ready(function(){

	$("#menu .current").mouseenter(function(){
		$("#menu .sub_menu").fadeIn(100);
	}).mouseleave(function(){
		$("#menu .sub_menu").fadeOut(100);
	});

	/* Bright magazine tab */
	$("div.magazine_tab div.mag_tabs:first").show();
	$("div.magazine_control li a").live('click', function(){
		var currentTab = $(this).attr('rel');
		$("div.magazine_tab div.mag_tabs").hide();
		$("div.magazine_tab").find("#"+currentTab).show();
		return false;
	});
	
	$("#nested_slider .slider_control li a").mouseenter(function(){
		var currentSlider = $(this).attr("rel");
		
		if($(this).hasClass("active")) { return false;}
		
		$("#nested_slider .slider_control li a").removeClass("active");
		$(this).addClass("active");
		
		$("#nested_slider .slider").fadeOut(300);
		$("#nested_slider #"+currentSlider).fadeIn(300);
	});

	$("#slider_news").slides({
		next: 'next',
		prev: 'prev'
	});

	$("#slider_user").slides({
		next: 'next',
		prev: 'prev'
	});
	
	$("#slider_fest").slides({
		next: 'next',
		prev: 'prev'
	});

	$("#ruk_slider").slides({
		next: 'next',
		prev: 'prev'
	});
	
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