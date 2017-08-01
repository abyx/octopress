---
layout: post
title: "Spotting Outdated Angular 1.x Posts"
date: 2016-11-23 17:53:58 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 129509
---

As Angular is maturing, it gets harder and harder for newcomers to make sense of the abundance of materials you find online.
I’m pretty sure that at this point, the vast majority of Angular 1.x tutorials use outdated Angular practices–things that modern Angular 1.x projects should not be using.

In order to make it easier for everyone, I decided to grab a list of things that should indicate to you that the post you’re reading might be a bit… stale.
  
## Using $http’s deprecated .success and .error methods

Originally, Angular’s `$http` service would return promises that had a couple of extra methods on them.
While regular promises just have `.then` (and the sugar-syntax `.catch` and `.finally`), those returned from `$http` also had special `.success` and `.error` that weren’t standard and didn’t behave like regular promise callbacks.

I think this was done in order to make things easier for new comers to Angular that also didn’t know much about promises, but we’ve come a long way since then.

These were deprecated quite some time ago, and are completely gone in Angular 1.6.

I ranted about these more in depth [here](http://www.codelord.net/2015/05/25/dont-use-$https-success/).

## ng-controller and standalone controllers

Ever since the announcement that controllers are being killed in Angular 2, the community has been moving off of using standalone controllers.
By “standalone” controllers I mean controllers that are used without an encompassing directive/component, e.g. using `ng-controller` or in a ui-router definition.

`ng-controller` is used quite a bit in blog posts since it makes things shorter which is helpful.
The problem is that developers then go their projects and use what they saw in the examples, not knowing that `ng-controller` belongs to the past.

## Using $scope bindings and not using controller-as syntax

Controller-as syntax was introduced in Angular 1.3 and has since become the de-facto standard for writing directives/components in Angular.

Prior to controller-as we would slap everything on the `$scope`, e.g. `$scope.model = {name: ''}` and then use the scope directly from our template:

```html
<input ng-model="model.name">
```

This, again, makes things shorter requires less typing, but it is not the way we write proper Angular now.

With controller-as we’d initialize the controller code like so `this.model = {name: ''}`, and the template would be changed appropriately to not access `$scope` directly:

```html
<input ng-model="$ctrl.mode.name">
```

Note that I’m using `$ctrl` as my controller-as name, which is the default for components in Angular 1.5.
You might see `vm` used a lot in blog posts.
That’s fine, though I’d recommend just going with the default.

## Using non-isolated scopes

This is another thing that was used a lot more in the standalone controller days.
Controllers by themselves never have isolated scopes, it’s up to the directive/component to isolate the controller it’s encompassing.

So whenever you used `ng-controller`, or didn’t specify explicitly that you want your scope to be isolated in the directive definition, you’d instead get a scope that prototypically inherits from its parent scope.

This would quickly become a non-maintainable soup of properties where refactoring is almost impossible without breaking something, somewhere.

That is why for quite some time now the rule of thumb has been to write [maintainable](http://www.codelord.net/2014/03/30/writing-more-maintainable-angular-dot-js-directives/), isolated directives.

## Using directives instead of components

Since Angular 1.5 was released, introducing components, about 99% of your directives should be written using components.

Essentially, any directive that has its own template should be written as a component.
So, `ng-click`-use a directive, anything else–components.

Yeah, most online material hasn’t been updated to use components whenever appropriate (heck, I’ve got a bunch of posts that need updating as well).
But, modern Angular 1.x is components based.
Do it.

I’ve written about components at length [here](http://www.codelord.net/2015/12/17/angulars-component-what-is-it-good-for/).

## Two-way binding instead of one-way binding

Another nicety introduced in 1.5 is one-way binding (not to be confused with [one-time binding](https://toddmotto.com/angular-one-time-binding-syntax/)).

One-way binding, like components, what you almost always want to be using.
It’s more explicit, more performant and more modern.

Even though it’s a rare occurrence in most blog posts, that doesn’t mean you shouldn’t be using it.
It is great, and you should. 

Read all about it [here](http://www.codelord.net/2016/05/19/understanding-angulars-one-way-binding/).

## Using $watch where $onChanges would suffice

It has been common practice to stay clear of `$watch` when possible.
And yet, going through some guides you’d think it has to be used way more often that it really does.

Ever since 1.5 introduced lifecycle hooks in components, we no longer need to use `$watch` to trigger some logic whenever a binding changes from a parent component.

Instead, use the `$onChanges` hook to perform whatever is needed without adding an extra watch,
 and maybe even saving you the need to inject `$scope` at all.

Read all about the hooks [here](http://www.codelord.net/2016/04/14/angular-1-dot-5-new-component-lifecycle-hooks/).

———

I hope this helps you evaluate the freshness of information and understand that just because something doesn’t come up in some posts it doesn’t mean it’s not not popular - just too new to be popular in posts :)

{% render_partial _posts/_partials/book_cta.markdown %}
