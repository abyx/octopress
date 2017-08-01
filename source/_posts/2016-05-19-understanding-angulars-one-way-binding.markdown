---
layout: post
title: "Understanding Angular's One-Way Binding"
date: 2016-05-19 14:13:04 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
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

{% render_partial _posts/_partials/book_cta.markdown %}
