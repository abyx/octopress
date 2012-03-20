---
date: '2008-07-09 19:27:20'
layout: post
slug: dont-write-voodoo-code
status: publish
title: Don't Write Voodoo Code!
comments: true
wordpress_id: '6'
categories:
- Programming
---

Recently I started the process of handing one of my projects to a new programmer. The guy's OK and has talent, but is very inexperienced and hasn't had a chance to write real, production-quality code.

My general approach is usually talking about the purpose of the project, then architecture. Afterwards I talk about the purposes of the main parts in the design and then leave the guy to do a bit of digging.

Now, the time has come for the part that does _really_ makes you understand what's going on. I've given him a relatively small piece of work. How small? I guess it requires writing 4 new classes (2 plain objects and 2 real ones) that would take about 200 lines of code and modifying about 3 classes that already exist.

The guy started working on his solution when he asked me something to the lines of "which value should I return here? This one or that?" He was working with one of our tool-kit's interfaces that I saw no reason for him to use. "Why are you using it?", I asked. "_Uhhh... Hmmm..._". **Ding!** A warning sign had popped in my head.

After a little questioning I found out that he searched for places in the code that were doing something similar and used that code too. He thought I was going to give him the usual "don't copy and paste code" talk and said "Yeah, I know, code reuse! I'll refactor it so I won't need to copy it!" The problem was waaay beyond that.

![Voodoo Doll](http://cache.spreadshirt.net/users/1000/1/motives/489/1_573489_huge.jpg)

The real problem is **you should know what every line of your code does**. That's it. The interface he was using was totally irrelevant to the problem at hand, but because he saw it used he implemented it too. At first he didn't get why it's such a big deal. Only about 3 lines of code. I had to sit down with him and explain how hard it would be for someone else (or even himself a while from now) to try and understand and change that code. I've had the chance of seeing lines of code and asking myself "What the heck is this for?" That's the worst thing that can happen to you. You now have voodoo code - can you delete it? Can you change it? Heck knows, especially if the test suite isn't solid enough. And besides, a good programmer should be in control of what he's doing and repeatedly ask himself "why?". Why am I doing this? Why is this feature needed? Why am I catching this exception? Why why why. I think that's probably the best way to leave great code behind.

So, that's my point. Write what you understand, know what your code does.

Oh, and especially in cases like these - code review! See? Those are 2 lessons for the price of one.
