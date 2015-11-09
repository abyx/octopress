---
layout: post
title: "When Does a Directive's Link Function Get Called Again?"
date: 2015-09-16 17:56:46 +0300
comments: true
facebook:
    image: /images/posts_images/angular-rerun.png
---


If you’ve working with Angular for a while surely you’ve seen a directive’s `link` function being called more than once. I know that when I started it used to catch me off guard. I keep seeing developers puzzled, asking “why is it being re-run?”

While it is being executed several times (e.g. if you add a `console.log()` statement you see it print multiple lines) - it is not technically being *rerun*.

The link function is like a directive’s constructor. It is executed only once during the initialization process of the directive. There’s no way to get the link function to run again for the same instance of an already initialized directive.

If that’s the case, though, why are you seeing it run multiple times?

Well, it is not *re*running. It’s running as part of the initialization of a whole new directive. It means that you are destroying and recreating your directives, and whenever a directive is being initialized we’ll see its `link` function run.

# Why are your directives being recreated?

There are several possible reasons, but the most common ones are:

* using `ng-if` which can destroy the element and recreate it ([unlike ng-show](http://www.codelord.net/2015/07/28/angular-performance-ng-show-vs-ng-if/)).
* Using `ng-repeat` where each item contains a directive. If you don’t [set it up correctly](http://www.codelord.net/2014/04/15/improving-ng-repeat-performance-with-track-by/) `ng-repeat` can be a bit wasteful with recreating elements.

# Is this a problem?

Not necessarily. Make sure your code doesn’t assume that a certain directive will be created only once.

This might become a problem if those initializations are on the heavy side and having them run multiple times starts causing a performance issue. Just be on the look out for your [app getting slow](http://www.codelord.net/2015/08/03/angular-performance-diagnosis-101/) and you should be all right.

{% render_partial _posts/_partials/cta.markdown %}
