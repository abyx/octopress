---
layout: post
title: "Angular Interview Question Deep Dive: Implement ng-click"
date: 2016-09-06 16:22:13 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 94968
---

For this post I decided to do something a bit different.
We will go through an Angular interview question that I quite like:

> How would you implement the ng-click directive yourself?

This sounds pretty simple, but as we’ll see, there are many little details and decisions that seem trivial that actually have significant impact.

I’m sure that even seasoned Angular veterans will pick up something new in this post.
And on that note: let’s dig in!

# The very trivial first implementation

First, I’ll say that a lot of newbie Angular devs find it hard to write custom directives - and that’s to be expected.

Now, let’s look at something that a newbie might write as an answer:

```javascript
angular.module('app').directive('myClick', function() {
  return {
    scope: {
      myClick: '&'
    },
    link: function($scope, $element) {
      $element.on('click', function($event) {
        $scope.myClick({$event: $event});
      });
    }
  };
});
```

This should look pretty straightforward: we’ve created a template-less directive that has an isolated scope which allows it to receive the callback that we should execute on clicks.

Then, in the `link` function, we set up a click handler and whenever a click happens, we call the bound callback.

## But why aren’t clicks always working?

If you’ll try to run this example and, say, have the click callback change something so that your view will get updated, you might notice things are acting a bit weird.
Sometimes the click changes happen immediately, sometimes they only get updated after several clicks.

The issue is, of course, that we’ve *forgotten to call `$scope.$apply`*.
The click listener is native code that Angular’s not aware of.
That means that when our click handler runs Angular has no idea that it should fire off a digest cycle in order to update everything.

The fix is pretty simple: just change the click handler body to:

```javascript
$scope.$apply(function() {
  $scope.myClick({$event: $event});
});
```

*Nitpicker’s corner:* Why use a directive instead of a component?
If you’ve been following my post at all in 2016, you probably have seen me say that come Angular 1.5, directives are 98% dead and you should almost never write a directive.
Guess what?
This is exactly where you should be using a directive: for template-less logic.
You can’t do it with a component.

## Hey! Don’t you need to remove the click handler?

I’ve seen a lot of people get confused about the need to remove native event handlers.

The thing is, that since we’re adding a click handler to our directive’s root element, we are guaranteed that as long as the directive is alive, the DOM will be alive and vice-versa.
The handler will die when the element will die, no need to get fancy here.

The need to cleanup comes in more complex scenarios where your handler’s logic might not be relevant for the whole duration of the DOM element that you’re binding on.

# Is that it? No! Round 2

Well, I have to say that if someone would have written me the above answer, including the `$scope.$apply`, I would be already pretty pleased.

But that’s not really the “best” way to get this task done, as you can see by digging through Angular’s code by yourself (I’ll leave that as an exercise to you, dear reader, I promise it’s quite easy).

Our template-less directive actually has a bit of a performance hit that’s not really needed.
For every element that we’ll want to listen for clicks on, we’ll be creating a new isolated scope, just to pass the callback in.

This isolated scope is never bound to the DOM itself, because our directive has no template, and so the scope is pretty useless.

Instead, the better and more efficient way of doing it would be by changing our template-less directive to also be scope-less:

```javascript
angular.module('app').directive('betterClick', function($parse) {
  return {
    link: function($scope, $element, $attrs) {
      var callbackFn = $parse($attrs.betterClick);
      $element.on('click', function($event) {
        $scope.$apply(function() {
          callbackFn($scope, {$event: $event});
        });
      });
    }
  };
});
```

*What just happened here?*

Well, first of all, you can see that we’ve dumped the `scope` thing altogether, which means that this directive doesn’t create a new scope at all, but instead simply makes use of whatever scope it’s already in.

But, since we’re not using the dandy `&` binding anymore, we have to do some work on our own.
We would like to get the callback like you would with `ng-click`: `<div better-click="clicked($event)"></div>`.

To get a hold of the function that we should call, we’re using the `$attrs` object to get the expression that we should use for the callback: `$attrs.betterClick`.

Then, we use the built in `$parse` service in order to parse the  expression string into a function that we can call whenever we need to.

Inside our click handler we simply call this new function ourselves (with the right scope), whenever a click happens.

Voila!

## Is this really worth the hassle? How much efficiency are we talking about?

Whenever I talk about [Angular performance](http://www.codelord.net/2015/08/03/angular-performance-diagnosis-101/), I always stress that you have to measure your optimizations in order to make sure that they are, indeed, optimizations.

*Our optimization:* The seasoned Angular developer would realize that our optimization boils down, essentially, to not creating extra scopes for each click handler in our app.

As you can expect, click handlers are very common, and we’d like them to be as performant as possible.

In benchmarks I ran, it was clear that the performance hit of `myClick` directive is *x2.5-x3* that of `betterClick`.

**WAT?**

Yes.
That’s because every scope in our Angular app, even an isolated scope that’s essentially empty, is still another thing that Angular has to check in every digest cycle.

Once you have enough of these click handlers on screen, it adds up - which is exactly why the Angular core team implemented `ng-click` (and basically all the rest of the simple event handlers) in this way.

# Back to our interview question

As I said, I wouldn’t expect a novice Angular developer to write this performant version.

Actually, I know many solid developers who have been doing Angular for years and yet wouldn’t have thought about this performance issue.

But, I would expect them to be able to reason about why the latter solution is better and know how to benchmark it themselves to prove it.

Cheers!

{% render_partial _posts/_partials/book_cta.markdown %}
