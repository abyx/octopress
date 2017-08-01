---
layout: post
title: "Angular Nitpicking: Differences between $timeout and setTimeout()"
date: 2015-10-14 18:04:05 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
---

When you just got started doing Angular you probably had a couple of times where you used `setTimeout()` without giving it much thought. Then, you noticed that something wasn’t working right. Changes weren’t happening when you expected them to happen.

If you’re lucky you had someone nearby that just said “Oh, you should use `$timeout`”. If you weren’t lucky you probably wasted 30 minutes until you found that out.

But I don’t like just *knowing* to use that. You should understand *why* you use `$timeout`.

Let’s up your Angular game and understand *exactly* what are the differences between these two.

Note: everything here goes the same for `setInterval` and `$interval`.

# The basic difference: the digest cycle

Angular’s binding magic works by having a digest cycle mechanism. Whenever a change is made Angular goes over all the values that are bound and checks which have changed. It then updates all dependent values. Simple yet awesome.

The problem is that to be aware of when changes happen, i.e. when to run the digest cycle, Angular needs to know when asynchronous things happen. That includes user interaction, AJAX requests and, yes, timeouts.

This is why you use `ng-click` and not `element.on('click')` or `$http` and not `$.ajax()`. They make sure to trigger a digest after those asynchronous events were handled.

Same goes for `$timeout`. That’s why if you have a `setTimeout` function that changes your view you often don’t see the changes rendered until sometime later (when something happens to trigger a digest).

# The benefits of $timeout integration

## Unit testing

Using `setTimeout` in code you’d want to test is shooting yourself in the foot. You will have to either write very ugly asynchronous tests that depend on delays or monkey patch the global `setTimeout` function.

Angular’s `$timeout` is tightly integrated into the whole testing suite and [ngMock](https://docs.angularjs.org/api/ngMock). This means that whenever you’re testing code with `$timeout`s you know it won’t be executed until you specifically call `$timeout.flush()`. That will then call all pending timeouts synchronously. *I know this just got you excited a bit.*

## Promises

`$timeout` returns a promise that resolves once the function has finished running (e.g. show a modal). This way if you ever need to do something once a timeout has run you don’t need to [construct a promise yourself](http://www.codelord.net/2015/10/07/angular-2-preparation-killing-controllers/):

```javascript
$timeout(function() {
  // Do something
}, 1000).then(function() {
  // You know the timeout is done here
});
```

# The performance angle

Since `$timeout` triggers a digest, if it happens frequently it might cause performance issues. Sometimes, though rarely, the majority of your timeouts don’t change anything related to Angular. In those cases triggering a digest is a waste.

If you google you might find outdated “tricks”. Those will tell you that performance is exactly the use case for whipping out `setTimeout`. *But*, Angular’s `$timeout` has a third argument, called `invokeApply`. You can use it to… you guessed it… prevent `$apply` from running and avoid the digest.

So even if you ever happen to need to squeeze this a bit to make your app performant you can do something like this:

```javascript
$timeout(function() {
  if (actuallyNeedToUpdateAngular()) {
    $scope.$apply(function() {
      // Do someting here
    });
  }
}, 1000, false); // <-- Note the 3rd argument!
```

Another use case is to use `invokeApply` in order to have a timeout that only triggers a digest on a sub-scope and not the whole scope hierarchy. This is very advanced voodoo, but you can see an example of that [here](http://blog.500tech.com/is-reactjs-fast/).

## tl;dr Use $timeout always

Yes, we have come full circle to the exact same knowledge you had before, but now you have *understanding*. Knowledge is power my friend!

{% render_partial _posts/_partials/book_cta.markdown %}
