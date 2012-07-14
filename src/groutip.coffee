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

    this._constructToolTip()

    $(window).resize =>
      this._position()

    this.render()

  render: ->
    @$toolTip.css({ opacity: 0 }).appendTo 'body'

    this._storeDimensions()
    this._position()

    @$toolTip.css opacity: 1
    @options.onRender?()

  remove: ->
    @options.onRemove?()
    @$toolTip.remove()

  _constructToolTip: ->
    @$toolTip = $(@options.template ? @template)
    @$toolTip.attr('class', this._getClasses())

  _getClasses: ->
    return @options.klass unless @options.class?
    "#{ @options.klass } #{ @options.class }"

  _position: ->
    position = @options.position ? 'topCenter'
    opts = POSITION_MAPPING[position]

    # allow either strings or ints for offset opts
    oT = +(@options.offsetTop  ? 0)
    oL = +(@options.offsetLeft ? 0)

    switch position
      when 'topCenter'
        offset = "#{ oL } -#{ oT + @height}"
      when 'bottomCenter', 'bottomLeft'
        offset = "#{ oL } #{ oT + @height }"
      when 'leftCenter'
        offset = "-#{ oL } #{ oT }"
      else
        offset = "#{ oL } #{ oT }"

    $.extend opts, 
      of: @$el
      offset: offset

    @$toolTip.position(opts)

  _storeDimensions: ->
    @width  = @$toolTip.outerWidth()
    @height = @$toolTip.outerHeight()


jQuery.fn.groutip = (options) ->
  options.el = this
  new Groutip(options)