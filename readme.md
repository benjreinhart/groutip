# Groutip

jQuery tooltip.

Requires jQuery UI (specifically [position](http://jqueryui.com/demos/position/)) as of right now, :(


### known issues:
Weird interactions when window resizing when the alignment is anything but `topCenter` or `bottomCenter` - otherwise works great.


### TODO

* Fix css edge cases when window is resized.
* Don't rely on jQuery UI
* test in different browsers for cross browser compatibility
* Add tests


### Development

* clone repo
* run `cake createSymlink` to symlink the demo app groutip.js to where the coffeescript output is (in ./groutip.js)
* run `cake watch` to watch the coffeescript file and output to ./
* `open demo/index.html`


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


If you do not supply a `removeHandler`, then after 1000ms if you click anywhere in the document the tooltip will be removed.


## Examples

These are taken from the demo

```javascript
// basic
$('#fave-btn').groutip({
  class: 'tip',
  position: 'topCenter',
  offsetTop: 10,
  template: '<div><p>This is placeholder text, please add your own!</p></div>'
});
```

```javascript
// setup your own remove handler - it will be yielded the groutip instance
$('#fave-btn').groutip({
  class: 'tip',
  position: 'bottomCenter',
  offsetTop: 10,
  template: '<div><span>This is placeholder text, please add your own!</span></div>',
  removeHandler: function(groutip) {
    $('#fave-btn').click(function(){
      groutip.remove()
    });
  }
});
```

```javascript
// if you pass a `remove` option, the Groutip class will not remove
// the tooltip object, but instead call the `remove` option you
// provided and yield the jQuery tooltip object
$('#fave-btn').groutip({
  class: 'tip',
  position: 'bottomLeft',
  offsetTop: 10,
  template: '<div><span>This is placeholder text, please add your own!</span></div>',
  remove: function($tooltip) {
    $tooltip.fadeOut('slow', function(){
      $tooltip.remove()
    });
  }
});
```

```javascript
$('#fave-btn').groutip({
  class: 'tip',
  position: 'leftCenter',
  offsetLeft: 10,
  template: '<div><span>This is placeholder text, please add your own!</span></div>',
  css: {
    backgroundColor: 'red'
  }
});
```

```javascript
// do something right as the tooltip jquery object is displaying
$('#fave-btn').groutip({
  class: 'tip',
  position: 'rightCenter',
  offsetLeft: 10,
  template: '<div><span>This is placeholder text, please add your own!</span></div>',
  onRender: function() {
    alert('rendering tooltip!');
  }
});
```