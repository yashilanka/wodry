(function() {
  var $,
    __hasProp = {}.hasOwnProperty;

  $ = jQuery;

  $.fn.extend({
    wodry: function(config) {
      var animations, settings;
      if (config == null) {
        config = {};
      }
      settings = $.extend({}, config);
      if (settings.separator == null) {
        settings.separator = '|';
      }
      if (settings.delay == null) {
        settings.delay = 2000;
      }
      if (settings.animationTime == null) {
        settings.animationTime = 500;
      }
      if (settings.arm == null) {
        settings.arm = 0;
      }
      if (settings.animation == null) {
        settings.animation = 'rotateX2';
      }
      if (settings.callback == null) {
        settings.callback = function() {};
      }
      animations = {
        rotateY: {
          front_transform: "translate3d(0,0," + settings.arm + "px)",
          back_transform: "translate3d(0,0," + settings.arm + "px) rotateY(180deg)",
          action: {
            transform: " rotateY(180deg)",
            transition: " " + settings.animationTime + "ms"
          }
        },
        rotateX: {
          front_transform: "translate3d(0,0," + settings.arm + "px)",
          back_transform: "translate3d(0,0," + settings.arm + "px) rotateX(180deg)",
          action: {
            transform: " rotateX(180deg)",
            transition: " " + settings.animationTime + "ms"
          }
        },
        rotateAll: {
          isCoplex: true,
          front_transform: "translate3d(0,0,0) ",
          back_transform: "translate3d(0,0,0) rotateX(180deg) rotateY(180deg)",
          action: {
            transform: " rotateX(180deg) rotateY(180deg)",
            transition: " " + settings.animationTime + "ms"
          }
        }
      };
      return this.each(function() {
        var animate, array, flip, flip_container, prefixer;
        flip_container = $(this);
        array = [];
        $.each(flip_container.text().split(settings.separator), function(key, value) {
          return array.push(value);
        });
        flip_container.text(array[0]);
        prefixer = function(properties, values) {
          var i, moz, o, propHash, property, result, value, webkit, _i, _len, _ref;
          result = {};
          propHash = {};
          for (_i = 0, _len = properties.length; _i < _len; _i++) {
            property = properties[_i];
            i = properties.indexOf(property);
            propHash[property] = values[i];
          }
          if (properties.length === values.length) {
            for (property in propHash) {
              if (!__hasProp.call(propHash, property)) continue;
              value = propHash[property];
              _ref = ["-webkit-" + property, "-moz-" + property, "-o-" + property], webkit = _ref[0], moz = _ref[1], o = _ref[2];
              result[webkit] = value;
              result[moz] = value;
              result[o] = value;
              result[property] = value;
            }
            return result;
          }
        };
        animate = function(animation, container, currentText, nextText) {
          container.html("");
          $("<span class='front-face'>" + currentText + "</span>").appendTo(container);
          $(".front-face").css(prefixer(["transform"], [animation.front_transform]));
          $("<span class='back-face'>" + nextText + "</span>").appendTo(container);
          $(".back-face").css(prefixer(["transform"], [animation.back_transform]));
          container.wrapInner("<span class='adjecting' />").find(".adjecting").hide().show().css(prefixer(["transform", "transition"], [animation.action.transform, animation.action.transition]));
          if (animation.isCoplex) {
            return setTimeout(function() {
              return $(".front-face").remove();
            }, 20);
          }
        };
        flip = function() {
          var back_text_index, front_text;
          if (flip_container.find(".back-face").length > 0) {
            flip_container.html(flip_container.find(".back-face").html());
          }
          front_text = flip_container.text();
          back_text_index = $.inArray(front_text, array);
          if ((back_text_index + 1) === array.length) {
            back_text_index = -1;
          }
          return animate(animations[settings.animation], flip_container, front_text, array[back_text_index + 1]);
        };
        return setInterval(function() {
          flip();
          return settings.callback();
        }, settings.delay + settings.animationTime);
      });
    }
  });

}).call(this);
