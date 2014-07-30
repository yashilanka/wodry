(($) ->
	$.fn.wodry = (config) ->
		class Wodry
			constructor: (options = {separator: '|', delay: 2000, animationTime: 500, amr: 100}) ->
				@options = options

			@config = $.extend({}, @options)

			@default_css = 
			"
				style='-webkit-transform: translate3d(0,0,#{@config.arm}px);
				-moz-transform: translate3d(0,0,#{@config.arm}px);
				-ms-transform: translate3d(0,0,#{@config.arm}px);
				-0-transform: translate3d(0,0,#{@config.arm}px);
				transform: translate3d(0,0,#{@config.arm}px);
			"

)(jQuery);