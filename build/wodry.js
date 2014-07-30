(function() {
  (function($) {
    return $.fn.wodry = function(config) {
      var Wodry;
      return Wodry = (function() {
        function Wodry(options) {
          if (options == null) {
            options = {
              separator: '|',
              delay: 2000,
              animationTime: 500,
              amr: 100
            };
          }
          this.options = options;
        }

        Wodry.config = $.extend({}, Wodry.options);

        Wodry.default_css = "style='-webkit-transform: translate3d(0,0," + Wodry.config.arm + "px); -moz-transform: translate3d(0,0," + Wodry.config.arm + "px); -ms-transform: translate3d(0,0," + Wodry.config.arm + "px); -0-transform: translate3d(0,0," + Wodry.config.arm + "px); transform: translate3d(0,0," + Wodry.config.arm + "px);";

        return Wodry;

      })();
    };
  })(jQuery);

}).call(this);
