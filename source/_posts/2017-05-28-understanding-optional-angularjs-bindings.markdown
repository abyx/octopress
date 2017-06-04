---
layout: post
title: "Understanding Optional AngularJS Bindings"
date: 2017-05-28 19:47:58 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Subscribe to get the latest about modern Angular 1.x"
cta_form: 217760
---

It seems that few developers are familiar with the ability to mark bindings in AngularJS as optional, and what that even means.
After all, you may have seen that even when you don’t pass a binding to a directive/component, things seem to work, so why bother?

In this post we’ll go over the different binding types and understand what, exactly, setting them as optional means, so you’ll know when to use it and what might happen if you don’t.

## Two-way `=` bindings

Two-way bindings, when not specified as being optional, would only complain when the component tries to assign to them.
That is because, by definition, Angular would attempt to update the parent component as well.
If the parent never gave a value, Angular will not be able to update it, and so would throw a runtime exception.

  
For example, consider a component called `userEditor` that defines its bindings like this:

```javascript
bindings: {
  user: '='
}
```

If you were to instantiate the component without the `user` bindings, e.g. `<user-editor></user-editor>`, at first nothing bad would happen.
The component’s controller, when accessing the `this.user` property, will see that its value is `undefined`.

But, if the component would ever attempt a reassignment, such as `this.user = {}`, it would result in an error.

In those situations, in case the binding is not mandatory, you should specify it as being optional:

```javascript
bindings: {
  user: '=?'
}
```

Then, reassigning would just silently work, without actually updating anything in the parent.

Though, I will stress that reassignments should be rare and you should probably be using one-way bindings, described below.

## One-way `<` bindings

Since [one-way bindings](http://www.codelord.net/2016/05/19/understanding-angulars-one-way-binding/) are, hmm, _one-way_, they don’t have the same problem as described above on reassignments.
Angular just doesn’t care that the component is reassigning, and so, for these bindings, the behavior would be the same with or without the optional setting.
If the user of the component does not pass a value for the binding, it would be `undefined` in the component’s controller and that’s it.

Yet it can be specified as being optional, by providing the value `<?` in the `bindings` definition (or `scope` if you’re using a directive).

## Expression (function) `&` bindings

The [`&` binding](http://www.codelord.net/2016/05/13/understanding-angulars-and-binding/) is mostly used in order to pass a callback to a component–a simple function that can be invoked by the component’s controller.

By default, when these bindings aren’t set up with an initial value by the parent component, they simply translate to a function that does nothing and returns `undefined` (also known as `angular.noop`).
This makes it completely safe for the child component to call that binding without risking a crash, as a nice example of the Null Object pattern.

And yet, sometimes the component would need to know whether the callback was passed at all or not, e.g. to decide whether certain work needs to be done.

In those scenarios it is possible to specify the binding as being optional, with `&?`, and then it is passed to the controller as `undefined`, instead of `angular.noop`.
Then the controller can check for it, e.g. `if (this.callback)`, and take action according to the value.

This does mean, though, that the controller can no longer blindly invoke the binding; it has to check first that it is defined.

## Bottom Line: Use Optional If You Mean It

As you might understand, one can do Angular for quite a while without ever _having_ to use optional bindings.
And yet, I would argue that they should always be used if, indeed, the bindings are optional.

Also since in two-way bindings it would be a bug waiting to happen to do otherwise.
Yet mainly because I believe that doing so helps to write better, more maintainable code, that is later easier for future users of the component to reason about and understand (be those users other developers or future-you).

By adopting a convention across your codebase to always specify optional bindings when necessary, your team will have another aid for explicitly documenting your code.

Just remember to add that `?` to the binding definition!

<hr>

You want to do Angular *the right way*.  
You hate spending time working on a project, only to find it's completely wrong a month later.  
But, as you try to get things right, you end up staring at the blinking cursor in your IDE, not sure what to type.  
Every line of code you write means making decisions, and it's paralyzing.  

You look at blog posts, tutorials, videos, but each is a bit different.  
Now you need to *reverse engineer every advice* to see what version of Angular it was written for, how updated it is, and whether it fits the current way of doing things.

What if you knew the *Angular Way* of doing things?  
Imagine knocking down your tasks and spending your brain cycles on your product's core.  
Wouldn't it be nice to know Angular like a second language?

You can write modern, clean and future-ready Angular right now.  
Sign up below and get more of these helpful posts, free!  
Always up to date and I've already done all the research for you.

And be the first the hear about my Modern Angular 1.x book - writing future proof Angular right now.

{% render_partial _posts/_partials/cta.markdown %}
