$ = jQuery

$.fn.extend
    wodry : (config = {}) ->
        settings = $.extend({}, config)
        settings.separator ?= '|'
        settings.delay ?= 2000
        settings.animationTime ?= 500
        settings.arm ?= 100
        settings.callback ?= ->

        @animations =
            rotateY:
                front_transform: "translate3d(0,0,#{settings.arm}px)"
                back_transform: "translate3d(0,0,#{settings.arm}px) rotateY(180deg)"
                animation:
                    transform: " rotateY(180deg)"
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
                        result["#{webkit}"] = value
                        result["#{moz}"] = value
                        result["#{o}"] = value
                        result["#{property}"] = value
                    result

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
                    .css prefixer(["transform"],["translate3d(0,0,#{settings.arm}px)"])
                $ "<span class='back-face'>#{array[back_text_index + 1]}</span>"
                    .appendTo flip_container
                $ ".back-face"
                    .css prefixer(["transform"], ["translate3d(0,0,#{settings.arm}px) rotateY(180deg)"])

                flip_container.wrapInner "<span class='adjecting' />"
                    .find(".adjecting").hide().show().css prefixer(["transform","transition"],[ " rotateY(180deg)"," #{settings.animationTime}ms"])
            
            setInterval -> 
                do flip
                do settings.callback
            , (settings.delay + settings.animationTime)