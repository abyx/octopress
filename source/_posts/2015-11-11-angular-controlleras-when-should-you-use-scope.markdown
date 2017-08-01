---
layout: post
title: "Angular controllerAs: When Should You Use Scope"
date: 2015-11-11 23:09:50 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
---

Angular 2 is getting closer and so controllers are getting [closer to death](http://www.codelord.net/2015/09/10/angular-2-migration-path-what-we-know/).

Using controllerAs syntax is the agreed way to prepare your code for the migration. But with all its awesomeness it makes some basic tasks tricky. Injecting `$scope` seems to be frowned upon.

> Should you never use `$scope` again?  
> What about broadcasting events?  
> Listening for changes with `$watch`?  
> In what situations should you use it?  

We’ll answer these questions in this post.

Recap: Previously I showed you [how to refactor](http://www.codelord.net/2015/09/30/angular-2-preparation-controller-code-smells/) your existing controllers to make them easier to migrate to components. Then [how to stop using them](http://www.codelord.net/2015/10/07/angular-2-preparation-killing-controllers/) entirely.

These changes all rely on the awesome [controllerAs syntax](http://toddmotto.com/digging-into-angulars-controller-as-syntax/) in Angular. This allows us to treat our directive controllers as objects and not use a 3rd party object, the scope, to pass along information.

Yet, scopes still have valid uses in the Angular world.

# `$watch`

Sometimes, though hopefully rarely, you gotta write a `$watch`. Prior to controllerAs you’d write: `$scope.$watch('foo', ...)` and access `$scope.foo`.

Now that properties are exposed on the controller, e.g. using `vm.foo = '123'`, this requires tweaking.

If our controller has a `foo` property and its controllerAs name is `vm` we can write: `$scope.$watch('vm.foo', ...)`. That *would* work.

But… *eww*. I find this aesthetically displeasing. Nothing in your controller’s code should be aware of the controllerAs name it’s got. That knowledge is usually only used in the template.

That’s why I prefer to write the slightly longer:    
`$scope.$watch(function() {return self.foo;}, ...)`  

This decouples the controllerAs name and the controller’s code.

# Events and broadcasting

Scopes come with the `$emit`, `$broadcast` and `$on` functions for interacting with events. Whenever you’re certain that events are the right tool for the job (which they usually aren’t) you should use this mechanism.

But, in a lot of situations there’s no need to use specific scopes with hierarchy for passing events. For example, if you want a generic PubSub event bus you can just use `$rootScope` alone across your system. I show a pattern for this [here](http://www.codelord.net/2015/05/04/angularjs-notifying-about-changes-from-services-to-controllers/).

# `$apply`

We have to call `$scope.$apply()` when running code in non-Angular contexts, like a jQuery plugin callback.

There’s no escaping this. If your code required `$apply` before moving to controllerAs you’re gonna have to keep doing it.

Like the previous point, though, you can just use the `$rootScope`. Calling `$apply` on any child scope has the same effect as calling it on the root scope. Using the `$rootScope` in these situations makes it clear that it is being used for something global.

# For anything else, don’t use scope

It’s that simple. Kick controllers' butt!

{% render_partial _posts/_partials/book_cta.markdown %}
