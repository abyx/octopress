---
layout: post
title: "Don't use $http's .success()"
date: 2015-05-25 23:16:00 +0300
comments: true
categories: 
- programming
- angular
- angularjs
---

An example of performing AJAX requests in Angular is probably the second thing you ever saw when getting into Angular (right after an example showing off two way binding). It does look very sexy and easy when you look at it, since most examples look something like this:

```javascript
$http.post('/products', product).success(function(createdProduct) {
    // w00t!
});
```

This is usually the first time you learn about promises in Angular and how they work. Later when you get more in depth you'll realize that only `$http`'s promises have `success()` and `error()` functions, while regular promises just have `then()`.

You might wonder what's the difference, really. Well, Angular is [all about decisions](/2014/05/26/angularjs-decisions-decisions-and-my-choices/), and this time I want to stress how using `success()` is a bad one.

## How `success()` is implemented

If we look in Angular's source code [here](https://github.com/angular/angular.js/blob/3a3db690a16e888aa7371e3b02e2954b9ec2d558/src/ng/http.js#L910) we can see that `success` is basically:

```javascript
promise.success = function(fn) {
    // ...
    promise.then(function(response) {
        fn(response.data, response.status, response.headers, config);
    });
    return promise;
};
```

So it's just like `then()` but deconstructing the response object. This is essentially just syntax sugar so you'd have a callback that gets the JSON object back as its first argument and save you reaching into `response.data` yourself.

## The problem

First, I hate anything that creates inconsistency in my code. If we use `success()` we'll still have to use `then()` in every other place that has a promise, which makes this syntax sugar more of a cognitive leak in my opinion than anything useful.

Second, it couples your code in a subtle way - you're telling everyone you're actually reaching to the network to get something. 

Say we have a service for managing some resource:

```javascript
angular.module('app').factory('ProductsService', function($http) {
    return {
        getProduct: function(id) {
            return $http.get('/products');
        };
    };
});
```

And this is used later like so:

```javascript
ProductsService.getProduct(123).success(function(product) {
});
```

This means that all users of `ProductsService` definitely know that `getProduct()` goes out to the web to get data. What if you later add caching? What if you decorate `ProductsService` with some wrapper and need to chain the promise it returns? If everyone assume your promises have `.success()` it's going to be a PITA.

## What I like to do instead

On several projects with multiple teams we've found this idiom to be quite nice:

```javascript
angular.module('app').factory('ProductsService', function($http) {
    return {
        getProduct: function(id) {
            return $http.get('/products').then(function(response) {
                return response.data;
            });
        };
    };
});
```

This way, we're using promise chaining to hide the `$http` promise and hide response data except for the JSON itself (e.g. response headers, request config). This means that we later can easily swap the original promises with cached promises, or generate random data with a fake promise when testing. Suddenly no one cares about HTTP.

I've found that 99% of the time your callers don't need/know how to handle HTTP errors anyway, so hiding it works. I prefer to go with [generic error handlers](/2014/06/25/generic-error-handling-in-angularjs/) where needed.


<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Don't miss the next Angular and frontend tip, subscribe! (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline"><!--
    --><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
