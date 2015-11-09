---
layout: post
title: "Angular Authentication: Remember Where You Were + Demo Project"
date: 2015-10-29 17:53:57 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Get the next authentication guides, prepare for 2.0 and write maintainble Angular!"
---

In my [last post](http://www.codelord.net/2015/10/22/angular-authentication-3-step-recipe/) we saw the simple 3 step recipe for adding basic authentication in your Angular app.

This time let’s see how to get a very common feature to work: **taking the user back to where he was** before his session expired and he had to login again.

We all know that it sucks to suddenly get logged out and have to dig through lots of tabs to find the right page again. It turns out that getting something like this to work with Angular takes only a handful of code changes. But, it’s a bit tricky, so pay attention:

# Background

We’re continuing off the previous [post](http://www.codelord.net/2015/10/22/angular-authentication-3-step-recipe/). This means that we already have an interceptor that redirects to the login page whenever a request fails with status 401.

# Our Modus Operandi

You’ve seen apps where the login URL looks something like: `foo.com/login?url=%2Fsome-page` and similar. And we’ll be using something very similar. 

Whenever our interceptor would transition to the login page it would first grab the current URL and pass it as a parameter to the login state. Our login state, upon success, will redirect to that URL.

## The Interceptor

```javascript
angular.module('app').factory('AuthInterceptor',
function($injector, $location, $q) {
  return {
    responseError: function(rejection) {
      if (rejection.status === 401
       && rejection.config.url !== '/login') {
        var $state = $injector.get('$state');
        // This is the interesting bit:
        $state.go('login', {url: $location.url()});
      }
      return $q.reject(rejection);
    }
  };
});
```

As previously, it just listens for 401 responses and redirects to the login state. The important bit is that we take the current URL using `$location.url()` and pass it as a parameter to the login state.

## Login State Logic

When the user clicks the login button we perform something like this:

```javascript
vm.submit = function() {
  $http.post('/login',
       {user: vm.user, password: vm.password})
       .then(function() {
    if ($stateParams.url) {
      $location.url($stateParams.url);
    } else {
      $state.go('home');
    }
  });
};
```

Now you can see that we’re simply using that state parameter, when it’s present, to move to it.

The important part is to make sure that you encode the state of your pages in the URL. *That's it!*

# The live demo

You can see the live demo [here](http://abyx.github.io/angular-basic-authentication-skeleton/) and its source code is available [here](https://github.com/abyx/angular-basic-authentication-skeleton).

It’s a simple app with a couple of screens. Each screen has a button on the top to let you simulate a session expiring - it will cause a 401 to be returned which will then redirect you to the login page. You can see how after submitting the login you get right back where you were - even with URL parameters.

# What if the URL isn’t enough?

Sometimes, though rarely in my experience, you want to restore the state with more than just the URL. For example, maybe the user has started typing something that you want to save.

In those scenarios I usually go with using a service to store the objects that I need. Then, when our interceptor redirects to the login page it can first shout out an event. Whatever page is currently displayed can catch the event and persist the state. See [my post](http://www.codelord.net/2015/05/04/angularjs-notifying-about-changes-from-services-to-controllers/) about notifying changes.

Since the last post I got several requests to discuss more features, like admin only pages, etc. Subscribe below so you won’t miss them and feel free to comment if you have other ideas I should add to the mix!

{% render_partial _posts/_partials/cta.markdown %}
