class Groutip

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

  template: "
    <div>
      <p>This is placeholder text, add your own!</p>
    </div>
  "

  defaultCSS: ->
    position: 'absolute'
    zIndex: 10000

  defaults: ->
    position: 'topCenter'
    offsetTop: 0
    offsetLeft: 0

  constructor: (opts) ->
    @$el = opts.el
    opts.css = $.extend(this.defaultCSS(), opts.css)
    @options = $.extend(this.defaults(), opts)

    @$tooltip = this._constructTooltip(@options, @template)

    # save a reference to this handler so we can unbind it
    # from window on remove
    @windowResizeHandler = => this.position()
    $(window).bind 'resize', @windowResizeHandler

    this._setupRemoveHandler(@options)
    this.render()

  render: ->
    # place invisible tooltip on page so we can read the
    # tooltip's width and height dimensions
    @$tooltip.css({ opacity: 0 }).appendTo('body')

    # store width and height dimensions
    @dimensions = this._getDimensions(@$tooltip)

    this.position()

    if (render = @options.render)?
      render(@$tooltip)
    else
      @$tooltip.css opacity: 1

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

    @$tooltip.css
      width: @dimensions.width
      height: @dimensions.height

    # set the child to absolute so it doesn't change shape
    # on window resize
    $(@$tooltip.children()[0]).css position: 'absolute'


  _constructTooltip: (options, template) ->
    $(options.template ? template)
      .attr('class', options.class)
      .css(options.css ? {})

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

jQuery.fn.groutip = (options) ->
  options.el = this
  new Groutip(options)