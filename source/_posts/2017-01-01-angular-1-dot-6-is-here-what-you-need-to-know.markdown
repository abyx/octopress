---
layout: post
title: "Angular 1.6 is here: what you need to know"
date: 2017-01-01 14:02:12 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 145927
---

Angular 1.6 was released a few weeks ago (and actually 1.6.1 was released a week ago).
I’m so happy to see the Angular team keep spending time in making 1.x better and improving it.

As opposed to 1.5, 1.6 doesn’t introduce a lot of new features or changes, which I think is a good thing.
I believe most 1.x projects have yet to integrate 1.5’s components properly, and so adding more changes might be overwhelming.

1.6 is more of a clean up release, that, in order to fix bugs and remove deprecations, introduces a handful of *breaking changes*.

I’ll go over the ones that I’m sure will trip a lot of people up.
You can see the full, really long, list [here](https://docs.angularjs.org/guide/migration#migrating-from-1-5-to-1-6).

# Controller pre-assignment of bindings–or $onInit all the things

1.6 changes the default behavior of `$compile` in that it no longer, by default, initializes a controller’s bindings before `$onInit` is called (the new lifecycle hook introduced in 1.5, you can read more about it [here](http://www.codelord.net/2015/12/17/angulars-component-what-is-it-good-for/)).

What does that mean?
Looking at this example:

```javascript
app.component('foo', {
  bindings: {
    baz: '<'
  },
  controller: function() {
    this.baz.something();
  }
});
```

The above code will no longer work, since we’re accessing the `baz` binding inside the controller’s constructor function directly.

To change it to work, you should make sure to move all of your controller’s initialization code to be inside the `$onInit` hook:

```javascript
app.component('foo', {
  bindings: {
    baz: '<'
  },
  controller: function() {
    this.$onInit = () => {
      this.baz.something();
    }
  }
});
```

Note: I’m using [ES6 arrow functions](http://www.codelord.net/2016/05/05/using-es6-arrow-functions-in-angular-1-dot-x-plus-cheatsheet/) for brevity.

In case you’ve already adopted your code to use `$onInit` you’re all good.
Also, since most style guides, e.g. John Papa’s, have recommended the use of an `init()` function of sorts in controllers for quite a while, I’m assuming for most projects this is not a big deal.
Simply rename your current `init()` functions to be `$onInit` methods.

## What if you don’t want to go over all controllers right now?

In case you don’t have the time or energy to change all your controllers now, but still want to upgrade to 1.6, you can re-enable the old behavior:

```javascript
app.config(function($compileProvider) {
  $compileProvider.preAssignBindingsEnabled(true);
});
```

But keep in mind that this is likely to be removed in a future version of Angular.  

## $onInit won’t work for standalone controllers

Standalone controllers are controllers that aren’t defined as part of a directive or component.
Most commonly, these are controllers used as part of route definitions, or, heaven forbid, `ng-controller`.

Standalone controllers do not get the lifecycle hooks, and don’t have bindings anyway, so just make sure not to accidentally try and update them too in your migration frenzy.
It won’t work.

# $http.success and $http.error are finally gone

I’m really hoping not a lot of people are still using these relics of older Angular days, but I keep coming across projects that use it here and there (I believe old blog posts all over the web are at fault, most people aren’t aware of the difference when just starting).

I’ve written about why [you shouldn’t be using them](http://www.codelord.net/2015/05/25/dont-use-$https-success/) almost 2 years ago, and they’ve since been deprecated.

Well, 1.6 has finally killed them.
If you’re still using them for some reason, here’s a great excuse to spend 20 minutes and use proper promises everywhere.

Upgrade and enjoy!

{% render_partial _posts/_partials/book_cta.markdown %}
