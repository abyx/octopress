---
layout: post
title: "Properly Wrapping Native JavaScript with $q Promises"
date: 2016-07-10 19:08:58 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 74695
---

One of my most popular posts ever is the post about how a lot of Angular developers are [using $q wrong](http://www.codelord.net/2015/09/24/$q-dot-defer-youre-doing-it-wrong/) (specifically `$q.defer()`).

Yes, in the vast majority of cases, you don’t really need to create a promise by your own from scratch.

But, in some cases it is a valid and powerful tool.
The most common one is when you need to wrap some native JavaScript code that’s not promisified to make it play-along with your Angular awesomeness.

In this post we’ll quickly learn how it’s best to do it.
There are 2 different ways of achieving this, let us go over them.

Our example would be a scenario where you’re writing some kind of image preloading service that should return a promise letting you know when the image has finished preloading.

# Technique 1 - Using $q.defer()

This is the more barebones approach.
The `$q.defer()` actually returns a “deferred” object.

This object has a `.promise` property, which returns your newly created promise.

It also has 2 methods, `resolve` and `reject`, which you can call at the right time to resolve or reject your promise:

```javascript
function preloadImage(imgSrc) {
  var deferred = $q.defer();
  var img = angular.element('<img>');
  img.on('load', deferred.resolve);
  img.on('error', deferred.reject);
  img.attr('src', imgSrc);
  return deferred.promise;
}
```

As you can see, we first create the deferred object and then set up our preloaded image to point at it, and finally return the new promise;

# Technique 2 - $q constructor

This is a very similar way to achieve the same thing, only more succinct:

```javascript
function preloadImage(imgSrc) {
  return $q(function(resolve, reject) {
    var img = angular.element('<img>');
    img.on('load', resolve);
    img.on('error', reject);
    img.attr('src', imgSrc);
  });
}
```

As you can probably understand, `$q`’s constructor-function (or whatever this thing should be called) is syntax sugar for directly calling `defer()`.

Personally I tend to use the second technique.
Beginners usually understand it the first time they come upon it even without reading the documentation.

It also means a little less moving parts, which is always good.

And lastly, it’s just simpler - I have seen people waste several hours simply because they ended up doing `return deferred` instead of `return deferred.promise`, so why even risk it?

{% render_partial _posts/_partials/book_cta.markdown %}
