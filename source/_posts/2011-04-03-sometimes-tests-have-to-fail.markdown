---
date: '2011-04-03 20:40:18'
layout: post
slug: sometimes-tests-have-to-fail
status: publish
title: Sometimes Tests Have to Fail
comments: true
wordpress_id: '376'
categories:
- Programming
- testing
tags:
- Programming
- tdd
- testing
---

A friend asked me about a common problem that pops up in real-world projects and testing: What do you do when you test code with random properties?

A simple example might be handing out jobs to a few workers. If your algorithm for doing that is random, you can usually assert that no one of 3 workers gets all 10 jobs, for example. But, being random, that assert should eventually fail. We'll assume that with the frequency the team runs the tests, a failure is expected every few days.

Surely no one wants to see the tests fail a couple times a week (especially if you're keeping score for who broke the build). On the other hand, you'd like to keep the tests. What is a pragmatic coder to do?

If you're not that meticulous to your suite rarely failing, you might just leave it as it is, which, I think, sucks.

The mega-tester's approach, which I've tried in the past, is usually to stub out the random number generator with values that make sure the failures won't happen. This is usually cost-effective only for the simplest of cases, and the more complex ones results in brittle tests that are coupled to the implementation and that might need to be changed frequently.

What I rather is to postpone the problem! Say we change our test's parameters to 10 workers and 3000 jobs. The chances of one worker getting all jobs becomes quite minor. This tweak of parameters in the test is usually simple to do and can guarantee quite a safety net.

And still, sometimes bad stuff happen. 64bit hash collisions are somewhere, out there in the world. If you're one of those guys that are bugged by that chance, I give you a simple JUnit rule that will retry a specific test in case it fails, making it twice as unlikely to fail. Those 64bit collisions are now more like 128bit! woohoo!

The rule allows you to simply annotate a test to make it retry in case it fails:

[gist id=897229 file=RetrierTest.java bump=1]

And the implementation is as simple as:

[gist id=897229 file=Retry.java bump=2]

[gist id=897229 file=RetryRule.java bump=3]

With the tests so unlikely to fail, I'd start a lottery at work for whoever breaks them.

Happy testing!

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
