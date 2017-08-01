---
layout: post
title: "$scope.$apply: What Is It Good For"
date: 2016-10-16 15:27:02 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 112785
---

Angular has a lot of magic going on.
It keeps track of all bindings and templates, and it seems like no matter what you throw at it, it will make sure that everything gets rendered and stays synced.

For a lot of us this binding magic is what initially pulled us to Angular.

But, of course, it’s *not really* magic, and you can come across situations where things stop working - exactly because Angular is no longer able to keep track of everything.

In those cases, the solution is almost always the `$scope.$apply()` function.
Let’s understand why it’s needed, when should you use, and how.

# The digest loop on one leg

Angular’s magic basically works by having a “heartbeat” - every time Angular sees something happened it goes over all your watchers and updates templates, syncs bounded properties, executes promises, etc.

The ability to know that something happened relies heavily on the assumption that you, the coder, won’t “step outside” of Angular’s sight.

Whenever changes happen as a result of something Angular-originated, we’re all good.
So if you use `ng-click` to update things, or `ng-model` to bind a value, run code after a `$timeout` or talk with the server using `$http`, you’re all good.

Notice how all of the above are Angular-specific?
That’s exactly why.

If you’ll use jQuery’s `ajax()` function instead of `$http`, you’ll see things stop working.
Same goes for listening to click events natively and not using `ng-click`, using `setTimeout`, and so on.

The price we have to pay in order to enjoy the magic, is to keep using Angular’s way of doing things.

# But you can’t always be inside the walled-garden of Angular

Even if you really want to, sometimes you have to do stuff another way.

The common cases are:

- Using a non-Angular widget/plugin: Like a data visualization using D3.  
	Just because it’s not using Angular doesn’t mean you don’t want to handle the events like clicks in your Angular components.
- Binding to events natively: Angular has handy directives like `ng-click`, `ng-focus`, etc.  
	But it doesn’t have a directive for *every* event type there is.
- `setTimeout` et al: In general [you should](http://www.codelord.net/2015/10/14/angular-nitpicking-differences-between-timeout-and-settimeout/) use `$timeout` and `$interval`.  
	But what if you’re using code that doesn’t know about them?  
	A common example is Lodash’s `_.debounce()` function–it uses `setTimeout` internally.
- Performance: Sometimes stepping outside of Angular is necessary.

# What it looks like if you don’t use $scope.$apply

Usually, if your codebase has one of the above situations and you don’t handle it properly, things will feel “lagged”.

That means that, for example, you’ll click on something and expect it to change something on the screen, but it won’t change until some time passes, or you click something else.

That’s because the changes you made actually happened in the data model, but Angular’s digest loop didn’t execute to update the templates.

Once something else triggers the digest, like a click that uses `ng-click` or a `$http` call being resolved in the background, things will render and you’ll finally see what you hoped to see in the first place.

# How to return to Angular’s supervision

It’s actually pretty easy.
You just need to make sure to perform your code inside a `$scope.$apply()` block.

For example, say that we have a native event handler for the `scroll` event:

```javascript
element.on('scroll', function () {
  $scope.$apply(function() {
    // Now we really do stuff, for example:
    updateNavigationState();
  });
});
```

It’s that simple.
Once you do this, Angular will execute the code in the function you pass `$apply` and then run a digest loop so your changes are propagated throughout the app.

There’s a slight catch here, though: You need to make sure to call `$apply` from *outside* of the Angular “zone”.
If you call `$apply` from within it, e.g. inside a function that gets called by `ng-click`, you’ll get an error.

This is one of the only remaining reasons to inject `$scope` into your controllers in modern Angular.

{% render_partial _posts/_partials/book_cta.markdown %}
