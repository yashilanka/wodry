$ = jQuery

$.fn.extend
	wodry : (config = {separator: '|', delay: 2000, animationTime: 500, arm: 100, callback: ->}) ->
		settings = $.extend({}, config)

		@each ->
			flip_container = $(this)
			array = []
			$.each(flip_container.text().split(settings.separator), (key, value) -> 
				array.push value
				return)
			flip_container.text array[0]

			flip = ->
				if flip_container.find(".back-face").length > 0
					flip_container.html do flip_container.find(".back-face").html

				front_text = do flip_container.text
				back_text_index = $.inArray front_text, array
				if (back_text_index + 1) is array.length
					back_text_index = -1

				flip_container.html ""
				$ "<span class='front-face'>#{front_text}</span>"
					.appendTo flip_container
				$ ".front-face"
					.css {
						"-webkit-transform": "translate3d(0,0,#{settings.arm}px)",
						"-moz-transform": "translate3d(0,0,#{settings.arm}px)",
						"-o-transform": "translate3d(0,0,#{settings.arm}px)",
						"transform": "translate3d(0,0,#{settings.arm}px)",
					}
				$ "<span class='back-face'>#{array[back_text_index + 1]}</span>"
					.appendTo flip_container
				$ ".back-face"
					.css {
						"-webkit-transform": "translate3d(0,0,#{settings.arm}px) rotateY(180deg)",
						"-moz-transform": "translate3d(0,0,#{settings.arm}px) rotateY(180deg)",
						"-o-transform": "translate3d(0,0,#{settings.arm}px) rotateY(180deg)",
						"transform": "translate3d(0,0,#{settings.arm}px) rotateY(180deg)",
					}

				flip_container.wrapInner "<span class='adjecting' />"
					.find(".adjecting").hide().show().css {
									"-webkit-transform": " rotateY(180deg)",
									"-moz-transform": " rotateY(180deg)",
									"-o-transform": " rotateY(180deg)",
									"transform": " rotateY(180deg)",
									"-webkit-transition": " #{settings.animationTime}ms",
									"-moz-transition": " #{settings.animationTime}ms",
									"-o-transition": " #{settings.animationTime}ms",
									"transition": " #{settings.animationTime}ms",
								}
				return
			
			setInterval -> 
				do flip
				do settings.callback
				return
			, (settings.delay + settings.animationTime)
			return
		return