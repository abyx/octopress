---
layout: post
title: "Advanced ng-model Integration for Bug-free Controls"
date: 2017-08-06 19:15:13 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 248291
---

In the [last post](http://www.codelord.net/2017/07/28/youre-not-using-ng-model-enough/) I explained that developers have a lot to gain by making sure their custom controls work properly with `ng-model`.
That post shows the starting point - making trivial things like the `required` validation work and having the form’s `$valid` [property](http://www.codelord.net/2017/07/02/angularjs-form-properties-guide/) take into account custom controls.

But that’s just the tip of the iceberg, and `ng-model` allows for quite a bit more customization and integration in order to allow writing controls that work as smoothly as builtin ones.

In this post I’ll how to start integrating your control with the `NgModelController` and make your controls more capable and robust.

## Our Starting Position

Let’s keep going with the example from the previous post, which was this very simple component:

```javascript
angular.module('app').component('myCustomControl', {
  template: '...',
  bindings: {
    value: '=ngModel'
  }
});
```

A good first step would be to note that we can use this control with the `name` attribute, since `ngModel` looks for it:

```html
<form name="$ctrl.form">
  <my-custom-control ng-model="someValue" name="foo">
  </my-custom-control>
</form>
```

By supplying `name="foo"` we can now access it from the form to make sure it’s valid, e.g. `$ctrl.form.foo.$valid`.

## Changing Values Properly

In order to make our component work seamlessly with `ng-change` we will need to make sure that whenever the control’s value is changed as a result of a user interaction (not programmatically), we let `NgModelController` know.

First, we will need to make sure to `require` the `NgModelController`, and then, when the user clicks a button, invoke `$setViewValue`:

```javascript
angular.module('app').component('myCustomControl', {
  template: '...',
  require: {
    ngModelCtrl: 'ngModel'
  }
  bindings: {
    value: '=ngModel'
  },
  controller: function() {
    var self = this;
    self.userToggledOn = function() {
      self.ngModelCtrl.$setViewValue(true, 'click');
    }
  }
});
```

The important bits here are the `require` definition and the handling of the user’s click in `userToggledOn`, which calls `NgModelController`’s `$setViewValue`.
Note that second parameter which lets it know what kind of DOM event triggered the change.

## Defining emptiness 

In my previous post I showed how `required` can simply be dropped in and used once `ng-model` is in place.
That’s only the case, though, if your definition of “emptiness” matches the default logic as described [in the documentation](https://docs.angularjs.org/api/ng/type/ngModel.NgModelController#$isEmpty).
But in case your control’s logic doesn’t match this, e.g. your model is an array and emptiness means the array is empty, you should override this behavior to let `NgModelController` know what you expect.

Inside your controller, after requiring `ngModel` as shown above, do this:

```javascript
function SomeCtrl() {
  var self = this;
  self.$onInit = function() {
    self.ngModelCtrl.$isEmpty = function(value) {
      return !value || value.length === 0;
    };
  };
}
```

As you can see, we’re overriding the `$isEmpty` method, which is intended exactly for this purpose.

Also, note I’m making sure to access `ngModelCtrl` on `$onInit`, since it will [not be defined earlier](http://www.codelord.net/2017/01/01/angular-1-dot-6-is-here-what-you-need-to-know/).

## Handling Programatic Changes

An important part of the integration is to make sure the view is changed whenever the model value gets changed programmatically.
For example, if the control’s `ng-model` attribute is a binding from its parent, and the parent changes that value, it usually means that the control should update the UI in order to show this state (e.g. because an update was received from the server).

In those scenarios, `NgModelController` expects us to override the `$render` method.
`NgModelController` places a `$watch` on its value, and calls `$render` when it needs to change (though, note this watch is a shallow watch. If you’re mutating an object as your model, you will need to trigger it manually).

This would look roughly like so:

```javascript
function SomeCtrl() {
  var self = this;
  self.$onInit = function() {
    // ... previous stuff
    self.ngModelCtrl.$render = function() {
      // Update the UI according to the self.ngModelCtrl.$viewValue
    }
  };
}
```

That’s it for now.
There’s much more to `ng-model`, e.g. parsers and formatters that are handy when you want specific validations on inputs, etc.
To be updated when I write about it, subscribe in the form below!

{% render_partial _posts/_partials/book_cta.markdown %}
