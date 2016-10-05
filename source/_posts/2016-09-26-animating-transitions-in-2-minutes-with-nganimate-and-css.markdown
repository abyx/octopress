---
layout: post
title: "Animating Transitions in 2 Minutes with ngAnimate and CSS"
date: 2016-09-26 12:09:58 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 102317
---

In my [previous post](http://www.codelord.net/2016/09/18/nganimate-basics-pure-css-ng-repeat-animations/), which is a short introduction to ngAnimate, we saw how just including ngAnimate in a project and a dozen lines of CSS can add slick animations to `ng-repeat` easily.

That was a very simple use-case, and in this post I want to show you how you can use it to animate transitions inside any container you have, with about the same complexity!

# Our example, simple pagination

Say we have a regular component that displays a list.
It has basic pagination - we only display a fragment of the list and there’s a “next” button to move on to the next fragment.

Our animation-less component would look something like this:

```javascript
angular.module('app', ['ngAnimate']).component('parent', {
  template: [
    '<button ng-click="$ctrl.nextPage()">Next</button>',
    '<div class="container">',
      '<div class="page">',
        '<div ng-repeat="line in $ctrl.pages[$ctrl.currentPage]" 
              ng-bind="line.text"></div>',
      '</div>',
    '</div>'
  ].join(''),
  controller: function() {
    var self = this;

    this.currentPage = 0;
    this.pages = [
      // Here be pages of stuff...
    ];

    this.nextPage = function() {
      self.currentPage = (self.currentPage + 1) % self.pages.length;
    };
  }
});
```

Now if you’re following along you can see that this is basically Angular 101.
A simple component with a list of pages, and our template just displays that list with a little button to advance pages.
Nothing fancy.

At this point we are sans-animation.
Pressing the “next” button would instantly swap the contents of the page.

Not the best UX in the world, right?

# Introducing ng-animate-swap

`ng-animate-swap` is a nifty little directive that’s part of `ngAnimate` (full docs [here](https://docs.angularjs.org/api/ngAnimate/directive/ngAnimateSwap)).
What it does is… well… animate when you swap things!

Where in the previous post we saw how `ngAnimate` adds events to a set of situations it knows (e.g. `leave`, `enter` and `move` for `ng-repeat`), `ng-animate-swap` allows us to add `leave` and `enter` events to any DOM element!

You do it by passing `ng-animate-swap` an expression to watch for.
Whenever that expression changes, it will trigger the animation to swap the container from the previous state to the new one.

In our case, we would like to swap the element with the `page` class, so it will animate whenever you move between pages.

The line we change in the template, after the changes, looks like this:

```html
<div class="page" ng-animate-swap="$ctrl.currentPage">
```

Pretty simple, right?
We tell `ng-animate-swap` to listen for page changes.

Now, with a dozen or so lines of CSS we’ll add a basic animation and, *voila*, here’s your slick animation:

{% img /images/posts_images/ngAnimateSwap.gif %}

I won’t go into the CSS in this post, but you can see if for yourself, along with a live example, [here](http://plnkr.co/edit/0Uz9R7Ak3dwHHE8bOyLg).

With basically no JavaScript changes and very minimal template changes, `ngAnimate` gives us a lot of power to add animations to our apps.

Keep that in mind the next time you need to spice a screen up a little.

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
