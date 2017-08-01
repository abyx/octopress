---
layout: post
title: "Configuring components with ui-router and ngRoute"
date: 2016-10-25 10:35:53 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
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

{% render_partial _posts/_partials/book_cta.markdown %}
