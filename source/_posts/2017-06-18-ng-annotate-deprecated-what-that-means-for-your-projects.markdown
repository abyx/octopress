---
layout: post
title: "ng-annotate Deprecated: What That Means for Your Projects"
date: 2017-06-18 18:31:00 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 226955
---

For several years, the handy [ng-annotate](https://github.com/olov/ng-annotate) has helped save countless developers hours and debugging sessions, by automatically inserting Angular’s [dependency injection annotations](http://www.codelord.net/2015/11/18/the-deal-with-angular-and-minification/) to code instead of developers having to maintain them by hand.

But, alas, it has been [deprecated](https://github.com/olov/ng-annotate/issues/245).
Read on to understand what that means for your projects currently using it.

# You Don’t Need to Type Annotations by Hand

Just because ng-annotate is deprecated it doesn’t mean it’s going to stop working.
If it’s working for you right now, you can keep using that version and things should work as they have.

But, the “official” successor of ng-annotate is [babel-plugin-angularjs-annotate](https://github.com/schmod/babel-plugin-angularjs-annotate) (BPAA).

BPAA is actually a fork of ng-annotate that has been around for a while.
While ng-annotate operated on JS source files, and had to be passed ES6 code after transpilation, BPAA is a Babel plugin and so operates as part of the transpilation process, and in a relatively transparent manner.

Given a build process/toolchain that’s already set up to use Babel, adding BPAA is often easier than adding ng-annotate.
How much easier?
You can follow the README I linked to above, but it generally boils down to a single NPM dependency and modifying a single line in your Babel configuration.

Since ng-annotate will no longer be maintained, I recommend switching to BPAA once you get the chance (nothing urgent though).
I went through this process at a recent client and it was fairly simple and took less than an hour.

It also seems that BPAA is faster than ng-annotate, which makes for faster build times, that’s a small win.

# Implicit Detection Considered Harmful

As part of the deprecation, the maintainers of both ng-annotate and BPAA agreed that implicit annotation detection is a bad practice and should be avoided.

What’s does that mean?
Implicit detection means that the tools try and understand from the code whenever an Angular injectable is being declared and automatically insert annotations for it as needed, without any manual steps necessary by developers.

The maintainers talk about implicit detection causing a lot of problems, and recommend running BPAA with the `explicitOnly` setting.
That setting means that you will need to markup class constructors like so:

```javascript
class SomeCtrl {
  constructor($http) {
     'ngInject'; // <-- BPAA looks for this
    // ...
  }
}
```

And same goes for injectable functions:

```javascript
angular.module('app').config(function($httpProvider) {
  'ngInject';
 
  // ...
});
```

This might seem weird if this is the first time you come across explicit mark up, but it’s easy enough and, along with [strict-di](https://docs.angularjs.org/error/$injector/strictdi), makes it impossible to come across injection bugs in runtime.
While it would’ve been great if these explicit markers weren’t necessary, but since in most projects there’s at least one use case where they’re required I can see the logic of choosing the explicit route for safety.

# “But I’m Not Using ES6!”

Well, surprisingly enough, you can incorporate Babel into your build process with BPAA as described above, to replace your existing ng-annotate step.

Babel doesn’t _have_ to transpile ES6.
If you don’t provide it with an ES6 (or ES2015, or whatever) preset, and just configure the BPAA plugin, Babel can be used instead of ng-annotate.

Open source sometimes moves fast, but the important point is that there’s a clear and relatively easy way to start using the supported tool (BPAA), and keep saving countless bugs and keystrokes! 

{% render_partial _posts/_partials/book_cta.markdown %}
