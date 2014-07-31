(function() {
  var $;

  $ = jQuery;

  $.fn.extend({
    wodry: function(config) {
      var settings;
      if (config == null) {
        config = {
          separator: '|',
          delay: 2000,
          animationTime: 500,
          arm: 100,
          callback: function() {}
        };
      }
      settings = $.extend({}, config);
      this.each(function() {
        var array, flip, flip_container, prefixer;
        flip_container = $(this);
        array = [];
        $.each(flip_container.text().split(settings.separator), function(key, value) {
          array.push(value);
        });
        flip_container.text(array[0]);
        prefixer = function(property, value) {
          var moz, o, webkit, _ref;
          _ref = ["-webkit-" + property, "-moz-" + property, "-o-" + property], webkit = _ref[0], moz = _ref[1], o = _ref[2];
          return {
            webkit: value,
            moz: value,
            o: value,
            property: value
          };
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
          flip_container.html("");
          $("<span class='front-face'>" + front_text + "</span>").appendTo(flip_container);
          $(".front-face").css(prefixer("transform", "translate3d(0,0," + settings.arm + "px)"));
          $("<span class='back-face'>" + array[back_text_index + 1] + "</span>").appendTo(flip_container);
          $(".back-face").css(prefixer("transform", "translate3d(0,0," + settings.arm + "px) rotateY(180deg)"));
          flip_container.wrapInner("<span class='adjecting' />").find(".adjecting").hide().show().css({
            "-webkit-transform": " rotateY(180deg)",
            "-moz-transform": " rotateY(180deg)",
            "-o-transform": " rotateY(180deg)",
            "transform": " rotateY(180deg)",
            "-webkit-transition": " " + settings.animationTime + "ms",
            "-moz-transition": " " + settings.animationTime + "ms",
            "-o-transition": " " + settings.animationTime + "ms",
            "transition": " " + settings.animationTime + "ms"
          });
        };
        setInterval(function() {
          flip();
          settings.callback();
        }, settings.delay + settings.animationTime);
      });
    }
  });

}).call(this);
