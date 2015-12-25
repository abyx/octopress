---
layout: post
title: "Configuring components with ui-router and ngRoute"
date: 2015-12-25 10:35:53 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Always be in the loop for new updates to Angular and get guides for painless upgrading!"
---

Angular 1.5’s upcoming `.component()` method is going to be very cool, as I wrote about [previously](http://www.codelord.net/2015/12/17/angulars-component-what-is-it-good-for/).
And in general the migration path to Angular 2 recommends that we all [stop using controllers](http://www.codelord.net/2015/10/07/angular-2-preparation-killing-controllers/) in favor of directives/components (for the rest of the post I’ll talk about components, but it should be obvious every component is a directive).

A lot of us are used to using controllers as the route-level objects.
Each route has a controller that’s responsible for that specific route, and comes with its own template, etc.

This was comfortable since both ui-router and ngRoute allow us to easily set a controller that handles a route and inject it with dependencies using `resolve`.

Achieving the same with components isn’t as straightforward, but doable.
Note: You might be thinking otherwise, but *yes*, components *should* be used for things that aren’t reusable, like handling a specific route.

# ngRoute

Though I usually find ngRoute inferior to ui-router, in this case it’s nicer.
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

The beloved ui-router doesn’t really support exposing resolved dependencies except to the controller of the state.
The maintainers mentioned this might be addressed in the upcoming 1.0 version of ui-router.

Yes, it’s possible to [hack things around](https://github.com/angular-ui/ui-router/issues/2323#issuecomment-150072343) in order to get access to this internal state.
But that’s something I find dangerous and not very robust.

And so, our only pragmatic solution, for now, is to live with some boilerplate:

```javascript
myMod.config(function($stateProvider) {
  $stateProvider.state('inbox', {
    url: '/inbox',
    template: '<inbox mails="mails"></inbox>',
    resolve: {mails: function(Mails) {return Mails.fetch(); }},

    controller: function($scope, mails) {
      $scope.mails = mails;
    }
  });
});
```

Yes.
Not exactly the prettiest piece of code I’ve ever written.
But, it gets the job done and allows us to rid ourselves of controllers and get onboard the component train.
*Choo-choo!*

{% render_partial _posts/_partials/cta.markdown %}
