---
layout: post
title: "Prevent AngularJS Injection Errors With Strict Mode"
date: 2017-06-25 22:48:27 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Subscribe to get the latest about modern Angular 1.x"
cta_form: 229910
---

I have to say that some of the most annoying production bugs I’ve encountered with AngularJS apps are the injection errors: `Unknown provider: tProvider <- t`.
That error message is actually Angular trying to tell us that it doesn’t know where to inject `t` from, yet of course my code doesn’t have an injectable dependency called `t`.

These errors almost never show up during development, but only after building the app for release.
That’s because these problems are the result of [minification](http://www.codelord.net/2015/11/18/the-deal-with-angular-and-minification/), which usually isn’t setup to run during development (for easier debugging and faster build times).

In most online examples we’d simply write an injectable like so:

```javascript
app.factory('Foo', function($http) {
  // Angular will inject $http
});
```

But, after minification Angular won’t be able to tell what to inject because argument names get mangled.
That’s why Angular has its special injection annotations, e.g.:

```javascript
app.factory('Foo', ['$http', function($http) { ... }]);
```

Or:

```javascript
function Foo($http) {}
Foo.$inject = ['$http'];
```

These are of course a PITA to maintain, which is why I strongly recommend using an automatic took like [babel-plugin-angularjs-annotate](http://www.codelord.net/2017/06/18/ng-annotate-deprecated-what-that-means-for-your-projects/).
But even when using it, one can forgot to write the `'ngInject';` directive somewhere.

In those scenarios, you’d normally only understand that there’s a problem in production, which is too late (and if you’re testing properly, it just means you’re pushing bugs too late into your development process anyway).

# The Solution: Strict Mode

Strict mode is a configuration of Angular’s `$injector`, telling it not to accept injectables that aren’t annotated, even when running in development.
(Note, this should not be confused with [ES5’s strict mode](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Strict_mode).)

You set it by adding the [`ng-strict-di`](https://docs.angularjs.org/api/ng/directive/ngApp#usage) attribute to your `ng-app` element:

```html
<body ng-app="app" ng-strict-di>
```

When you turn this switch on, AngularJS will throw an error whenever it encounters an injectable that’s missing proper annotations, *even in development*.
This means you’ll get a clearer error that’s a lot easier to track down and at the right time.
It does mean, though, that you should make sure to run your automatic annotator in development as well (which should be easy with babel-plugin-angularjs-annotate).

Switch strict mode on and save yourself some nasty debugging!

<hr>

You want to do Angular *the right way*.  
You hate spending time working on a project, only to find it's completely wrong a month later.  
But, as you try to get things right, you end up staring at the blinking cursor in your IDE, not sure what to type.  
Every line of code you write means making decisions, and it's paralyzing.  

You look at blog posts, tutorials, videos, but each is a bit different.  
Now you need to *reverse engineer every advice* to see what version of Angular it was written for, how updated it is, and whether it fits the current way of doing things.

What if you knew the *Angular Way* of doing things?  
Imagine knocking down your tasks and spending your brain cycles on your product's core.  
Wouldn't it be nice to know Angular like a second language?

You can write modern, clean and future-ready Angular right now.  
Sign up below and get more of these helpful posts, free!  
Always up to date and I've already done all the research for you.

And be the first the hear about my Modern Angular 1.x book - writing future proof Angular right now.

{% render_partial _posts/_partials/cta.markdown %}
