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

  defaults: ->
    klass: 'groutip'

  constructor: (opts) ->
    @$el = opts.el
    @options = $.extend(this.defaults(), opts)

    @$tooltip = this._constructTooltip(@options, @template)

    # save a reference to this handler so we can unbind it
    # from window on remove
    @windowResizeHandler = => this.position()
    $(window).bind 'resize', @windowResizeHandler

    this._setupRemoveHandler(@$tooltip, @$el, @options)
    this.render()

  render: ->
    # place invisible tooltip on page so we can read the
    # tooltip's width and height dimensions
    @$tooltip.css({ opacity: 0 }).appendTo('body')

    # store width and height dimensions
    @dimensions = this._getDimensions(@$tooltip)
    this.position()

    @$tooltip.css opacity: 1
    @options.onRender?()

  remove: ->
    $(window).unbind('resize', @windowResizeHandler)
    @options.onRemove?()

    if @options.remove?
      @options.remove(@$tooltip)
    else
      @$tooltip.remove()

  position: ->
    position = @options.position ? 'topCenter'
    opts = POSITION_MAPPING[position]

    # allow either strings or ints for offset opts
    oT = +(@options.offsetTop  ? 0)
    oL = +(@options.offsetLeft ? 0)

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

    @$tooltip.position(opts)

    @$tooltip.css
      width: @dimensions.width
      height: @dimensions.height

    # set the child to absolute so it doesn't change shape
    # on window resize
    $(@$tooltip.children()[0]).css position: 'absolute'


  _constructTooltip: (options, template) ->
    $(options.template ? template)
      .attr('class', this._getClasses(options))
      .css(options.css ? {})

  _getClasses: (options) ->
    return options.klass unless options.class?
    "#{ options.klass } #{ options.class }"

  _getDimensions: ($tooltip) ->
    width: $tooltip.width()
    height: $tooltip.height()
    outerWidth: $tooltip.outerWidth()
    outerHeight: $tooltip.outerHeight()

  _setupRemoveHandler: ($tooltip, $el, options) ->
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