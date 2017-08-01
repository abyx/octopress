---
layout: post
title: "$scope.$watch and controllerAs"
date: 2016-06-02 13:02:24 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 60967
---

You know that by now your Angular code should be pretty `$scope` free.
The controllerAs syntax makes it so you shouldn’t be accessing `$scope` in order to store information on it.

But, scopes are still an important part of Angular and sometimes you have to use them.

One not-so-rare example is the `$scope.$watch()` function.
With the introduction of controllerAs syntax we now have 2 seemingly interchangeable ways to use it.
But, they are not exactly the same and I think you should only be using one.
Let’s quickly go over it.

# The olden days

In the pre-controllerAs days we would put everything directly on the `$scope`.

So, you might have `$scope.foo` and then, to watch for changes, you’d use `$scope.$watch('foo', fooChanged)`.

That just worked.
But with controllerAs it’s not that simple.
If in your controller code you use `this.foo`, you can no longer just watch for changes using `$scope.$watch('foo', ...)`.

That’s because the `'foo'` part looking for `foo` directly on the scope, not your controller’s instance.

# The bad option - using the controller’s name

The way a lot of people are solving this is by using the controller’s name in the expression.

If you’re using Angular 1.5’s components then the controllerAs name is `$ctrl` by default.
So you’d use `$scope.$watch('$ctrl.foo', ...)`.

If you have a different name, like `stuffCtrl` then you’d use `$scope.$watch('stuffCtrl.foo', ...)` etc.

I don’t like this for several reasons:

- It feels foreign to me to use a name that’s essentially only used in the template (the controllerAs name), while the rest of the controller code uses `this` or `vm`.
- Using this name means that in case you decide to rename it, you’ll have to look for it in both the template and the controller code.

# The right way

It was always possible to pass a function to `$watch()` as the expression that you’re keeping track of.

Because of that, it’s possible to do something like this:

`$scope.$watch(function() { return vm.foo; }, ...)`

(Of course, it’s even nicer if you’re using ES6’s arrow functions.)

I believe this is better, even though it involves more typing, because it keeps your controller code consistent.
You always refer to things the same, and there are no magic strings.

{% render_partial _posts/_partials/book_cta.markdown %}
