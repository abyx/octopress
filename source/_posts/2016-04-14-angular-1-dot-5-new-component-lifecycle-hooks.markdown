---
layout: post
title: "Angular 1.5 new component lifecycle hooks"
date: 2016-04-14 11:36:31 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 42334
---

It’s only been 2.5 months since Angular 1.5 came out, introducing components.
Most companies haven’t even had the chance to upgrade yet.
Yet, in the mean time, the Angular team released 3 more releases.

With 1.5.3 components have become a bit smarter and a bit more compatible with Angular 2.
This new version introduced some new and useful *lifecycle hooks* to directive/component controllers.
Let’s take a deeper look at how these can help you write cleaner code!

# Recap: `$onInit`

I’ve [previously written](http://www.codelord.net/2015/12/17/angulars-component-what-is-it-good-for/) on `$onInit`, the first lifecycle hook introduced with version 1.5.

It provides you with a nice and clean place to initialize your component after all of its bindings have been set.

This roughly maps to Angular 2’s `ngOnInit`.

# New: `$onChanges`

This new hook is similar to ng2’s `ngOnChanges`.
It is called whenever *one* way bindings are updated, with a hash containing the changes objects.

Prior to this hook you sometimes had to use a `$watch` in order to do some work whenever a value you’re bound to changes.
Using this hook makes things clearer and removes the need to introduce a watch and a dependency on `$scope`.

# New: `$onDestroy`

A hook that gets called whenever the controller’s scope is being destroyed.

Whenever you used external resources, or add DOM listeners, in your component you’d (hopefully) use `$scope.$on('$destroy', ...)` in order to clean up when your component would get destroyed.

This hook, similarly to `$onChanges`, makes things simpler and saves us a dependency on `$scope`.

Unsurprisingly, this is equivalent to ng2’s `ngOnDestroy`.

# New: `$postLink`

This isn’t something that comes up often, but maybe you got bitten in the past by the difference between a directive’s `link` function and the directive controller’s function.

These two do not run at the same time: the former runs after the DOM is ready while the latter isn’t.

This means that for some DOM manipulation and operations you had to work harder in order to perform it in a component (or maybe you had to use a directive).

Now we can use `$postLink` and know that all of our child components are ready.
This, together with the `$element` injectable we have in components makes it even less likely that you’ll need to write an old-style directive. *w00t!*

<hr>

Do you have a big *Angular 1.x app* that you're scared will *rot and become legacy code*? Because 2.0 and TypeScript will soon be *the new shiny* yet you have *all this JS code* sitting there? Where will your team find the time, and *management approval*, to learn and move things to 2.0?

But what if you could *migrate your project*, incrementally, while keeping your time's pace and shipping awesome code? What if your team could learn a bit more Angular 2 with each task? Imagine you could get to be *working in 2.0 land without ever stopping your development*!

I'm cooking up a self-served course that will get you there. It will allow you, *on your own pace*, learn Angular 2 and TypeScript bit by bit. With those steps your team will migrate your project and soon you'll write all your new code with Angular 2, TypeScript, and *won't have to stay behind*.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
