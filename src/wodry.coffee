$ = jQuery

$.fn.extend
    wodry : (config = {}) ->
        settings = $.extend({}, config)
        settings.separator ?= '|'
        settings.delay ?= 2000
        settings.animationDuration ?= 500
        settings.animation ?= 'rotateY'
        settings.callback ?= ->
        settings.shift ?= {}
        settings.shift.x ?= 0;
        settings.shift.y ?= 0;
        settings.shift.z ?= 0;

        animations =
            rotateY:
                front_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px)"
                back_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) rotateY(180deg)"
                action:
                    transform: " rotateY(180deg)"
                    transition:" #{settings.animationDuration}ms"
            rotateX:
                front_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px)"
                back_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) rotateX(180deg)"
                action:
                    transform: " rotateX(180deg)"
                    transition:" #{settings.animationDuration}ms"
            rotateAll:
                isCoplex: true
                front_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) rotateX(180deg) rotateY(180deg)"
                back_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) rotateX(180deg) rotateY(180deg)"
                action:
                    transform: " rotateX(180deg) rotateY(180deg)"
                    transition:" #{settings.animationDuration}ms"
            scaleX:
                isCoplex: true
                front_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) scaleX(0.1)"
                back_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) scaleX(0.1)"
                action:
                    transform: " scaleX(10)"
                    transition:" #{settings.animationDuration}ms"
            scaleY:
                isCoplex: true
                front_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) scaleY(0.1)"
                back_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) scaleY(0.1)"
                action:
                    transform: " scaleY(10)"
                    transition:" #{settings.animationDuration}ms"
            scaleAll:
                isCoplex: true
                front_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) scaleY(0.1) slaleX(0.1)"
                back_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) scaleY(0.1) scaleX(0.1)"
                action:
                    transform: " scaleY(10) scaleX(10)"
                    transition:" #{settings.animationDuration}ms"
            anticlockwise:
                isCoplex: true
                front_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) rotate3d(100,40,-80,180deg)"
                back_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) rotate3d(100,40,-80,180deg)"
                action:
                    transform: " rotate3d(100,40,-80,180deg)"
                    transition:" #{settings.animationDuration}ms"
            clockwise:
                isCoplex: true
                front_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) rotate3d(40,100,80,180deg)"
                back_transform: "translate3d(#{settings.shift.x}px,#{settings.shift.y}px,#{settings.shift.z}px) rotate3d(40,100,80,180deg)"
                action:
                    transform: " rotate3d(40,100,80,180deg)"
                    transition:" #{settings.animationDuration}ms"

        @each ->
            flip_container = $(this)
            array = []
            $.each(flip_container.text().split(settings.separator), (key, value) -> array.push value)
            flip_container.text array[0]

            prefixer = (properties, values) ->
                result = {}
                propHash = {}
                
                for property in properties
                    i = properties.indexOf property
                    propHash[property] = values[i]

                if properties.length is values.length 
                    for own property, value of propHash 
                        [webkit, moz, o] = ["-webkit-#{property}","-moz-#{property}","-o-#{property}"]
                        result[webkit] = value
                        result[moz] = value
                        result[o] = value
                        result[property] = value
                    result

            animate = (animation,container,currentText, nextText) ->
                container.html ""
                $ "<span class='front-face'>#{currentText}</span>"
                    .appendTo container
                $ ".#{container.context.className} .front-face"
                    .css prefixer(["transform"],[animation.front_transform])
                $ "<span class='back-face'>#{nextText}</span>"
                    .appendTo container
                $ ".#{container.context.className} .back-face"
                    .css prefixer(["transform"], [animation.back_transform])

                container.wrapInner "<span class='adjecting' />"
                    .find(".adjecting").hide().show().css prefixer(["transform","transition"],[animation.action.transform,animation.action.transition])

                if animation.isCoplex
                    setTimeout ->
                        do $(".#{container.context.className} .front-face").remove
                    , 1

            flip = ->
                if flip_container.find(".back-face").length > 0
                    flip_container.html do flip_container.find(".back-face").html

                front_text = do flip_container.text
                back_text_index = $.inArray front_text, array
                if (back_text_index + 1) is array.length
                    back_text_index = -1

                animate(animations[settings.animation],flip_container,front_text,array[back_text_index + 1])
            
            setInterval -> 
                do flip
                do settings.callback
            , (settings.delay + settings.animationDuration)