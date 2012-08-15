function promo ()
{
	$(document).ready(function()
	{
		$('#bri-preloader')
			.delay(500)
			.fadeOut
			(
				'fast'
			,	function()
				{
					$('#bri-letters img')
						.each(function(i)
						{
							$(this)
								.delay(i*100*1.5*Math.random())
								.animate( { bottom: 0 }, 'normal' )
						})
						
					$('#bri-fest-title')
						.delay(1500)
						.animate
						( 
							{ top: '-105%', opacity: 1 }
						, 'normal'
						,	function ()
							{
								$(this).delay(1000).animate( { top: '-130%', opacity: 0 }, 'normal' )
							}
						)

					$('.bri-photo').addClass('active')

					$('#bri-find-me')
						.delay(5000)
						.animate( { top: '-126%', opacity: 1 }, 'fast' )

					$('#bri-fest')
						.delay(5000)
						.animate( { bottom: '-144%', opacity: 1 }, 'fast' )

					$('footer')
						.delay(6500)
						.fadeIn('normal')
				}
			)
	})

}