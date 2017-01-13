---
layout: post
title: "Unit Testing Angular Components with $componentController"
date: 2017-01-09 18:47:55 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Subscribe to get the next part about testing components and stay updated with the latest about modern Angular 1.x"
cta_form: 149826
---

Angular 1.5+’s components are great, but testing them properly requires some changes to they way you were used to testing before.

Directives were always a bit clunky to test in Angular.
You would either have to deal with recreating their DOM elements, or exposing the controller outside of the directive in order to test it directly.
Since components are essentially wrappers around directives, you might expect the same dance.

But, along the introduction of components we also got the handy `$componentController` service.
This service enables testing a component’s controller even without exposing it, and it also provides a simple way to supply a controller with bindings in the test.

Say that we have this component:

```javascript
app.component('foo', {
  bindings: {
    baz: '<',
    bar: '<'
  },
  controller: function() {},
  templateUrl: 'foo.html'
});
```

In order to get an instance of `foo`’s controller in a test, we’d write this code:

```javascript
var fooCtrl = $componentController('foo', null, {
  baz: 'baz value',
  bar: 'bar value'
});
```

As you can see, `$componentController` receives the name of the component that we’d like to test and also the bindings it should be initialized with, and returns the instantiated controller.

You can now start testing the controller, by invoking its functions and asserting the different results:

```javascript
expect(fooCtrl.getDisplayResult()).to.equal('baz value bar value')
```

## Don’t forget $onInit

In case your component implements the `$onInit` lifecycle hook, which is very likely [starting from Angular 1.6](http://www.codelord.net/2017/01/01/angular-1-dot-6-is-here-what-you-need-to-know/), you should make sure to explicitly call it in your tests.
Angular and `$componentController` does not take care of that for you, for different reasons.

This means that the test above should look like this:

```javascript
var fooCtrl = $componentController('foo', null, {...});
fooCtrl.$onInit();
expect(fooCtrl.getDisplayResult()).to.equal('baz value bar value')
```

That’s it!

Handling `$onChanges` is even trickier in tests, make sure to subscribe below to get the next part about it.

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
