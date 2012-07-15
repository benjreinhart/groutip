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


## Examples

These are taken from the demo

```javascript
  $('#top-center').click(function(){
    $('#fave-btn').groutip({
      class: 'tip',
      position: 'topCenter',
      offsetTop: 10,
      template: '<div><p>This is placeholder text, please add your own!</p></div>'
    });
  });
```

```javascript
  $('#bottom-center').click(function(){
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
  });
```

```javascript
  $('#bottom-left').click(function(){
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
  });
```

```javascript
  $('#left-center').click(function(){
    $('#fave-btn').groutip({
      class: 'tip',
      position: 'leftCenter',
      offsetLeft: 10,
      template: '<div><span>This is placeholder text, please add your own!</span></div>',
      css: {
        backgroundColor: 'red'
      }
    });
  });
```

```javascript
  $('#right-center').click(function(){
    $('#fave-btn').groutip({
      class: 'tip',
      position: 'rightCenter',
      offsetLeft: 10,
      template: '<div><span>This is placeholder text, please add your own!</span></div>',
      onRender: function() {
        alert('rendering tooltip!');
      }
    });
  });
```