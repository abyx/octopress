---
layout: post
title: "Adding the first Angular 2 service to your Angular 1 app"
date: 2016-01-07 12:26:53 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 16700
---

The Angular 2 beta was released a couple of weeks ago.  
We all want to be in the loop and not have our projects stay behind and become outdated.  
You know that you should probably spend more time learning about ng2 and what that means for your project.

And Angular 2 comes with a huge set of new technologies to learn and problems to solve:

> *Should you migrate your project to ES6?*  
> *Should you migrate it to TypeScript?*  
> *What is the right way to address such a big move, if at all?*

Well, we can’t answer all these questions in one post.
For today, let’s look into adding your first Angular 2 service into your existing Angular 1 app.

## Wait, what about all the rest?

You want to know what language should you use.
And whether or not you should migrate your old code.
And why are we starting with a service instead of something more sexy like a component, with a view and all?

*Slow your roll*.
Starting with a service is a great way to take one baby step towards Angular 2.
We don’t want to take on more than we can handle.

If you’re interested in getting these questions answered, now is a great time to subscribe to my newsletter and get the next parts!

{% render_partial _posts/_partials/cta.markdown %}

# The service we will be replacing

Say that you just got a task to introduce a new service.
The service is responsible for fetching some REST objects and returning them.

If we were to do it in Angular 1, it would probably look like this:

```javascript
module.factory('FooService', function($http) {
  return {
    getFoo: function() {
      return $http.get('/foos').then(
        function(response) {
          return response.data;
        }
      );
    }
  };
});
```

That’s quite a straightforward service, right?

# Adding Angular 2 to your existing project

*Note about using ES5:* Because we’re using ES5 and not ES6/TypeScript, some code needs extra boilerplate.
It’s not that bad actually, and I’m sure you’ll be able to follow along.
But I won’t be explaining every single character today (deep dives will be posted in the future, stay tuned!).

## Bye bye ng-app

In case your app is currently bootstrapped using the `ng-app` directive, you need to change it.
Angular can be bootstrapped with either `ng-app` or the manual way of calling `bootstrap` yourself.
In Angular 2 we have to use the latter.

If you have `<body ng-app="app">` you’ll need to remove the `ng-app` bit and add this to JavaScript code:

```javascript
angular.element(document.body).ready(function() {
  angular.bootstrap(document.body, ['app']);
});
```

This is actually a pure refactoring, nothing should have changed by this point - refresh to make sure!

## Adding the source files

Now we’ll need to grab Angular 2, and its dependency Rx.js, to include them in our project.

Get them however you usually get dependencies.
With npm it would look like this:

`npm install angular2@2.0.0-beta.0 rxjs@5.0.0-beta.0`

And then add this to your `index.html` file:

```html
<script src="node_modules/rxjs/bundles/Rx.umd.js"></script>
<script src="node_modules/angular2/bundles/angular2-polyfills.js"></script>
<script src="node_modules/angular2/bundles/angular2-all.umd.dev.js"></script>
```

## Introducing UpgradeAdapter

When I wrote about the [Angular 2 migration path](http://codelord.net/2015/09/10/angular-2-migration-path-what-we-know/), I mentioned the ngUpgrade library which will be used to supply us with the ability to run Angular 1 code side by side with Angular 2 code.

With time this has basically become the `UpgradeAdapter` you can find in Angular 2.

We will create an instance of this adapter and use it to bootstrap our app.
This initializes our app as a hybrid app that can use both Angulars.

Let’s change the bootstrap code from above to look like this:

```javascript
var upgradeAdapter = new ng.upgrade.UpgradeAdapter();
angular.element(document.body).ready(function() {
  upgradeAdapter.bootstrap(document.body, ['app']);
});
```

*Tip:* you’re used to using `angular.` for accessing Angular 1 stuff.
Angular 2 exposes all of its shiny stuff under the `ng` global.

That’s it, we’ve successfully included Angular 2 in our app.
Refresh to make sure everything looks ok!

# Writing our new service

In Angular 2 services are essentially just plain classes.
Because ES5 doesn’t have classes really, we’ll use the nice wrapper Angular 2 supplies us with:

```javascript
upgradeAdapter.addProvider(ng.http.HTTP_PROVIDERS); // 1

var FooService = ng.core.
  Injectable().
  Class({
    constructor: [ng.http.Http, function(http) { // 2
      this.http = http;
    }],
    getFoo: function() {
      return this.http.get('/foos').map(
        function(res) { return res.json(); }
      ).toPromise(); // 3
    }
  });
```

This might take a bit of getting used to.

First, at (1), we tell the upgrade provider what kind of Angular 2 dependencies our app requires.
In this case it’s the HTTP library.

Then in (2) we define our service’s class and inject it the `Http` instance.
This is a bit like injecting `$http` in Angular 1, except we provide the actual constructor/type of our dependency, not just a name.

And finally we just execute the AJAX request, similar to Angular 1.
Note that Angular 2 works with Observables instead of promises, but observables have a `toPromise()` method that we use (3) in order to supply the same interface to our Angular 1 code.

# Using our new service in Angular 1 code

First, let’s expose this service to our Angular 1 code:

```javascript
upgradeAdapter.addProvider(FooService);
angular.module('app').factory(
  'FooService',
  upgradeAdapter.downgradeNg2Provider(FooService));
```

And now we can use this service as we would use any other service:

```javascript
angular.module('app').component('foo', {
  templateUrl: 'foo.html',
  controller: function(FooService) {
    var vm = this;
    FooService.getFoo().then(
      function(foos) {
        vm.foos = foos;
      }
    );
  }
});
```

# Victory!

Yeah, that’s it.
You have a new skill and just added your first real Angular 2 code to your existing app.

Yes, there’s plenty more to do.
You might want to use components.
Or use Angular 1 code inside your Angular 2 code.
Or write your new stuff in TypeScript.

We’ll get there.
Be sure to sign up below to get it :)

For now, you can take read the [official upgrade guide](https://angular.io/docs/ts/latest/guide/upgrade.html) (TypeScript only), and Dave Ceddia's [great blog](https://daveceddia.com/angular-2-in-plain-js/).

{% render_partial _posts/_partials/cta.markdown %}
