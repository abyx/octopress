---
date: '2010-11-07 07:52:56'
layout: post
slug: refactoring-to-heaven
status: publish
title: Refactoring to Heaven
comments: true
wordpress_id: '254'
categories:
- pragprowrimo2010
- Programming
tags:
- clean code
- Programming
- software craftsmanship
---

My [last blog](/2010/11/06/refactoring-youre-doing-it-wrong/) was about how many people refer to refactoring as the wrong thing. For completeness of discussion I'd like to talk about what a lot of people seemed to not get in my previous post. I said that the 'Big Refactoring' is the new 'Big Redesign in the Sky', and got a bunch of questions along the linse of "so we're never supposed to redesign?"

Well, of course that's not the case. Even the best programmers occasionally dig themselves into a hole that will require some effort to get out of. The point is that the best thing to do is never to take those 2 days to 2 weeks period just for doing that refactoring. That is never the right approach to solve such a problem.

{% img /images/posts_images/stairway_to_heaven.jpg 300 225 %}

First of all, I've seen many times that it was intended to spend "only" 2 days (which is already a huge amount of time) to do some refactoring, but 2 days in, the dev team found it they actually need 2 more days because of extra complications they've got, and the team's lucky if after a week of hard work they still have a working system, not to mention better.

Another problem with that is, once the devs think they have a picture in mind of this perfect redesign that management won't let them take a week to get to (with good reason!), a lot developers stop thinking about how to make the current code better. It's just let's add this hack here, because management won't let us do this the right way. That's BS. Will you come to your dentist 3 days in a row for 'general groundwork' before have a 2 hour filling? I thought so.

Programming is about adding value. Don't get me wrong, I like writing elegant and clean code as much as the next guy (actually, probably a bit more given I walk around with one of [these](http://butunclebob.com/ArticleS.UncleBob.GreenWristBand)). But, what we're hired to do is solve problems and help someone's life by doing it. If all we do is bitch about how the design could be better, we're only benefiting ourselves, and not doing a good job at it.

So what is the right way? Well, the right way is to pull things off towards the right direction, in steady and controlled baby steps. I've seen this work, and I've heard from much better programmers than myself that they've got it working multiple times. After spending a day in an awesome [Responsive Design](http://www.threeriversinstitute.org/blog/?page_id=379) workshop by Kent Beck, I was a bit amazed to hear there are so many ways of pushing design towards a better place in baby steps. Up until that point I would have done it anyway, but Kent taught me there's actually an art to it.

Do you think it's impossible in your case because "X is too big"? Well, say you've got N steps in your redesign, all are safe atomic changes. Many of the times you might think the order of steps you've came up with simply won't do and it will be too hard to do it without the big blunder. But, think about it this way: Those N steps have N! (N-factorial) different ways to be ordered. What are the odds that none of those ways will solve your problem? I've yet to see when this is not the case (and this, among others, is why you should spend the time with better and more experienced coders, such as Kent).

Yes, it means that "2 day refactoring" of yours will probably be spread over 2 weeks (which is just might have done anyway). But it also means that no matter what happens during those 2 weeks, you're always on the safe side. Find out after 2 days that your idea simply won't cut it? Well, no biggie. The code still works, and you added features those 2 days. Find out it'll take longer? Yeah, so what. We're doing a few small steps a day anyway. The awesome thing is that you've got time to learn during the work what you may have thought up wrong and use that as input for the next parts of the refactoring. No rush here. And I think the most important point is that if you simply spend 30 minutes a day to refactor things at the right direction, weaved into your daily work and refactorings, you'll get it done without have to pitch your Big Redesign to management.

This allows you to simply do what you're supposed to do: add value to customers daily, while making sure the system stays responsive to future changes. And that, my friends, is how the big refactoring should be done.

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)
