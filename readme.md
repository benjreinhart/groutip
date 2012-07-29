# Groutip

jQuery tooltip aimed at being as flexible and simple as possible.

Requires jQuery UI (specifically [position](http://jqueryui.com/demos/position/)) as of right now, :(

### TODO

* Don't rely on jQuery UI
* Test in different browsers for cross browser compatibility
* Add tests


### Development

* clone repo
* run `cake createSymlink` to symlink the demo app groutip.js to where the coffeescript output is (in ./groutip.js)
* run `cake watch` to watch the coffeescript file and output to ./
* `open demo/index.html`


## options


* `offsetTop` - vertical pixels from `element`
* `offsetLeft` - horizontal pixels from `element`
* `classes` - classes you want to assign to the tooltip (redundant considering you pass in the html)
* `html` - the markup and content that'll make up the tooltip
* `position` - the position you want the tooltip to be aligned
  * `topCenter`
  * `bottomCenter`
  * `bottomLeft`
  * `leftCenter`
  * `rightCenter`
* `css` - same options as jQuery `.css()` takes
* `removeHandler` - function to setup the event handler which will specify when/how to remove the object from the DOM
  * will be passed the instance of the Groutip class so you can call `remove()` on it
* `render` - function which will be called as the function to display the tooltip
  * will be passed the tooltip jQuery object
* `remove` - function which will be called as the function to remove the tool tip from the DOM
  * will be passed the tooltip jQuery object


If you do not supply a `removeHandler`, then after 1000ms if you click anywhere in the document the tooltip will be removed.


## Defaults

If you want to provide a set of global defaults, you can make a call to `$.groutip.extendDefaults` and pass an options hash that takes any/all the options outlined above.

```javascript
$.groutip.extendDefaults({
  position: 'bottomLeft'
});
```

The above will make all the tooltips positioned `bottomLeft`.

## Examples

These are taken from the demo

```javascript
// Basic
$('#fave-btn').groutip({
  classes: 'tip',
  position: 'topCenter',
  offsetTop: 10,
  html: '<div><p>This is placeholder text, please add your own!</p></div>'
});
```

```javascript
// Setup your own remove handler - it will be yielded the groutip instance.
// The only method of interest on the groutip instance is `remove`, which unbinds
// events and then calls the `remove` option (if provided) or just calls jQuery.remove()
// on the tooltip object.

$('#fave-btn').groutip({
  classes: 'tip',
  position: 'bottomCenter',
  offsetTop: 10,
  html: '<div><span>This is placeholder text, please add your own!</span></div>',
  removeHandler: function(groutip) {
    $('#fave-btn').click(function(){
      groutip.remove()
    });
  }
});
```

```javascript
// If you pass a `remove` option, the Groutip class will not remove
// the tooltip object, but instead call the `remove` option you
// provided and yield the jQuery tooltip object, at which point it's
// your responsibility to remove it from the DOM

$('#fave-btn').groutip({
  classes: 'tip',
  position: 'bottomLeft',
  offsetTop: 10,
  html: '<div><span>This is placeholder text, please add your own!</span></div>',
  remove: function($tooltip) {
    $tooltip.fadeOut('slow', function(){
      $tooltip.remove()
    });
  }
});
```

```javascript
// pass in CSS attributes
$('#fave-btn').groutip({
  classes: 'tip',
  position: 'leftCenter',
  offsetLeft: 10,
  html: '<div><span>This is placeholder text, please add your own!</span></div>',
  css: {
    backgroundColor: 'red'
  }
});
```

```javascript
// pass a render option which will be used to display the tooltip

// The already created, inserted and positioned tooltip will be passed to the function,
// although the tooltip will have opacity of 0. A good use case for this is so
// you can easily use custom animations/effects to display the tooltip.

$('#fave-btn').groutip({
  classes: 'tip',
  position: 'rightCenter',
  offsetLeft: 10,
  html: '<div><span>This is placeholder text, please add your own!</span></div>',
  render: function($tooltip) {
    $tooltip.fadeTo('slow', 1)
  }
});
```

## License

(The MIT License)

Copyright (c) 2012 Ben Reinhart &lt;benjreinhart@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.