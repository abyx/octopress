---
date: '2012-03-01 08:01:16'
layout: post
slug: notes-from-the-agile-practitioners-2012-improving-your-tdd-workshop
status: publish
title: Notes from the Agile Practitioners 2012 Improving Your TDD Workshop
comments: true
wordpress_id: '745'
categories:
- Programming
tags:
- agile
- software craftsmanship
- tdd
- testing
---

{% blockquote Corey Haines, Improving Your TDD %}
If you write a test and it passes, the question is if the previous step was too big.
The DRY principle doesn't talk about code, but knowledge.
Clever is never something to be proud of in your code.
{% endblockquote %}

A couple of days after [attending the code retreat](http://www.codelord.net/2012/02/28/notes-from-the-israeli-software-craftsmanship-group-code-retreat/) facilitated by him, I was fortunate to attend Corey Haines's “[Improving Your TDD](http://agilepractitioners2012.com/conference-program/corey-haines-improving-your-tdd/)” workshop at the [Agile Practitioners 2012](http://agilepractitioners2012.com/) conference. These are some of my notes from the day.

The workshop was intended at coders familiar with TDD and not introductory. I was very interested to see how in-depth TDD training looks, and also meet other coders from Israel that have been doing TDD for a few years. It was quite awesome to sit in a room where everyone felt comfortable with TDD and it wasn't this new and hard thing. When the group shares this "advanced" technique, discussion can suddenly level up and we could all dive in to the nitty gritty stuff.

During the day, Corey walked us through pretty much taking TDD apart and putting it back together. We started from the history of TDD and its predecessors (manual verification, test after, test first, etc.).

The exercises throughout the day (that I especially enjoyed since I was pairing with [@theyonibomber](http://twitter.com/theyonibomber), my original pair as we were learning TDD together back in 2006) had this beautiful flow of making you smack right into a problem in the way most people do TDD.

We discussed having the tests drive an implementation that we knew we did not want (like sorting easily become bubble sort) and how the (relatively new) [Transformation Priority Premise](http://cleancoder.posterous.com/the-transformation-priority-premise) by Uncle Bob can help solve this.

We then took another introspective look at our TDD process (aided by an exercise once more) that made us face the problem of "flailing" and "sitting in red" - basically the problem of trying to take a step too big in the next test and so falling off the good fast rhythm of "[time to green](http://programmingtour.blogspot.com/2009/03/time-to-green-graphs-with-gary.html)".

We had a long discussion about these problems and how they are directly connected to the way we pick the next test. We all know that the next test should be the "simplest thing", but how exactly do we define simple?

I love having these discussions that jolt me and make me rethinks stuff I've long ago stopped paying attention to. Developer introspection is a thing of beauty and much power (Kent Beck tells that he wrote his incredible [Smalltalk Best Practice Patterns](http://www.amazon.com/gp/product/013476904X/ref=as_li_ss_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=013476904X)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=013476904X" style="width: 0; height: 0; display: none; border: none !important;"/> and [Implementation Patterns](http://www.amazon.com/gp/product/0321413091/ref=as_li_ss_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0321413091) <img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0321413091" style="width: 0; height: 0; display: none; border: none !important;"/>  books by simply stopping whenever he was about to type some code and have an explanation as to why he picked to do it that way).

Corey even did a live demo of his TDD style and programming by wishful thinking. It was very interesting, but as all live demos go he had some trouble along the way. Workshop aside, it is not trivial for someone giving a training to admit a mistake done, and Corey gracefully handled the situation.

All in all, the day was a very productive one and it still has me chewing on some of the lessons we learned. It's fun realizing again that there's no limit to how much one can sharpen a specific skill. Hat off to Corey and the conference organizers for making this happen!

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed or [follow](http://twitter.com/avivby) me on twitter!
