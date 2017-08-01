---
layout: post
title: "Animating Transitions in 2 Minutes with ngAnimate and CSS"
date: 2016-09-26 12:09:58 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
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

{% render_partial _posts/_partials/book_cta.markdown %}
