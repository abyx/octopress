---
layout: post
title: "Circular Dependencies in Angular and the Injector Service"
date: 2016-11-10 22:05:50 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to make your Angular 1 app modern, step by step!"
cta_form: 123714
---

Angular’s dependency injection is a great boon to productivity, but even it has its limits.

While not an everyday occurrence, it is quite possible to come across a *circular dependency*.
This happens when service A injects service B, but service B in turn injects service A, usually indirectly.
For example, B depends on service C which depends on A - `A -> B -> C -> A` forms a nice little circle.

When Angular’s bootstrap process tries to setup all the services and inject each service’s dependencies, it detects when such a scenario happens and errors out, instead of getting stuck in an infinite loop.

In most cases, circular dependencies are code smells for design that could be made clearer.
Most likely you have a service that’s gotten too big, and splitting it will result in cleaner code and no circular dependency.

But, there are a few common scenarios that come up in a lot of apps where some kind of circular dependency makes sense.
Let’s look at an example and a solution.

# A real-world circular dependency

Enter *[HTTP interceptors](https://docs.angularjs.org/api/ng/service/$http#interceptors)*.
Interceptors are Angular’s very handy tool for handling cross-app concerns when it comes to handling HTTP requests and responses.
They are probably most often used for [handling authentication](http://www.codelord.net/2015/10/22/angular-authentication-3-step-recipe/).

I’ve come across circular dependencies showing up in interceptors at several clients.
It usually goes something like this:

As part of implementing the authentication mechanism of the app, we create an interceptor to be in charge of handling the different responses.
One of the behaviors it needs depends on an external service, which in turn makes an HTTP request.

For example, we would like to redirect the user to a login page on every 401 error.
An interceptor watches for these errors, and once it sees them it calls our `AuthService` to tell it to handle an expired session.
The same `AuthService` depends on `$http` for some reason, like performing a login request.

A naive setup would look somewhat like this:

```javascript
appModule.factory('AuthService', function($http) {
  return {
    login: function(user, password) {
      // This uses $http to login
    },
    handleExpiredSession: function() {
      // Redirect to login page
    }
  };
});
```
	
```javascript
appModule.config(function($httpProvider) {
  $httpProvider.interceptors.push(function(AuthService) {
    return {
      response: function(response) {
        // Detect and handle 401 errors
      }
    };
  });
});
```

If you’ll try running an app with this code, Angular will spit out an error: `Error: [$injector:cdep] Circular dependency found: $http <- AuthService <- $http`.

That’s because `$http` depends on our interceptor, which depends on `AuthService`, which depends on `$http`.
*(Are you getting dizzy, too?)*

## $injector to the rescue

Just for cases like these Angular provides us with the `$injector` service.
The injector is the programmatic way to access Angular’s dependency injection.

Using it, we can manually inject `AuthService` inside our interceptor and break the circular dependency:

```javascript
appModule.config(function($httpProvider) {
  $httpProvider.interceptors.push(function($injector) {
    return {
      response: function(response) {
        // Detect and handle 401 errors
        $injector.get('AuthService').handleExpiredSession();
      }
    };
  });
});
```

Calling `$injector.get('AuthService')` will return the exact same singleton instance of `AuthService`.
The main difference is that now we are performing this at a later point, after Angular has finished bootstrapping the project.
At this point in time, where everything is up and running, it’s safe to inject `AuthService`.

Thus we have effectively broken out of the circular dependency.

Voila!

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
