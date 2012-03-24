---
date: '2011-03-30 06:40:49'
layout: post
slug: design-is-simpler-now-embrace-the-extract
status: publish
title: 'Design is Simpler Now: Embrace the Extract'
comments: true
wordpress_id: '365'
categories:
- Programming
- DRY
- goos
- OOD
- SOLID
---

For the past 5 years or so I've been searching for ways to produce better designed code. I hate the fact I basically can't put my finger on why certain designs aren't as good as others.

That's why I was really blown away when I first learned about the [SOLID](http://www.amazon.com/gp/product/0135974445/ref=as_li_tf_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0135974445)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0135974445" style="width: 0; height: 0; display: none; border: none !important;"> principles and started practicing [TDD](http://www.amazon.com/gp/product/0321146530/ref=as_li_tf_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0321146530)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0321146530" style="width: 0; height: 0; display: none; border: none !important;">. At last I have found rules that gave me the capability to weigh designs, and a process that helped push me towards what feels like better code.

But even 5 rules were too much for me!

SOLID, no doubt, drives better design. My problem was incorporating it natively with my every day coding. Call me dumb, but I just can't bring myself to contemplate 5 different aspects whenever I whip up a class. I still find it as an excellent checklist to go through when I'm considering refactorings, but thinking about it constantly just drained a big part of my concentration.

For a few months now I've been getting the feeling that my OOD toolset has reduced quite a lot to the very essence. That feeling was also magnified by reading [GOOS](http://www.amazon.com/gp/product/0321503627/ref=as_li_tf_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0321503627)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0321503627" style="width: 0; height: 0; display: none; border: none !important;"> and pretty much everything written by [J. B. Rainsberger](http://twitter.com/jbrains) [here](http://jbrains.ca) and [here](http://blog.thecodewhisperer.com/).

The first tool I use heavily (and I mean heavily, my mind has managed to get OCD about it) is duplication - or DRY. This tool alone makes any codebase a magnitude better. I've [written plenty](/category/dry/) about DRY before.

But, just yesterday I realized that other than that, I mainly concentrate on one thing, as I contemplated on [twitter](http://twitter.com/#!/avivby/status/52471700167737344):


> I think I can sum up all my OOD skills with "wait, shouldn't this be in a different class/method?" Wondering if that's a good thing...


Yup, that's the trick. I was quickly assured by two amazing guys that have been doing this longer than I've been breathing, agile manifesto authors:


> [Ron Jeffries](http://twitter.com/#!/RonJeffries/status/52476402167066625): Yes it is a good thing. I would suspect you also note duplication?




> [James Grenning](http://twitter.com/#!/jwgrenning/status/52472057719558144): Think of the alternative.. you are asking the right question


You see that? Noticing duplication and moving stuff somewhere else. That's all there's to it. This simple question directs at you the Single Responsibility Principle and generally, along with DRY, covers most of the bases needed to adhere to the [elements of simple design](http://www.jbrains.ca/permalink/the-four-elements-of-simple-design).

The main question I ask myself now every time I think of a problem, start changing a function, write a test, and at just about anytime I'm coding is "is this the right place for this?" And quite often the answer is "no." Push this forward and beautiful designs show up, designs of short, cohesive classes. So, to sum it up: _**Embrace the Extract**_.

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
