---
layout: post
title: "AngularJS: Pitfalls using ui-router's resolve"
date: 2015-06-02 23:53:55 +0300
comments: true
---

If you've been doing Angular any amount of time, I hope you've found and started using the great [ui-router](https://github.com/angular-ui/ui-router) library. It truly helps when building anything that's larger than a simple project.

A really useful feature is **resolves**. It is ui-router's way of letting us provide values to the different controllers it manages, in a way that makes them simpler - it hides asynchronous operations and so controllers are more linear.

For example, a controller that needs a specific goat might be written like so with vanilla Angular:

```javascript
angular.module('app').controller('GoatCtrl', function(GoatService) {
    var self = this;
    GoatService.getGoat().then(function(goat) {
        self.goat = goat;
    });
}); 
```

But if this is a controller of a route defined by ui-router, we can use a `resolve` to hide the promise from it:

```javascript
angular.module('app').config(function($stateProvider) {
    $stateProvider.state('goat', {
        url: '/goat',
        controller: 'GoatCtrl as goatCtrl',
        templateUrl: 'goat.html',
        resolve: {
            goat: function(GoatService) {
                return GoatService.getGoat();
            }
        }
    });
});

angular.module('app').controller('GoatCtrl', function(goat) {
    this.goat = goat;
});
```

The benefits, I assume, are clear: *cleaner* controllers, especially if you have multiple things that need fetching and less meddling with asynchronous code and promises.

But, as always, there are pitfalls and use cases where this solution comes short that you should be aware of in order to make the right decision.

## The pitfalls

### Might feel slow/laggy/stuck

You've had this happen to you many times (probably earlier today): you press a button which triggers a route change. If that route has a resolve that takes a few seconds to complete, you won't get any feedback about anything happening until the resolves are resolved. This can be frustrating, making you wonder *did I click it?* Perhaps you'll click again *just to make sure*. 

In a resolve-less state, the new controller and template would start rendering immediately, which by itself provides some feeling of progress. I usually go for not using resolves in this case and have the controller show a proper loading state for itself. This way it doesn't matter where you're transitioning to this route *from*, you'll still have the proper loading indication. 

You can also, of course, have the button show some spinner or something until the route transition happens.

### Errors happen in no-man's-land

You have a resolve that makes an AJAX `$http` call. Eventually it will fail. Where will you handle the error? You don't have a controller yet to manage things at this point. 

Make sure to either have some [generic error handling](http://www.codelord.net/2014/06/25/generic-error-handling-in-angularjs/) or make your resolves always return some value, even on errors, and then handle those situations in your controller.

### It adds complexity to the code

Even though the solution makes some parts of the code clearer, like the example at the top of this post, it has a price. The dependencies of the controller are now pushed away to a place far far away. Some of the setup of the controller now happens in a different place, even though it is still very coupled - each resolve maps to an argument for the controller. 

I don't always like the effect this has on my code and if I notice that I have to keep flipping back and forth between the controller and the state setup I might decide to just push it all together (maybe using a helper service) to make things clearer and have them just sit together.

## Take aways

Resolves can be very handy and I definitely use them, but it's important to understand where they might clash with maintainability and UX and make sure to keep tabs on it.

Happy routing!

<!-- Begin MailChimp Signup Form -->
<div id="mc_embed_signup" class="cta">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Subscribe to learn how to avoid more Angular pitfalls (performance, directives, Angular 2 and more)!</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline"><!--
    --><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
    <div class="promise">~3 mails a month, unsubscribe anytime, no spam, promise!</div>
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
