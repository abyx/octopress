---
layout: post
title: "The Performance Difference Between ng-bind and {{}}"
date: 2017-03-23 08:31:43 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Subscribe to get the latest about modern Angular 1.x"
cta_form: 186236
---

Interpolation is one of the first things newcomers to Angular learn.
You can’t get around writing your first Angular “Hello, World” without some sort of simple interpolation like `Hello, {% raw %}{{ $ctrl.name }}{% endraw %}`.

But, you may have come across the `ng-bind` directive, seen it used and realized it’s pretty much the same as straightforward interpolation.
The above example using `ng-bind` would look like this:


```html
Hello, <span ng-bind="$ctrl.name"></span>
```

Why do we have both `{% raw %}{{}}{% endraw %}` and `ng-bind`?  
Is there any reason to use one over the other?  
In this post we’ll see exactly what are the differences and why `ng-bind` is preferable.

# The original reason: Flash Of Unstyled Content

[FOUC](https://en.wikipedia.org/wiki/Flash_of_unstyled_content) is a term that’s been around for quite some time.
In Angular, it mostly refers to when a user might see a flash of a “raw” template, before Angular actually got to compiling it and handling it correctly.
This happens from time to time when using `{% raw %}{{ }}{% endraw %}` interpolation, since Angular has to go over the DOM, find these and actually evaluate the proper value to put in them.

It looks unprofessional and also might make non-technical people think there’s something wrong with the page.  

`ng-bind`, on the other hand, makes this a non-issue.
Since the directive operates as an element attribute, and not as the element’s text value, there’s nothing visible to the user before Angular finishes compiling the DOM.

This can also be circumvented using plain `{% raw %}{{ }}`{% endraw %} by using tricks like `ng-cloak`, but I always found those to be a hassle.

# The real reason: Performance

While it might seem like there’s no real reason to have a different performance impact if you’re writing `{% raw %}{{ $ctrl.hello }}{% endraw %}` or `<span ng-bind="$ctrl.hello  
"></span>`, *there is*.

If you’ve been following my posts for a while, this shouldn’t be the [first](http://codelord.net/2016/11/17/avoiding-ng-include-for-elegenace-and-performance/) [time](http://codelord.net/2015/07/28/angular-performance-ng-show-vs-ng-if/) you hear of a case where 2 things that seem like they should be pretty identical are actually very different when it comes to their run-time performance.

The thing is that when it needs to keep track of interpolated values, Angular will continuously re-evaluate the expression on each and every turn of the digest cycle, and re-render the displayed string, even if it has not changed.

This is opposed to `ng-bind`, where Angular places a regular watcher, and will render only when a value change has happened.
This can have a major impact on the performance of an app, since there is a significant difference in the time each way adds to the digest cycle.

In my benchmarks, I’ve seen it go as far as being *twice as fast* to use `ng-bind`.
You can see for yourself in these samples: [with interpolation](http://plnkr.co/edit/Vmx0wBaWSRXfoNkPZ2HU?p=preview) vs [using `ng-bind`](http://plnkr.co/edit/8OmX9r8VH6axfZv8Dgz7?p=preview) (and since these are basic interpolations, I wouldn’t be surprised the problem is worse for complicated expressions).

I’m not big for premature optimizations, but I do prefer sticking to a single way of doing things across a project.
That is why I usually opt for sticking with `ng-bind` from the start.

Happy hacking!

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
