---
layout: post
title: "ngAnimate Basics: Pure CSS ng-repeat Animations"
date: 2016-09-18 20:49:15 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 100873
---

Little touches of animation can make any app feel so much more slick, mature and responsive.
Adding animations, though, can be a PITA that involves making your tidy code messier.
Add this class, stop that animation, find the right DOM element.
Bleh.

Angular’s own `ngAnimate` can really save you a lot of work and keep your code clean.
But its documentation can be a bit hard to grok.

In this post you’ll see how in just a few lines of CSS you can add nice animations to your `ng-repeat`s, using `ngAnimate`.

# Setup

First, make sure that your app has `ngAnimate`, since it doesn’t come built-in with the vanilla angular.js file.
That means that you should probably add `angular-animate` to your dependencies manager, and make sure to add `'ngAnimate'` to your module’s list of dependencies (e.g. `angular.module('app', ['ngAnimate'])`.

# ngAnimate basics

The way ngAnimate works is that it has support for several scenarios which you can then add animations for.

In our examples, we’ll use its support for 2 `ng-repeat` events: enter and leave.
The enter event is triggered when a new element is being added to collection you are `ng-repeat`ing.
The leave event, surprisingly, triggers when an element has been removed.
(There are many more cases, like an element whose position changes in the collection, and support for `ng-show`, etc.)

To use these events with basic CSS animations, you need to handle 2 situations: once the event is starting to happen, and once the event has completed.

For example, let’s think about our enter event.
We will make it so that every element that gets added to our list will not just “pop” on screen, but instead will slowly appear by animating its height from 0 to the wanted size (kind of like jQuery’s slide animations).

So, at the triggering of the enter event we will add the CSS property `height: 0`, and at the end of the event (called “active” in ngAnimate) we will set the height to its regular size.

# Show me the code

Well, there’s actually not any real code, but some HTML and CSS.
Yeah, it’s that simple :)

Say our list gets rendered like so:

```html
<div class="slide" ng-repeat="item in $ctrl.list"
     ng-bind="item.name">
</div>
```

Notice that every element in the `ng-repeat` has the `slide` class.
Lets animate it:

```css
.slide {
  overflow: hidden;
  transition: 0.3s;
  height: 30px;
}
 
.slide.ng-enter {
  height: 0;
}
 
.slide.ng-enter.ng-enter-active {
  height: 30px;
}
```

As you can see, we set the regular CSS, and then handle the 2 states of the ngAnimate enter event: once it triggers the height is 0, and it slowly grows back to 30px.
The actual animation is done by the browser automatically, because we’ve set the `transition` CSS property.

It looks like this:

{% img /images/posts_images/ngAnimate.gif %}

That’s it, pretty simple right?
I’ll be writing soon about more advanced `ngAnimate` techniques.

You can play with an online example [here](https://plnkr.co/edit/s497ixyxerc73J23G1JI), which also shows the use of the leave event.

{% render_partial _posts/_partials/book_cta.markdown %}
