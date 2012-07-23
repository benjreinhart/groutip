// Generated by CoffeeScript 1.3.1
(function() {
  var Groutip;

  Groutip = (function() {
    var POSITION_MAPPING, wait, _tooltips,
      _this = this;

    Groutip.name = 'Groutip';

    _tooltips = [];

    Groutip.extendDefaults = function(options) {
      options.css = $.extend({}, this.prototype.defaults.css, options.css);
      return $.extend(this.prototype.defaults, options);
    };

    Groutip.remove = function(cid) {
      var tooltip, _i, _len;
      for (_i = 0, _len = _tooltips.length; _i < _len; _i++) {
        tooltip = _tooltips[_i];
        tooltip.remove();
      }
      return _tooltips = [];
    };

    POSITION_MAPPING = {
      topCenter: {
        my: 'center top',
        at: 'center top'
      },
      bottomCenter: {
        my: 'center bottom',
        at: 'center bottom'
      },
      bottomLeft: {
        my: 'left bottom',
        at: 'left bottom'
      },
      rightCenter: {
        my: 'left center',
        at: 'right center'
      },
      leftCenter: {
        my: 'right center',
        at: 'left center'
      }
    };

    Groutip.prototype.html = '\
    <div>\
      <p>This is placeholder text, add your own!</p>\
    </div>\
  ';

    Groutip.prototype.defaults = {
      position: 'topCenter',
      offsetTop: 0,
      offsetLeft: 0,
      css: {
        position: 'absolute',
        zIndex: 10000
      }
    };

    function Groutip(opts) {
      var _this = this;
      this.$el = opts.el;
      opts.css = $.extend({}, this.defaults.css, opts.css);
      this.options = $.extend({}, this.defaults, opts);
      this.$tooltip = this._constructTooltip(this.options, this.html);
      this.windowResizeHandler = function() {
        return _this.position();
      };
      $(window).bind('resize', this.windowResizeHandler);
      this._setupRemoveHandler(this.options);
      this.render();
    }

    Groutip.prototype.render = function() {
      var render;
      this.$tooltip.css({
        opacity: 0
      }).insertAfter(this.$el);
      this.dimensions = this._getDimensions(this.$tooltip);
      this.position();
      if ((render = this.options.render) != null) {
        render(this.$tooltip);
      } else {
        this.$tooltip.css({
          opacity: 1
        });
      }
      return _tooltips.push(this);
    };

    Groutip.prototype.remove = function() {
      var remove;
      $(window).unbind('resize', this.windowResizeHandler);
      if ((remove = this.options.remove) != null) {
        return remove(this.$tooltip);
      } else {
        return this.$tooltip.remove();
      }
    };

    Groutip.prototype.position = function() {
      var oL, oT, offset, opts, position;
      position = this.options.position;
      opts = POSITION_MAPPING[position];
      oT = +this.options.offsetTop;
      oL = +this.options.offsetLeft;
      switch (position) {
        case 'topCenter':
          offset = "" + oL + " -" + (oT + this.dimensions.outerHeight);
          break;
        case 'bottomCenter':
        case 'bottomLeft':
          offset = "" + oL + " " + (oT + this.dimensions.outerHeight);
          break;
        case 'leftCenter':
          offset = "-" + oL + " " + oT;
          break;
        default:
          offset = "" + oL + " " + oT;
      }
      $.extend(opts, {
        of: this.$el,
        offset: offset,
        collision: 'none'
      });
      this.$tooltip.position(opts);
      return this.$tooltip.css({
        width: this.dimensions.width,
        height: this.dimensions.height
      });
    };

    Groutip.prototype._constructTooltip = function(options, html) {
      var classes, _ref, _ref1;
      classes = typeof options.classes === 'string' ? "" + options.classes + " groutip" : 'groutip';
      return $((_ref1 = options.html) != null ? _ref1 : html).addClass(classes).css((_ref = options.css) != null ? _ref : {});
    };

    Groutip.prototype._getDimensions = function($tooltip) {
      return {
        width: $tooltip.width(),
        height: $tooltip.height(),
        outerWidth: $tooltip.outerWidth(),
        outerHeight: $tooltip.outerHeight()
      };
    };

    Groutip.prototype._setupRemoveHandler = function(options) {
      var removeHandler,
        _this = this;
      if ((removeHandler = options.removeHandler) != null) {
        return removeHandler(this);
      } else {
        return wait(1000, function() {
          return $(document).one('click', function() {
            return _this.remove();
          });
        });
      }
    };

    wait = function(delay, callback) {
      return setTimeout(callback, delay);
    };

    return Groutip;

  }).call(this);

  $.groutip = {
    extendDefaults: function(options) {
      return Groutip.extendDefaults(options);
    },
    remove: function() {
      return Groutip.remove();
    }
  };

  jQuery.fn.groutip = function(options) {
    return this.each(function(i, elem) {
      options.el = $(elem);
      return new Groutip(options);
    });
  };

}).call(this);
