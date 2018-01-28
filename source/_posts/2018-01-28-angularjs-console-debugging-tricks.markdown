---
layout: post
title: "AngularJS Console Debugging Tricks"
date: 2018-01-28 18:10:47 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 332471
---

You’re working on a new feature, or trying to track down a bug.
Something’s just not working as you expect it to be, what do you do?

Usually, I just add `console.log` as necessary, or add breakpoints.
But, sometimes, I want to look at data as it currently is, without triggering a refresh.

In those situations, I *love* using AngularJS’s helpers that make a lot of the needed information available right in the browser’s console.

# Set up

First, pick the relevant element in Chrome/Safari’s developer tools - either right-click and “Inspect Element”, or pick it on the elements panel.

On these browsers (maybe others as well, but I rarely develop on them), the element you have currently selected is available in the console using the `$0` variable.

And now, you can get access to the AngularJS element by writing `angular.elemen($0)`.

While you may know this as the jqLite interface, it has some handy utilities for debugging.

# Debugging with angular.element

## `.scope()`

This function returns the Scope that’s associated with this element.
*Super* handy for poking around to see that all the values are set up as you expect.
You can also make changes to values on the scope, or call functions, but in those scenarios it’s recommended to follow up by running `angular.element($0).scope().$apply()`, to make sure your changes are properly applied.

A nitpick detail is that in some cases you might want to call `.isolateScope()` instead, see [the docs](https://docs.angularjs.org/api/ng/function/angular.element#methods).

## `.controller()`
Similarly, this returns the controller that’s associated with the current element.
In the rare case that an element has multiple controllers and you’re interested in a specific one, e.g. `ngModel`, you can pass the function the name of the controller that you want.

Now with components, where you should be rarely exposing data directly on the scope, accessing the controller is nice, though this is usually synonym with `angular.element($0).scope().$ctrl`.

## `.injector()`

This is especially handy for the heavier debugging sessions, where you’re knee-deep in chaos.

In those scenarios, sometimes you need to resort to calling all sorts of services on your own directly from the console, and `injector` enables just that.

For example, if your app has a `UsersService`, you can get a reference to it using `angular.element($0).injector().get('UsersService')`.

Happy debugging!

{% render_partial _posts/_partials/book_cta.markdown %}
