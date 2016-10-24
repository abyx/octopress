---
layout: post
title: "Configuring components with ui-router and ngRoute"
date: 2016-10-25 10:35:53 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 116225
---

Angular 1.5’s `.component()` method is very cool, as I wrote about [previously](http://www.codelord.net/2015/12/17/angulars-component-what-is-it-good-for/).
And in general the migration path to Angular 2 recommends that we all [stop using controllers](http://www.codelord.net/2015/10/07/angular-2-preparation-killing-controllers/) in favor of components.

A lot of us are used to using controllers as the route-level objects.
Each route has a controller that’s responsible for that specific route, and comes with its own template, etc.

This was comfortable since both ui-router and ngRoute allow us to easily set a controller that handles a route and inject it with dependencies using `resolve`.

Achieving the same with components isn’t as straightforward, but doable.
Note: You might be thinking otherwise, but *yes*, components *should* be used for things that aren’t reusable, like handling a specific route.
They should actually be used by default for anything that's not a service in your app.

# ngRoute

Say that we’ve got this component:

```javascript
myMod.component('inbox', {
  templateUrl: 'inbox.component.html',
  bindings: {mails: '='},
  controller: function() {...}
});
```

Passing it the `mails` dependency using `resolve` is pretty simple:

```javascript
myMod.config(function($routeProvider) {
  $routeProvider.when('/inbox', {
    template: '<inbox mails="$resolve.mails"></inbox>',
    resolve: {mails: function(Mails) { return Mails.fetch(); }}
  });
});
```

Yes, ngRoute has a handy `$resolve` property exposed on the scope by default, which saves us some keystrokes and boilerplate in this case.

# ui-router

While the upcoming 1.0 release will handle components in a cleaner way, the above solution is available to us since version 0.3:

```javascript
myMod.config(function($stateProvider) {
  $stateProvider.state('inbox', {
    url: '/inbox',
    template: '<inbox mails="$resolve.mails"></inbox>',
    resolve: {mails: function(Mails) {return Mails.fetch(); }}
  });
});
```

Yes, that's eerily similar to the ngRoute way.
Now we get rid ourselves of controllers and get onboard the component train.
*Choo-choo!*

<hr>

Do you have an existing Angular 1.x app that makes you worried about its future?  
You don't want your app to be *left behind* and become *legacy code*.  
But it's not easy clearing the time to learn Angular 2.  
And who has the energy to convince management that you need to change frameworks, delay your schedules and do the Big Ol' Rewrite?

But what if you could make sure your app keeps its options open?  
What if you could make it future-proof, all the while *shipping features like a boss*?  
You'll work in a codebase that uses the latest and greatest, have easy maintenance and happy stakeholders!

The *Future-proof Angular Guide* can help you get there.  
With this no-fluff course you'll learn how to quickly adapt your existing Angular 1.x app to the latest components paradigm, as you go about your regular work.  
You'll gradually turn your app into something that is modern and idiomatic, converting directives and getting rid of controllers.  
And then, once your app is shaped The Right Way™, you'll be able to keep shipping like a boss, and have your options open.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
