---
layout: post
title: "$q.defer: You're doing it wrong"
date: 2015-09-24 06:31:01 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 74718
---

Using promises is tricky at first. Every newcomer to Angular will be flustered about them. It’s super easy to get lost at first between all the different nitpicks: promise chaining, `$http`’s special promises, the asynchronous nature of it all, etc.

One of the first questions you tackle starting to learn promises is **when, if at all, should you use `$q.defer()`?**

I used `$q.defer()` quite often when I first started with Angular. You know how much of that original code actually needed to use `defer()`? About *none at all*.

I realized that there was almost no reason to use `defer()` to create my own promises. It’s just *cumbersome* and *error prone*.

And guess what? I think that *nearly everyone that uses it does it unnecessarily*.

# Real examples from GitHub

First, a disclaimer: this isn’t some sort of shaming. I used to write lots of code just like this. I want to show how common this problem is with real code and no handwaving.

I opened GitHub’s code search and started looking for people using `$q.defer()`. In the first 3 pages of results I saw about 2 actual valid use cases. *Yeeeep.*

## You don’t need defer to create a simple-valued promise

Let’s take a look at [this case](https://github.com/qcentic/activator-callcenter-frontend/blob/5bcc9875319b3e453741fc5c595d98c7fecd6380/src/main/webapp/js/CallCenterServices1.js):

```javascript
	var defer;
	defer = $q.defer();
	defer.resolve(['detail', 'simple']);
	return defer.promise;
```

It’s easy to see the author just wanted to create a promise with some hard-coded value. Those 4 lines? They can just be rewritten as:

```javascript
	return $q.when(['detail', 'simple']);
```

Same goes for [this longer case](https://github.com/brettshollenberger/angular-examples/blob/dba1d1afc5b9476715fc55df4b7a78f9a3ccac6e/promises/app/scripts/lib/promises.js) or [that one](https://github.com/jmoubry/dinner-decision/blob/b3db5abda96abf48f7ed2efc13a2154a7b444c88/Code/DinnerDecisionApp/DinnerDecisionApp/scripts/services/restaurantCategoriesService.js). `$q.when()` is perfect for when you want to turn a simple value into a promise. 

## You don’t need defer to change the value of a promise

A lot of coders like changing `$http`’s special promises to work like regular ones - [and rightly so](http://www.codelord.net/2015/05/25/dont-use-%24https-success/). Take a look at [this way](https://github.com/nverba/angular-chrome-options/blob/954e289bcc2f41f764199166545498892bfe5ff4/dist/config-module.js) of doing it:

```javascript
	var defer = $q.defer();
	$http.get('options.json').success(function(result) {
	  defer.resolve(result);
	});
	return defer.promise;
```

This successfully creates a promise that you can call with `.then()` and receive as a value the actual response body. But, through the magic of **promise chaining** you can simplify this:

```javascript
	return $http.get('options.json').then(function(response) {
	  return response.data;
	});
```

[Promise chaining](https://www.airpair.com/angularjs/posts/angularjs-promises) is a bit complicated, but the gist is this: inside a promise’s `.then()` whatever you `return` will be passed along to the next `.then()` along the chain.

This means that in our example above we’re returning a regular promise whose `.then()` will pass `response.data` - *sweet!*

## Sometimes you don’t need to do anything at all

Just about anything asynchronous is already a promise in Angular. Take a look at [this](https://github.com/prakashsv/insta_searcher/blob/cdd02769b0e71c8fa354110078dfdc07dfe64473/js/services/InstaSearchService.js):

```javascript
	var defer = $q.defer();
	$timeout(function() {
	  defer.resolve();
	}, 5000);
	return defer.promise;
```

The author wanted to return a promise that would get resolved once 5 seconds have passed. But guess what? `$timeout` already returns a promise that does just that, allowing us to write this:

```javascript
	return $timeout(function() {}, 5000);
```

# When *should* you use defer?

Basically, the main reason is:

**You’re converting a callback API to be promise-based:** For example, if you wrap a jQuery plugin to work in Angular. Callbacks are not as fun as promises. To kickstart the promise chain and convert callbacks you have the create the first promise.

I've written about actually creating promises [here](http://www.codelord.net/2016/07/10/properly-wrapping-native-javascript-with-%24q-promises/).

{% render_partial _posts/_partials/book_cta.markdown %}
