---
layout: post
title: "Understanding Angular's @ Binding"
date: 2016-08-31 18:26:12 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 94004
---

I’ve [written about](http://www.codelord.net/2016/05/19/understanding-angulars-one-way-binding/) the new `>` one way binding in Angular, and [explained the magic](http://www.codelord.net/2016/05/13/understanding-angulars-and-binding/) behind `&` bindings.
It only felt natural to explain what is likely the least-understood binding type: `@`.

I’ve seen people use it by mistake, not understanding how exactly it works and when you should (or shouldn’t) use it.
There are also situations where it makes things more explicit and clearer.
Let’s dig in!

# An example: a password input component

Say we want to create a very simple component that’s used to enter a password.
It has all the needed validations, and we’d like to use it throughout our app, wherever the user needs to enter a password.

Our first pass might look something like this:

```javascript
angular.module('app').component('passwordBox', {
  template: [
    '<input type=password ng-model="$ctrl.ngModel"',
       ' placeholder="{% raw %}{{ $ctrl.placeholder }}{% endraw %}">'
  ].join(''),
  bindings: {
    ngModel: '=',
    placeholder: '='
  }
});
```

This simply creates a password `input` element and allows us to specify a placeholder if it’s empty.

Here’s how you’d use it in a template:

```html
<password-box ng-model="$ctrl.password"
              placeholder="'Enter password'">
</password-box>
```

Pretty straightforward, but can you guess what’s bothering me?

The `placeholder` attribute will almost always be a simple string - why does every user of our component need to wrap it in quotes?
Are we saying it would also be acceptable to pass a non string value, like an object?
Surely not!

For exactly this purpose we have the `@` binding - it allows us to specify that we want to receive the *string value* of the attribute.

Changing the `bindings` definition in our component so `placeholder` uses `@` makes the password box component a bit slicker:

```html
<password-box ng-model="$ctrl.password"
              placeholder="Enter password">
</password-box>
```

Angular will now plainly take the value of the DOM attribute (which is always a string) and pass it along to our component.

# What if you need the string to be dynamic?

Just because we’re using `@` binding doesn’t mean we will always have to stick with static strings.
For example, we can make the placeholder dynamic:

```html
<password-box ng-model="$ctrl.password"
    placeholder="{% raw %}{{ $ctrl.user }}{% endraw %}'s password">
</password-box>
```

Angular will automatically interpolate that string whenever `$ctrl.user` changes, and that change will be reflected in our password box component!

This is a little gem in Angular that’s worth knowing: it allows us to write easier-to-use components, and provides explicitness.
*A win-win!*

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
