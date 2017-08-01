---
layout: post
title: "Adding the first Angular 2 component to your Angular 1 app"
date: 2016-01-14 12:54:22 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 18090
---

In my [previous post](http://www.codelord.net/2016/01/07/adding-the-first-angular-2-service-to-your-angular-1-app/) we saw how easy it can be to add your first Angular 2 service to an existing Angular 1 app, using ES5.
This lets you easily have Angular 1 code live alongside Angular 2 code.

This time, let’s start dipping our toes in the real deal: adding your first *component*.

# What’s an Angular 2 component?

A component is a piece of logic (like Angular 1’s controllers) that’s coupled with a view.
It’s self contained and isolated.
And it can have bounded inputs and outputs.

Sounds familiar?
That’s basically Angular 1.5’s `.component` (see [here](http://www.codelord.net/2015/12/17/angulars-component-what-is-it-good-for/)).

# Setting things up

Set up takes a few minutes to add the Angular 2 dependencies and  create the upgrade adapter that wires everything together.
Follow the instructions from my [previous post](http://www.codelord.net/2016/01/07/adding-the-first-angular-2-service-to-your-angular-1-app/).

# Our shiny new component

We’ll start from a pretty basic component.
It will have a single input: that’s ng2 speak for a bounded property, except the binding is not two-way by default.

If we were to write this component in ng1 it would look something like this:

```javascript
angular.module('app').component('greeter', {
  bindings: {name: '='},
  template: '<span>Hello, {% raw %}{{greeter.name}}{% endraw %}!</span>'
});
```

Here it is in Angular 2 and ES5:

```javascript
var GreeterComponent = ng.core.
  Component({
    selector: 'greeter',
    template: '<span>Hello, {% raw %}{{name}}{% endraw %}!</span>',
    inputs: ['name']
  }).
  Class({
    constructor: function() {}
  });

 angular.module('app').directive(
    'greeter',
    upgradeAdapter.downgradeNg2Component(GreeterComponent));
```

# Breaking it down

It takes some more lines to write it, but this is essentially the same component we saw earlier.

In Angular 2 we provide a selector to components, but it’s actually not used when using it from Angular 1.
All that matters is the name we provide in the `.directive()` call.

Note that we’re defining the inputs, much like the `bindings` above.

# Using it from Angular 1

When using the upgrade adapter, we still have to use the new template syntax when using the component:

```html
<greeter [name]="name"></greeter>
```

Those brackets mean we’re setting up one way binding to pass the `name` parameter down to the component and it will be updated automatically whenever you change it in your Angular 1 code.

*That’s it!*

# Where to go from here

You can read more on the [upgrade guide](https://angular.io/docs/ts/latest/guide/upgrade.html), though it’s all in TypeScript for now.

There’s plenty more to go into here: the new template syntax, binding for changes (i.e. outputs), and more.

I’ll be covering more upgrade steps soon, sign up below to stay posted!

{% render_partial _posts/_partials/book_cta.markdown %}
