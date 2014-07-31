$ = jQuery

$.fn.extend
    wodry : (config = {}) ->
        settings = $.extend({}, config)
        settings.separator ?= '|'
        settings.delay ?= 2000
        settings.animationTime ?= 500
        settings.arm ?= 0
        settings.animation ?= 'rotateY'
        settings.callback ?= ->

        animations =
            rotateY:
                front_transform: "translate3d(0,0,#{settings.arm}px)"
                back_transform: "translate3d(0,0,#{settings.arm}px) rotateY(180deg)"
                action:
                    transform: " rotateY(180deg)"
                    transition:" #{settings.animationTime}ms"
            rotateX:
                front_transform: "translate3d(0,0,#{settings.arm}px)"
                back_transform: "translate3d(0,0,#{settings.arm}px) rotateX(180deg)"
                action:
                    transform: " rotateX(180deg)"
                    transition:" #{settings.animationTime}ms"
            rotateAll:
                isCoplex: true
                front_transform: "translate3d(0,0,0) rotateX(180deg) rotateY(180deg)"
                back_transform: "translate3d(0,0,0) rotateX(180deg) rotateY(180deg)"
                action:
                    transform: " rotateX(180deg) rotateY(180deg)"
                    transition:" #{settings.animationTime}ms"

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
                    , 20

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
            , (settings.delay + settings.animationTime)