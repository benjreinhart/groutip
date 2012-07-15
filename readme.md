# Groutip

jQuery tooltip.

Requires jQuery UI (specifically [position](http://jqueryui.com/demos/position/)) as of right now, :(

## options


* `offsetTop` - vertical pixels from `element`
* `offsetLeft` - horizontal pixels from `element`
* `class` - classes you want to assign to the tooltip
* `template` - the markup and content that'll make up the tooltip
* `position` - the position you want the tooltip to be aligned
  * `topCenter`
  * `bottomCenter`
  * `bottomLeft`
  * `leftCenter`
  * `rightCenter`
* `css` - same options as jQuery `.css()` takes
* `removeHandler` - function to setup the event handler which will specify when/how to remove the object from the DOM
  * will be passed the instance of the Groutip class so you can call `remove()` on it
* `onRender` - function which will be called right before tooltip is displayed
* `remove` - function which will be called as the function to remove the tool tip from the DOM
  * will be passed the tooltip jQuery object
