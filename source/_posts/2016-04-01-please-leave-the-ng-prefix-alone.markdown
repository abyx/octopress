---
layout: post
title: "Please leave the ng prefix alone"
date: 2016-04-01 11:31:08 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 37874
---

This might be obvious to the Angular veterans here, but I keep coming across this.
*Every* time that I go through a new Angular codebase I find at least one directive or service that uses the `ng` prefix in its name.

And really, we can’t blame people for doing this since when you’re just starting with Angular use keep seeing `ng-this` and `ng-that`.
How is a newcomer supposed to know any better?

But please, *stop*.
And if you have any of these remaining in your codebase, take an hour and rename it, for the love of all that is holy.

## The ng prefix is reserved for Angular’s own stuff

Yes, it’s theirs.
And we’re lucky they use a prefix, because it makes it easier to spot what is part of the standard library and what isn’t.

At least, it’s easy as long as you don’t *shove your own stuff there*.

There also so many default directives that there’s no chance you know all of them and it’s very easy to clash with some existing stuff.
So please don’t.

There are open source libraries that still misuse the prefix, but the numbers are dwindling.

A very prominent example is ng-grid which has been renamed to ui-grid.

## You don’t even have to use a prefix

I’ve seen lots of projects (not libraries) that do just fine without prefixes.
But even if you decide to use one, just pick a different one.
Here, you can use `fj`.
It’s easy to type.
Have a blast!

<hr>

Do you have a big *Angular 1.x app* that you're scared will *rot and become legacy code*? Because 2.0 and TypeScript will soon be *the new shiny* yet you have *all this JS code* sitting there? Where will your team find the time, and *management approval*, to learn and move things to 2.0?

But what if you could *migrate your project*, incrementally, while keeping your time's pace and shipping awesome code? What if your team could learn a bit more Angular 2 with each task? Imagine you could get to be *working in 2.0 land without ever stopping your development*!

I'm cooking up a self-served course that will get you there. It will allow you, *on your own pace*, learn Angular 2 and TypeScript bit by bit. With those steps your team will migrate your project and soon you'll write all your new code with Angular 2, TypeScript, and *won't have to stay behind*.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
