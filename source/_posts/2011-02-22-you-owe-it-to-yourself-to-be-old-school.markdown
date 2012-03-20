---
date: '2011-02-22 07:33:46'
layout: post
slug: you-owe-it-to-yourself-to-be-old-school
status: publish
title: You Owe it to Yourself to be Old-School
comments: true
wordpress_id: '335'
categories:
- Programming
tags:
- lowlevel
- oldschool
- Programming
---

I love watching House. My favorite episodes are those where he manages to debug an illness not by knowing an obscure desease, but by having the holistic knowledge of how the body works and thus being able to deduce the real problem.

I find this correlates very much to a set of tools and knowledge a lot of coders are missing that has tremendous value. Joel Spolsky [wrote years ago](http://www.joelonsoftware.com/articles/CollegeAdvice.html) that developers should learn C in order to have a thorough understanding of their environment. I actually think this should be taken a few notches further.

Learn C and some systems programming and you have the ability to grasp basics of most tools you use. How can you spot and truly understand memory leaks without having to manage memory allocation by yourself?

What would you do if some code you wrote or application you use suddenly simply blurts out it has a connection error? Or the Apache server you're installing is acting up on you? My #1 power tool for these situations is simply opening wireshark and look at what goes through my wire. Learn the basics of TCP/IP and you'll be able to debug most network problems swiftly.

And don't get me started on using the shell. No matter what you think, having shell-fu pays off daily. Any text manipulation you're thinking of, most simple processing tasks - you can whip up a oneliner to do it in less time than most IDEs take to start up.

And the reasons just go on and on. Reading important functions from the Linux kernel will help you understand why Java suddenly won't fork child processes. Knowing how known security issues work (injections, buffer overflows, etc.) is the only way for you to catch security mistakes at the drawing-on-the-board stage and not at the shit-the-DB-is-stolen stage.

I don't care if you're doing Rails and never need to see the outside of a pointer. There's nothing like having the holistic grasp of things to help you solve problems quickly, a-la Dirk Gently. All these points I've made in this post? All real problems solved in the last couple of months with some old-school chops.

Do yourself good - read [K&R](http://www.amazon.com/gp/product/0131103628?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0131103628)![](http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0131103628) for some C understanding. Read the first chapters of [TCP/IP Illustrated](http://www.amazon.com/gp/product/0201633469?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0201633469)![](http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0201633469). Read [Linux Kernel Development (3rd Edition)](http://www.amazon.com/gp/product/0672329468?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0672329468)![](http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0672329468) for a nice walk-through of the interesting parts. This knowledge won't get obsolete anytime soon. Can you say that about your favorite framework?

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
