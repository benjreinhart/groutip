

Requires jQuery UI (specifically [position](http://jqueryui.com/demos/position/)) as of right now, :(

## options


* `offsetTop` - vertical pixels from `element`
* `offsetLeft` - horizontal pixels from `element`
* `css` - same options as jQuery `.css()` takes
* `removeHandler` - function to setup the event handler which will specify when/how to remove the object from the DOM
* `onRender` - function which will be called right before tooltip is displayed
* `remove` - function which will be called as the function to remove the tool tip from the DOM
  * will be passed the tooltip jQuery object