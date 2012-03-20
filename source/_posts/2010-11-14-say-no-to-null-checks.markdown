---
date: '2010-11-14 22:23:01'
layout: post
slug: say-no-to-null-checks
status: publish
title: Say No to Null Checks
comments: true
wordpress_id: '267'
categories:
- Programming
- testing
tags:
- clean code
- Programming
- software craftsmanship
- tdd
- testing
---

Hey, do you check your methods' arguments to make sure they're not null?




Today, I got into a little discussion with a teammate about testing contracts of methods: should we check for null in every public method?

I was against it, and he was for it.

The simple reasons to do it are, first, that it makes your code more defensive. You fail explicitly instead of failing implicitly when the code tries to dereference the null object. Another argument was that given 20 callers of an interface, it's easier to test in the interface for the precondition than to test each and every one of the callers. And, of course, that it is better API implementation, and that even if a class isn't part of one's public API now it might very well become part of it in the future, so why not add the tests now?

I'll tackle these all. First, I have to agree that some null checks are required, at the boundaries of your system. I believe a system should have a paranoid barrier, before it everything is as suspect as someone going on a bus with a heavy coat on a hot day - that's just waiting to blow. Once you've passed the barrier you know things are secure and no longer need to be paranoid.

So yes, some null checks are of course required.

But, because we want our API to be user-friendly and error-proof does that mean we need to make every public method in our code paranoid just in case it will become part of the public API at some point? 5 letters: YAGNI! :)

The interesting part is the testing of the callers. I agree, if we have to write the test 20 times for each caller, it will get tedious. But we don't write the same thing twice, do we? As good old J.B Rainsberger [teaches](http://blog.thecodewhisperer.com/post/207374113/who-tests-the-contract-tests), what we actually need are collaboration tests. Each of the callers collaborate with the interface. And so, we create a collaboration test that makes sure the user is using the interface according to the contract. These are usually abstract tests that require us to create derivatives that implement a factory method for creating the calling class. This way we write the tests only once and make explicit the interface and contract, even in dynamic language.

In general, this is a powerful solution, that solves a basic problem with defensive programming. Say we do test for nullity wherever possible, what do we do then? Our system is likely to crash or throw an exception any way, since what is the interface to do? Obviously something is wrong if we were called in a way that doesn't match the contract, so is the hassle worth it? I think testing for nullity everywhere is a thing of the past, especially once you adopt dynamic programming and get used to the fact that most of the times you can't even be sure the object you've got will answer the methods you're about to use, so what difference does a null check make?

So let's write some awesome collaboration tests tests and get cracking!

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!


