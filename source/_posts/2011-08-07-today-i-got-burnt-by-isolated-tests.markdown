---
date: '2011-08-07 23:06:26'
layout: post
slug: today-i-got-burnt-by-isolated-tests
status: publish
title: Today I Got Burnt by Isolated Tests
comments: true
wordpress_id: '440'
categories:
- Programming
- testing
- goos
- tdd
---

Generally, I prefer the [GOOS](http://www.amazon.com/gp/product/0321503627/ref=as_li_tf_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0321503627)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0321503627" style="width: 0; height: 0; display: none; border: none !important;"> school of TDD which includes isolating my classes as much as possible, putting mocks and stubs everywhere. Even though one of its known disadvantages is that you risk testing your classes in a fake environment that won't match the real production code using it, I've rarely come across a place where I got really bitten by it.

Today I set out with my pair to add some functionality to a certain class. That class had about 30-40 lines of code and about 10 test cases, which seemed quite decent. We added our changes TDD style and just couldn't get the thing working. After digging into it for a few more minutes we suddenly realized the class shouldn't be working at all and checking in the DB showed that indeed the last time that specific feature had any effect was 3 months ago!

Fortunately for us, all the problems that caused this bug are solved problems, we just need to get better at implementing the solutions:

Isolated tests go much better hand in hand with a few **_integration tests_** (some might say the right term is acceptance tests) that execute the whole system and make sure the features are working. Had we had those, we would have caught the bug much sooner.

The bug was introduced in a **_huge commit_** that changes 35 files and 1500 lines of code. We usually try and go over every commit made, even if it was paired, because we believe in collective code ownership, but it's impossible to go over such a huge diff and find these intricacies. Working in small baby steps makes it far less likely to break something and more likely that someone else will spot your mistakes. Huge refactorings give me the creeps.

After the change was committed, it was not **_followed-through_**: this specific feature is a feature you usually notice over a few days and we missed out on making sure it kept working. We moved on to other tasks and forgot all about it, thinking it was working all this time. Had we taken the time to make sure we were seeing, it would have been squashed by the next deployment.

Any of these would have helped us spot sooner that the isolated tests were actually testing the code against a scenario that never happens. These tiny changes of our workflow would have made several of our users happier over this timeframe.

Hopefully all is well now and the feature is back at 100%, but only time will tell whether we were able to learn from this mishap.

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
