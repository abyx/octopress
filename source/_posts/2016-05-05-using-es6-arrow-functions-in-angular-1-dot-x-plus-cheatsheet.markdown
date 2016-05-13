---
layout: post
title: "Using ES6 Arrow Functions in Angular 1.x + Cheatsheet"
date: 2016-05-05 12:34:14 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Get the cheatsheet and learn how to use arrow functions to write less code!"
cta_form: 49846
---

ES6 is becoming more and more popular among the JS crowd.
I’m guessing that the first feature anyone that moves to ES6 starts using is [arrow functions](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Functions/Arrow_functions).
And the recently released Angular 1.5 introduced support for injecting dependencies into arrow functions.
Unfortunately this support added a couple of nice pitfalls for newcomers that are important to understand and avoid.

# Quick background on arrow functions

In case you’re not familiar with these, they basically look like this:

```javascript
(arg1, arg2) => {
  return arg1 + arg2;
}
```

Which, unsurprisingly, maps to:

```javascript
function(arg1, arg2) {
  return arg1 + arg2;
}
```

*Note:* There’s a lot more syntax sugar that makes these awesome, like `array.map(x => x.name)`.
They can really save up on some typing and make code cleraer.
Get the cheat sheet at the bottom of this post for the full list!

An important feature of arrow functions is that they bind the `this` value.

Most JS developers are well versed in the practice of keeping a reference to your “real” `this` value, e.g. `var self = this` or `var vm = this`.
This is because every function you then declare inside the object might have a different `this` value assigned to it at runtime, which makes for very fun bugs.

Arrow functions do this for you behind the scenes, so that inside an arrow function you can freely use `this` and it’ll be the same `this` as in its parent scope.

# The pitfalls

I like arrow functions very much.
First, because they mean I need to type less, which is always a good thing.
But mainly because using arrow functions means I don’t need to declare a `self` var anymore or think about what `this` means as often.

The main problem is when people assume they can just start using arrow functions everywhere, and say goodbye to the regular syntax.
But that’s not the case.

**Arrow functions should never be used for constructor functions.**

They are always anonymous and have no `prototype`, which means they are not `new`able.
And of course using them as constructors is wrong since a constructor should not be using its parent scope’s `this` value.

# The Angular-Arrow function rule of thumb

The most common constructor functions in Angular are controllers and services.

So, to be safe, never use arrow functions in `module.service('Service', ...)` calls and not when passing a controller function as `controller: ...` when defining components/directives/etc. (and also not in `module.controller()` calls, but you should hopefully [not have any more of these](http://www.codelord.net/2015/10/07/angular-2-preparation-killing-controllers/)).

Personally, I don’t like it when all my files don’t look the same, and I prefer my style guide to reduce thinking.

Because of that I simply recommend to not use arrow functions as  the function parameter to any `module.something()` call (where `something` can be `service`, `factory`, `directive`, `run`, etc.) and never when passing a `controller` function.

Happy arrowing!

{% render_partial _posts/_partials/cta.markdown %}
