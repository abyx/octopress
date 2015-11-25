---
layout: post
title: "The Deal With Angular And Minification"
date: 2015-11-18 16:26:03 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Get the next guides: learn to write Angular the right way and be ready for 2.0!"
---

Angular and minification (or “minifying” or “uglifying”) might seem like they don’t play well at first. First impressions are usually quite negative:

> “It turns out that Angular dependency injections has problems if you minify your javascript code”  
> “I’ve read that uglifying can break Angular dependency injection”  
> “Can someone explain why the special syntax helps not screw it up?”  
> “Should I use `$inject` or wrap things in an array? Do it manually or use a tool?”

Truth is that by understanding how minification was meant to work with Angular you can set it up very quickly.

# What’s minification

For years javascript developers have been using tools that obfuscate/minify their code. The reasons are usually a combination of wanting to reduce download size and preferring not to expose your code plainly for the entire world to see.

Minification usually involves renaming things to be shorter. So that this:

```javascript
app.factory('Foo', function($http, $timeout, Something) {
  // ...
});
```

Becomes this:

```javascript
p.factory('Foo', function(a, b, c) {
  // ...
});
```

# Why minification messes with Angular

Angular’s dependency injection, by default, works by looking at the function’s argument names to determine what it should be injected with. Once minification mangles those names, Angular no longer knows what the function wanted. *Sad trombone*.

# Special syntax for preventing this

You’ve probably come across at least one of the two possible ways to work around the minification problem.

The first is to wrap every injectable in an array that also names the different dependencies. For example:

```javascript
app.factory('Foo', ['$http', '$timeout', 'Something',
            function($http, $timeout, Something) {
  // ...
});
```

This works anywhere that you’d pass in an injectable to Angular (e.g. controllers, directives, etc.).

Another way is by adding a `$inject` property to the injectable:

```javascript
function Foo($http, $timeout, Something) {
  // ...
}
Foo.$inject = ['$http', '$timeout', 'Something'];
app.facory('Foo', Foo);
```

Both of these ways work because they encode the dependencies as strings, which are not changed by the minification process.

# But don’t write this by hand like an animal

Yes, you can start rewriting your code to use the explicit syntax. But it’s error prone to copy this around, a glaring DRY violation and just tedious & boring.

If you have minification it means you already have some sort of build process in order.

In that case, it’s usually dead simple to add another step to the build process that automatically adds the explicit syntax to your code. *Never waste a keypress.*

The de-facto standard is to use [ng-annotate](https://github.com/olov/ng-annotate). It's a very simple tool that you can just drop in as part of your build process, right before minification. It essentially just goes over your Angular code and rewrites it to have the explicit dependency injection syntax. Check out the project page for information and examples.

Voila. Configuring ng-annotate (which usually means copying 5 lines to your build file) will save you time and make your project minification-ready. w00t!

{% render_partial _posts/_partials/cta.markdown %}
