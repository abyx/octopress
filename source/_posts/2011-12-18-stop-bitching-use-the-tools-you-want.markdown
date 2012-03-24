---
date: '2011-12-18 23:52:15'
layout: post
slug: stop-bitching-use-the-tools-you-want
status: publish
title: 'Stop Bitching: Use the Tools You Want'
comments: true
wordpress_id: '682'
categories:
- Programming
tags:
- autonomouscraftsmanshipcore
- pragmatic
- Programming
- software craftsmanship
---

Continuing on the thread of the [Autonomous Craftsmanship Core](http://www.codelord.net/tag/autonomouscraftsmanshipcore/), we reach another problem: "they" just won't let you use the right tool, or in the right way. As I've said in the [previous](http://www.codelord.net/2011/11/12/stop-bitching-the-autonomous-craftsmanship-core/) [posts](http://www.codelord.net/2011/11/28/stop-bitching-write-those-damn-tests/) if anything is _so_ bad you can't work with it - leave; otherwise, you gotta learn how to make do.

A [pragmatic programmer](http://www.amazon.com/gp/product/020161622X/ref=as_li_tf_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=020161622X)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=020161622X" style="width: 0; height: 0; display: none; border: none !important;"> uses the right tool for the job. We all know that if you have a hammer, every problem looks like a nail. In this post I'm talking about the situation where you have an awesome toolbox right _there_ and yet they're forcing you to unscrew something with your pinky's nail. Excruciating to your brain.

The thing is, a lot of the times you can just use the right tools and the hell with everyone else. Yes, you can't just write code in whatever programming language you want, but in a lot of other situations, you can do what you want to. I think this is best shown with a few examples:


### "Don't commit too much. Say once a day"


That's a real quote a friend's boss told him. Turns out committing multiple times a day is too messy. Most programmers might just sulk and do as they're told, but with today's technology you're no longer bound to these stupid rules. Your team uses subversion? So what! You can use Git locally, do whatever you like, and just push once a day everything via [git-svn](http://trac.parrot.org/parrot/wiki/git-svn-tutorial). Same solutions are available for just about any VCS combination you can think of! I've done this several times working on projects with a VCS I didn't want to mess with.


### "We can't have a CI server"


Why would someone be against that? Maybe your company doesn't want to allocate a new server for such a "useless" thing, or maybe the system admins don't have time for your little "developer toys." Lucky for everyone, it's no longer the case that you need complex setup for such stuff. It's just a matter of looking around. For example, if you're doing open source you just need to give [Travis](http://travis-ci.org/) a look and see you're suddenly all set. On the other hand if you're code isn't open sourced setting up a local [Jenkins](http://jenkins-ci.org/) server is _so so_ easy. You just double click a file and you've got it running. If your build isn't too CPU hogging, you can run it on your box! And I'm almost certain you can find some server with some spare cycles to install it on.


### Autonomous Craftsmen Make Do

{% img /images/posts_images/macgyver.jpg 300 200 %}

That sums it up. A craftsman's gotta do what a craftsman's gotta do.

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
