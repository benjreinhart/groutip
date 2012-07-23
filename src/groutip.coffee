class Groutip

  _tooltips = []
  _cidCount = 0

  @extendDefaults: (options) ->
    # $.extend only shallow copies, so we have to
    # manually extend our nested options object
    options.css = $.extend({}, @::defaults.css, options.css)
    $.extend(@::defaults, options)

  # class method for removing individual or all tooltips
  # used *only* in testing environments
  @remove: (cid) ->
    if cid?
      for tooltip, i in _tooltips
        position = i if tooltip.cid is cid

      # call its remove method and then remove
      # it from the internal collection
      _tooltips[position].remove()
      _tooltips.splice(position, 1)

    else
      # if no args are passed, remove all
      tooltip.remove() for tooltip in _tooltips
      _tooltips = []


  POSITION_MAPPING =
    topCenter:
      my: 'center top'
      at: 'center top'
    bottomCenter:
      my: 'center bottom'
      at: 'center bottom'
    bottomLeft:
      my: 'left bottom'
      at: 'left bottom'
    rightCenter:
      my: 'left center'
      at: 'right center'
    leftCenter:
      my: 'right center'
      at: 'left center'

  html: '
    <div>
      <p>This is placeholder text, add your own!</p>
    </div>
  '

  defaults:
    position: 'topCenter'
    offsetTop: 0
    offsetLeft: 0
    css:
      position: 'absolute'
      zIndex: 10000

  constructor: (opts) ->
    @$el = opts.el

    # extend into an empty object so our original
    # defaults don't get permantly overwritten
    opts.css = $.extend({}, @defaults.css, opts.css)
    @options = $.extend({}, @defaults, opts)

    @$tooltip = this._constructTooltip(@options, @html)

    # save a reference to this handler so we can unbind it
    # from window on remove
    @windowResizeHandler = => this.position()
    $(window).bind 'resize', @windowResizeHandler

    this._setupRemoveHandler(@options)
    this.render()

  render: ->
    # place invisible tooltip on page so we can read the
    # tooltip's width and height dimensions
    @$tooltip.css({ opacity: 0 }).insertAfter(@$el)

    # store width and height dimensions
    @dimensions = this._getDimensions(@$tooltip)

    this.position()

    if (render = @options.render)?
      render(@$tooltip)
    else
      @$tooltip.css opacity: 1

    # add instance to the internal collection
    _tooltips.push(this)

  remove: ->
    $(window).unbind('resize', @windowResizeHandler)

    if (remove = @options.remove)?
      remove(@$tooltip)
    else
      @$tooltip.remove()

  position: ->
    position = @options.position
    opts = POSITION_MAPPING[position]

    # convert possible string representations to ints
    oT = +@options.offsetTop
    oL = +@options.offsetLeft

    switch position
      when 'topCenter'
        offset = "#{ oL } -#{ oT + @dimensions.outerHeight}"
      when 'bottomCenter', 'bottomLeft'
        offset = "#{ oL } #{ oT + @dimensions.outerHeight }"
      when 'leftCenter'
        offset = "-#{ oL } #{ oT }"
      else
        offset = "#{ oL } #{ oT }"

    $.extend opts,
      of: @$el
      offset: offset
      collision: 'none'

    @$tooltip.position(opts)

    # set the tooltip's width and height so it
    # doesn't resize on window resize
    @$tooltip.css
      width: @dimensions.width
      height: @dimensions.height


  _constructTooltip: (options, html) ->
    classes =
      if typeof options.classes is 'string'
        "#{ options.classes } groutip"
      else
        'groutip'

    @cid = _cidCount++

    $(options.html ? html)
      .addClass(classes)
      .css(options.css ? {})
      .data('cid', @cid)

  _getDimensions: ($tooltip) ->
    width: $tooltip.width()
    height: $tooltip.height()
    outerWidth: $tooltip.outerWidth()
    outerHeight: $tooltip.outerHeight()

  _setupRemoveHandler: (options) ->
    if (removeHandler = options.removeHandler)?
      removeHandler(this)
    else
      wait 1000, =>
        $(document).one 'click', =>
          this.remove()


  wait = (delay, callback) => setTimeout(callback, delay)


$.groutip =
  extendDefaults: (options) ->
    Groutip.extendDefaults(options)

  # for testing purposes only
  remove: (cid) ->
    Groutip.remove(cid)


jQuery.fn.groutip = (options) ->
  this.each (i, elem) ->
    options.el = $(elem)
    new Groutip(options)