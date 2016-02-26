---
layout: post
title: "Writing Pragmatic Angular Components"
date: 2016-02-19 11:34:51 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 25809
---

Angular 1.5’s new components are awesome.
But, as with anything new, we’re still learning, as a community, how to best use it.

There are [so many different ways](http://www.codelord.net/2015/12/17/angulars-component-what-is-it-good-for/) to use them.
And the style guides aren’t clear yet.

Here are my initial thoughts/guidelines after playing with components lately:

## Default to use one-way bindings

Angular 1.5 introduced one-way bindings, as opposed to the regular two-way bindings.

Since the need to override something from a child components to its parent is rare (and perhaps even a code smell), I prefer to always use one way bindings.

So make sure to pass write your bindings like so: `{someBinding: '<'}`, making sure to pass `'<'` instead of `'='`.

## Use $onInit to initialize your component

Yes, you don’t have to use to for setting up your component.
We’ve been doing just fine without it so far.

But, I think it helps makes thing clearer and explicit.

So, in your component’s controller function put all the setup code inside `$onInit`, e.g.:

```javascript
app.component('foo', {
  controller: function() {
    var self = this;
    self.$onInit = function() {
      // Initialize here:
      self.foos = [1, 2, 3];
    }
  
    // Add the other functions...
    self.addFoo = function() {};
  }
});
```

## Use require to pass dependencies between components layers

2 years ago [I wrote](http://www.codelord.net/2014/03/30/writing-more-maintainable-angular-dot-js-directives/) about the benefits of using the `require` feature for making more maintainable and robust directives.

Now, that components have even simpler `require` syntax and support, there’s really no reason not to use it.

It’s a great way to pass along dependencies between your components hierarchy without having to pass bindings from parent to child, layer after layer.

If you have some top level components that exposes something you need in some grandchild component, instead of using bindings just `require` it from the grandchild.

It makes these dependencies explicit and also is safer for refactoring, since Angular will let you know if something you’re requiring isn’t here.

## Feel free to inject $element to your component controllers

Components aren’t controllers.
Components are better directives.

Just because components don’t have a `link` function, it doesn’t mean you can’t use them for writing something that needs to play with the DOM a bit.

A component’s controller can be injected with `$element`, just like you get in a directive’s `link`.
There’s a reason it’s there - use it.

Yes, it was taboo to do DOM manipulation in controllers, but that’s the *old Angular*.

Embrace components and fear not having a true component that has control over its element.

<hr>

Do you have a big *Angular 1.x app* that you're scared will *rot and become legacy code*? Because 2.0 and TypeScript will soon be *the new shiny* yet you have *all this JS code* sitting there? Where will your team find the time, and *management approval*, to learn and move things to 2.0?

But what if you could *migrate your project*, incrementally, while keeping your time's pace and shipping awesome code? What if your team could learn a bit more Angular 2 with each task? Imagine you could get to be *working in 2.0 land without ever stopping your development*!

I'm cooking up a self-served course that will get you there. It will allow you, *on your own pace*, learn Angular 2 and TypeScript bit by bit. With those steps your team will migrate your project and soon you'll write all your new code with Angular 2, TypeScript, and *won't have to stay behind*.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
