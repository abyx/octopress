---
layout: post
title: "Understanding Angular's &amp; Binding"
date: 2016-05-13 15:32:15 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Don't get tripped up - subscribe to get more posts and <b>really</b> understand Angular!"
cta_form: 52764
---

Angular has several cases where the syntax trips you up, or where it’s just not clear what should you use.
Most famously, there’s [services vs. factories](http://www.codelord.net/2015/04/28/angularjs-whats-the-difference-between-factory-and-service/) and [`ng-show` vs `ng-if`](http://www.codelord.net/2015/07/28/angular-performance-ng-show-vs-ng-if/).
More recently we now have [components vs. directives](http://www.codelord.net/2015/12/17/angulars-component-what-is-it-good-for/).

Another thing that I’ve seen people get mad about time after time is the `&` binding for passing functions to directives/components.
“The & callback binding trips me up EVERY TIME I just hate it.”

Let’s understand exactly what it is.
Once you grok it, you’ll never get it wrong again.

# Can you use it in a sentence?

First, here’s an example component that has one of these `&` bindings:

```javascript
angular.module('app').component('foo', {
  templateUrl: '...',
  bindings: {
    callback: '&'
  },
  controller: function() {
    // ...
    this.callback();
  }
});
```

As you can see, we have a simple binding called `callback`.
The usage of this component would look something like this:

`<foo callback="$ctrl.myCallback()"></foo>`

This means that whenever the `foo` directive would call the `callback` binding, the `myCallback` function on the caller’s controller would be triggered.

# The tricky bit: parameters

Now, what everyone get mixed up with is using `&` with functions that get parameters.

Say that our callback wants to pass an argument.
The component would be created like so:

`<foo callback="$ctrl.myCallback(value)"</foo>`

But inside the component, we calling syntax would look quite foreign the first time you see it:

`this.callback({value: 'whatever'});`

*WAT*

Yes.
Doing something like `this.callback('whatever')` wouldn’t work.

## What’s going on?

Technically speaking, when you use the `&` binding, Angular doesn’t just do 2-way binding the regular way.

It takes the expression you use, in our example `$ctrl.myCallback(value)` and saves it.

When you call it, Angular evaluates that expression *on the parent scope*.

You see, when using `&` you don’t have to pass function, though that’s what we do 99.9% of the time.
You can pass in any expression, and it would work.

So, in our example, we could have used:

`<foo callback="$ctrl.values.push(value)"></foo>`

And whenever we’d perform `this.callback({value: 'whatever'})` it would get appended to the parent controller’s `values` array.

Because the `&` binding is so generic, it doesn’t really have a notion of function parameters - the expression could be anything.

When you pass it the object, it is actually a mapping of *local variables to override*.
Angular takes the expression and evaluates it in the parent scope, but with the values you pass it added as the locals.

*Wiseass note*: Yes, this means we can call `this.callback({value: 'whatever', $ctrl: something})` and the function call would be performed on the `something` object and not on our parent controller - because we override it!

## Dear god, why?!

This was done so that you’ll be able to pass expressions instead of functions to anything in Angular.

Have you ever used `ng-click="$ctrl.value = true"` or something along those lines?
Sometimes it’s easier to not use a function.

The core team wanted us to have this flexibility, and the price is that we have to call function in a way that feels a bit clunky.

But *remember*: You’re not really calling a function, you’re evaluating the expression with those values!

## Now you know

If you’ll make the mental switch from treating `&` as “function binding” to just “expression binding”, I think you’ll be alright from now on.

{% render_partial _posts/_partials/cta.markdown %}
