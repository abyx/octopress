---
date: '2010-02-16 08:41:35'
layout: post
slug: stop-coding-in-the-middle-ages
status: publish
title: Stop Coding in the Middle Ages
comments: true
wordpress_id: '126'
categories:
- Programming
tags:
- Programming
- tips
---

Aren't you sick of wasting your time, your team's time and precious build cycles for finding the stupidest mistakes ever? I know I'm far more interested in solving the real problems at hand than chasing stupid syntax errors. And even if you don't mind, you really shouldn't let your teammates substitute for a decent tool.

Up until 15 years ago, I think it was very common for people to hack away at code for a good length of time, and once they got enough done, they'd try and compile the damn thing and start correcting the syntax errors, import things they forgot to, etc. This probably was because 15 years ago is the middle ages in computer-land, and compiling constantly was something people couldn't even dream about on the little PCs we used to code on.

Nowadays, you can't find more than a handful of static-language coders that won't use a full featured IDE. C, Java, C# - other than a few freaky kernel hackers, I doubt anyone does real development outside an IDE in those languages. Today's IDEs will tell you that you made a mistake about 2 seconds before you did. I never stop being amazed at how smart Eclipse is - and the first time I had to whip up some Java code in Vim, I felt handicapped.

What I find puzzling, is that people that are using the best available languages today, have suddenly decided that using the proper tool isn't that important. Dynamic languages like Python and Ruby are not as easy to write awesome IDEs for, and therefore there aren't many around that are mature enough, which is why it's very common to see people use Emacs/Vim for coding them. Now don't get me wrong, I've tried a few Python IDEs, but I'm still sticking with my Emacs. But when you use dynamic languages, you have to keep in mind you are even more prone of errors that will slip by. Even if you TDD, and your test coverage is extremely high, a typo might still get past your tests. Do you really want a production failure because you forgot to import an exception? (And do you really want to [upset Agnes](http://bit.ly/cKRZAK)?)

About 2 weeks into my decision to stick with Emacs I started searching for simple tools that will protect me from my stupidity. It takes 10 minutes to find and install flymake with pyflakes (Python tool) support. Presto! No more typos in variable names, no more useless imports lying around. What surprised me is that a lot of my teammates, which I have respect for and are good programmers, did not use any of these. Time and time again our continuous integration system will report an error on a file and once I opened the file Emacs would show me the bad line marked with red, with no way of not noticing it.

I don't like wasting my time, and I'm sure you don't either. Stop being lazy (in the bad way). Stop making me angry. Get out of the middle ages. Yesterday we got everyone on my team to add pyflakes to their vim. Took 3 minutes to install. The problem is that it took more time to get them to install. "Nah, Vim already highlights syntax, there's no need for more". Oh really? After 10 minutes of searching I found a file that pyflakes showed a real problem in, and another, and another. "Hmmm, where do I download that plugin?" Win!

Do yourself, your team and your build slaves a favor, and start using some modern tools. I promise it will be worth it, money-back-guarantee. And remember, if your team is still churning butter, [sometimes all it takes is a little push](http://www.codelord.net/2009/04/04/sometimes-all-it-takes-is-a-little-push/) (and sometimes you can plant bugs in their files).

You should follow me on [twitter](http://bit.ly/aU2CaB).
