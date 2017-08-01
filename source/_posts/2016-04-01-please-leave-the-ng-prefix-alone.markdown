---
layout: post
title: "Please leave the ng prefix alone"
date: 2016-04-01 11:31:08 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
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

{% render_partial _posts/_partials/book_cta.markdown %}
