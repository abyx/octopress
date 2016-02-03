---
layout: post
title: "Caching HTTP results in Angular"
date: 2016-01-27 11:16:16 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Don't let your Angular 1 app become legacy, learn how to upgrade it!"
cta_form: 20822
---

A lot of the work of web developers eventually boils down to making things smoother or nicer for the user.

HTTP calls are a big part of this mess.
Web development is async.
That means the users perceive slowness.

Say you’re using Trello and go back and forth between a couple of cards.
Should you wait every time you click a card for it to be fetched *again* if it wasn’t changed?

Certainly not.

And while caching isn’t that hard to do, it’s a bit tricky to do *right*.
Let’s take a look.

*Note:* I'm going to show you how to roll your own caching.
In case you have no need of advanced uses, like invalidating the cache or manually changing it for performance optimizations, you might be able to simply use `$http`'s built in `cache` option.

# Setting things up

Let’s say we’re going to put a cache behind our `FooService`.
To have things work smoothly, you should make sure that you’re not returning `$http` promises from `FooService`.

`$http` promises has the deprecated `.success` function on it, which you really [shouldn’t be using](http://www.codelord.net/2015/05/25/dont-use-%24https-success/).

# Our Service

```javascript
module.factory('FooService',
     function($http, $cacheFactory, $q) {
  var cache = $cacheFactory(
        'fooCache', {capacity: 100}); // 1
  return {
    getFoo: function(id) {
      if (cache.get(id)) {
        return cache.get(id); // 2
      }

      var promise = $http.get('/foo/' + id).then(
        function(response) {
          cache.put(id, $q.when(response.data)); // 4
          return response.data;
        }
      );
      cache.put(id, promise); // 3
      return promise;
    }
  };
});
```

*Note:* While this is still an Angular 1 service, you should really consider writing your new services in Angular 2 like I describe [here](http://www.codelord.net/2016/01/07/adding-the-first-angular-2-service-to-your-angular-1-app/).  
And this is a good time to mention that if you're worried about the future of your Angular 1 app you should subscribe and get my guides for upgrading your app step by step!

{% render_partial _posts/_partials/cta.markdown %}

So, what are we looking at?

At **1** you can see that we use Angular’s [$cacheFactory](https://docs.angularjs.org/api/ng/service/$cacheFactory).
This is a pretty basic object that behaves much like a regular dictionary/map/object.

But, it has the added benefit that you can specify a capacity for the max amount of items it saves.
That easily turns it into an LRU cache.

Then, **2**, when we are requested to get a certain value we first try to return it from the cache.

If we find nothing in the cache we make the request, store its promise in the cache (**3**) and return it.

And, finally, once the request returns we update the cache with the returned value (**4**).

Note that the cache holds promises, not the actual values.
This is for an edge case: it is possible to get 2 requests for the same object before our first request completed.

In that case, we’d rather not make 2 requests.
That’s why right when we create an initial request we already store its promise in the cache.

That way once a request has been made we’ll always have something to return and won’t make a request that’s not needed.

# That’s it!

Yeah, you’ll probably need to add some more lifecycle management, like invalidating objects that have changed.

But, this is the gist of it.

<hr>

Do you have a big *Angular 1.x app* that you're scared will *rot and become legacy code*? Because 2.0 and TypeScript will soon be *the new shiny* yet you have *all this JS code* sitting there? Where will your team find the time, and *management approval*, to learn and move things to 2.0?

But what if you could *migrate your project*, incrementally, while keeping your time's pace and shipping awesome code? What if your team could learn a bit more Angular 2 with each task? Imagine you could get to be *working in 2.0 land without ever stopping your development*!

I'm cooking up a self-served course that will get you there. It will allow you, *on your own pace*, learn Angular 2 and TypeScript bit by bit. With those steps your team will migrate your project and soon you'll write all your new code with Angular 2, TypeScript, and *won't have to stay behind*.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

<hr>

Do you have a big *Angular 1.x app* that you're scared will *rot and become legacy code*? Because 2.0 and TypeScript will soon be *the new shiny* yet you have *all this JS code* sitting there? Where will your team find the time, and *management approval*, to learn and move things to 2.0?

But what if you could *migrate your project*, incrementally, while keeping your time's pace and shipping awesome code? What if your team could learn a bit more Angular 2 with each task? Imagine you could get to be *working in 2.0 land without ever stopping your development*!

I'm cooking up a self-served course that will get you there. It will allow you, *on your own pace*, learn Angular 2 and TypeScript bit by bit. With those steps your team will migrate your project and soon you'll write all your new code with Angular 2, TypeScript, and *won't have to stay behind*.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
