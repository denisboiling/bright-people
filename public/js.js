$(document).ready(function(){

	$("#slider_fest").slides({
		next: 'next',
		prev: 'prev'
	});
	$("#slider_user").slides({
		next: 'next',
		prev: 'prev'
	});
	$("#slider_org").slides({
		next: 'next',
		prev: 'prev'
	});

  $("#nested_slider .slider_control li a").mouseenter(function(){
		var currentSlider = $(this).attr("rel");
		
		if($(this).hasClass("active")) { return false;}
		
		$("#nested_slider .slider_control li a").removeClass("active");
		$(this).addClass("active");
		
		$("#nested_slider .slider").fadeOut(300);
		$("#nested_slider #"+currentSlider).fadeIn(300);
	});




});
