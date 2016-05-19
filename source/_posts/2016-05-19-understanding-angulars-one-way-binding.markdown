---
layout: post
title: "Understanding Angular's One-Way Binding"
date: 2016-05-19 14:13:04 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 55131
---

Angular 1.5 introduced a new kind of binding option to directives/components.
Along the often-used `=` for regular two-way binding and `&` for [expression binding](http://www.codelord.net/2016/05/13/understanding-angulars-and-binding/), we now have `<`: *one-way binding*.

What does it mean exactly?  
When should you use it?  
When shouldn’t you?  
And why did we even need another kind of binding?  
Sit tight!

{% img center_img /images/posts_images/one-way.jpg 350 234 One Way %}

# How today’s two-way binding works

Today’s two-way binding basically has 3 aspects: passing the reference first, synchronizing changes from the parent and synchronizing changes from the child:

*Passing the same reference* means that when your child component is initialized with `foo="$ctrl.foo"` then Angular will pass it a reference to the same `foo` object as in the parent controller.
This initializes them to start working off of the same data.

Because this is the same reference, changes made to a property on `foo` by either parent or child will be seen by the other, e.g. `$ctrl.foo.baz = 'a'`.

*Synchronizing changes from the parent* means that if our parent component overrides `foo` with a new object, i.e. `this.foo = otherFoo` then Angular’s watch will notice and change the child component’s `foo` to reference the same new object.

*Synchronizing changes from the child* are the other coin of the *two* way binding - if the child assigns a new reference it will also be copied to the parent.

# You ain’t gonna need it

Even if you knew about the synchronization from the child to the parent, and most don’t know, it’s likely you never actually had to use it.

Having the objects be initialized with the same reference is enough for 95% of the components.
The synchronization from the parent likely covers another 4.9%.

The other way around is just obscure, costs you in performance and, to be honest, sounds like a code smell.

# Be explicit and don’t pay for what you don’t need

Basically, your rule-of-thumb should be to *always default to one-way* binding, like so:

```javascript
angular.module('app').component('myComponent', {
  templateUrl: '...',
  bindings: {
    foo: '<' // <-- This!
  },
  controller: function() { ... }
});
```

It is always better to be explicit in code.
One-way binding means you’re not doing anything funky to the object reference.

Also, there’s a performance penalty to using two-way bindings when you don’t need them.
One-way bindings require less work on every digest and so you can also gain a small boost (I say small because from measuring it seems small - but it’s essentially *free*, why not?).

Cheers!

<hr>

Do you have an existing Angular 1.x app that makes you worried about its future?  
You don't want your app to be *left behind* and become *legacy code*.  
But it's not easy clearing the time to learn Angular 2.  
And who has the energy to convince management that you need to change frameworks, delay your schedules and do the Big Ol' Rewrite?

But what if you could make sure your app keeps its options open?  
What if you could make it future-proof, all the while *shipping features like a boss*?  
You'll work in a codebase that uses the latest and greatest, have easy maintenance and happy stakeholders!

The *Future-proof Angular Guide* can help you get there.  
With this no-fluff course you'll learn how to quickly adapt your existing Angular 1.x app to the latest components paradigm, as you go about your regular work.  
You'll gradually turn your app into something that is modern and idiomatic, converting directives and getting rid of controllers.  
And then, once your app is shaped The Right Way™, you'll be able to keep shipping like a boss, and have your options open.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
