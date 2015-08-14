---
layout: post
title: "Spare Me Your Fake HTML Controls"
date: 2012-06-23 13:57
comments: true
---

If you spend as much time on the web as I do, you sure have been a victim of fake HTML controls abuse. Both as a user of websites and as a developer I've wasted time, effort and nerves on the trivial things getting harder just to make them a bit more _pretty_. I wanted to list all of the reasons these fake controls suck, which one can also treat as the list of things to pay attention to if you're inclined to write them anyway.

**Disclaimer:** Sometimes it makes sense to write your own control. If that text box is the holy grail of your site - by all means go crazy. I can't imagine Twitter of Facebook without their text areas being what they are. But please, don't inflict your fake control on us when all I want is to turn off your damn email notifications.

Most of the disadvantages I list here can be worked-around. The important thing is for us to understand these disadvantages and their cost. I've yet to see some plugin that gets all of these right.

## The prettiness vs. familiarity trade-off

Most of the times people use fake controls is because they want something "prettier", "shinier" or just more "web X.0"-y. While that might be the case, it comes with the cost of losing the familiarity the users of your site already have with the native controls they see every other place. If all of a sudden a checkbox doesn't look like the regular checkbox I always see on my IE but like a toggle on an iPhone I've never used I'm more likely to be confused than amused.

Also, it has to have the different states controls can have implemented and in such a way that I can quickly grasp. If I have to click to find out if your toggle is disabled or just off - you've lost.

## Reimplementing the wheel, poorly

You'd be surprised how hard it is to create a solid control such as a good drop-down list (select control). The people who wrote browsers worked very hard to make it work like it should work and like everyone expect it to work. Once you write one yourself you have to make sure it acts the same when I move between windows, click outside the element, resize windows, change zoom level, etc. What this basically means is that you'll somehow get it wrong eventually.

## Mobile support

There's a reason mobile phones and tablets implement some of the controls in a different manner - because they should. I find it hard to believe your own select control will work better than iOS's native one that allows me to scroll and pick efficiently and fast, regardless of the zoom I have on the page. In this age where mobile is everywhere and important, do you really want to tamper with your users' experience?

## Don't limit me

### Keyboard

If you're reading this, you wouldn't be surprised to know that there are a lot of people that use the keyboard quite extensively when surfing websites. For us, being able to navigate quickly using the keyboard and especially filling out forms is a big part of the user experience. If I can't tab between elements because they're not real elements, I can't press space to toggle a checkbox or don't see a nice native outline of the element I'm on - I'm basically being handicapped.

### Plugins and extensions

More and more people are using plugins and extensions. Be it to auto-fill passwords and forms or for making certain things look differently. Whatever control you have, you better have the real native control below so that jQuery plugins, bookmarklets and whatever comes can change your forms and with your fake elements catching up on that and displaying it correctly.

### Limiting developers

You as the developer probably also care about plugins as I've mentioned (because you want to use more plugins that make good stuff happen, and they need to interoperate with your pretty controls anyway). But don't forget there are more side-effects to rolling your own. For example, you will have to work harder to get trivial styling to work. CSS has really nice selectors like `:focus`, `:enabled`, `:checked` and more. When using fake elements you usually have to reimplement these yourself.

## Accessibility

Last issue, not because it is not important but because I admit I am ignorant in this matter. I know that native controls are something mostly supported for people with disabilities, and am sure your own fake ones won't work out of the box.


Keep all of these matters in mind, and please spare us from your fake controls unless we really really want them.

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed or [follow](http://twitter.com/avivby) me on twitter!
