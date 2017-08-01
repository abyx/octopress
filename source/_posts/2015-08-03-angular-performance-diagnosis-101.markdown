---
layout: post
title: "Angular Performance Diagnosis 101"
date: 2015-08-03 23:42:51 +0300
comments: true
facebook:
    image: /images/posts_images/angular-performance.png
---

Angular can feel magical but it is not a magic bullet. That magic comes with a cost, and that cost sometimes means slow/laggy apps.

Once you’ve noticed that some parts of your Angular app have performance problems, the hardest part is pinning down what exactly is causing the problem.

Let’s see how you might start tackling this gnarly problem:

## First, take a look around your app

Before diving head first into your problem, I find it useful to take a few minutes to roam around my app to get a *feel* for its behavior all across. This helps realize the scope of your issues and where they are most painful.

Just go ahead and use your app a bit, checking different screens that use different widgets and modules. While doing it try to notice if you see performance differences in certain areas. Also, I find it priceless to do with exploration while having [**ng-stats**](https://github.com/kentcdodds/ng-stats) open. It’s a super nifty code snippet that lets you easily see how long your digests are taking and the number of watchers currently in your app.

Doing this makes it easier to understand what’s your “baseline” performance - what’s the minimal number of watchers a page has, what is a high number of watchers for you, where are your digests taking too long.

## Understanding your performance problem

Now, let’s try and understand what kind of performance problem exactly you’re facing.

### Load/initialization vs. general slowness

Is your problem that some view takes too long to load or render? Or is it more an issue that everything feels clunky in that view, e.g. typing in inputs has some delay to it, or clicks feel like they take time to “work”?

Load time problems are, a lot of the time, not Angular specific. For example, if you’re waiting to fetch thousands of elements from the server and then list all those elements on screen, you’re gonna have things be slow sometimes even if you do it in vanilla JavaScript. Face it. 

In those situations you should probably look into the general ways we’ve been treating these problems in the web for decades, like pagination (or infinite scrolling, etc.).

But, in case that the overall experience of using your app feels laggy, you might have to do some fine tuning of your Angular code to make it play well with others. Can you see slowness go with long digest cycles or areas with lots of watchers? That’s probably it.

### Everywhere vs. specific screens

Is the slowness you’re seeing across the whole app or just in some specific screens, when there’s a certain widget being used, etc.?

If you can say the issue is only in part of your app you’re in good shape. It’s time to start zooming in on that slow part and inspect it to find suspects. Sometimes I just start commenting parts out till the problem goes away - it sounds stupid but a lot of times it helps me pin point the bad parts super quickly.

In cases where the slowness is all around you should look at the more general things: do you have too many things on your root scope causing a lot of watches? Might you be using some widget/plugin/foo that’s adding a lot of cost?

## Some potential tricks to make things faster

A few basic tricks that you should probably know once your Angular project gets big enough:

- If you have a big `ng-repeat` sometimes [adding "track by"](http://www.codelord.net/2014/04/15/improving-ng-repeat-performance-with-track-by/) can speed things up significantly.
- If you list is still slow you might want to look into virtualization, like using [ui-grid](http://ui-grid.info).
- Minimize the number of watches in general, for example replacing `ng-show` and `ng-hide` with `ng-if` sometimes [improves performance noticeably](http://www.codelord.net/2015/07/28/angular-performance-ng-show-vs-ng-if/).
- Reduce the amount of deep watches your perform where possible - can you use regular watches, or `$watchCollection` etc.?
- Using [events on scopes](http://www.codelord.net/2015/05/04/angularjs-notifying-about-changes-from-services-to-controllers/) can be a performance issue in deep scope hierarchies.
- Reduce the number of watchers by making those watches that don't change use the [bind-once syntax](http://swirlycheetah.com/native-bind-once-in-angularjs-1-3/).

## Measure twice, optimize once

Most important is to make sure you’re not doing these changes *blind*. Make sure to measure the effectiveness of your optimizations. You’d be surprised how easy it is to go through a lot of hoops just to realize that you actually didn’t make performance any better (or at least not in a way that makes the optimization worth it).

The easiest way is to get a feel for your improvements by checking it out with ng-stats and similar tools, but the best would probably be to have code that repeatedly calls digest and measures the time it takes in certain scenarios. Some people even create a performance test suite that checks that things aren’t getting too slow over time. I hope to write more about this soon.

That's it for now. May your digests be always fast!

{% render_partial _posts/_partials/book_cta.markdown %}
