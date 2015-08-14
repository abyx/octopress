---
date: '2011-04-01 06:45:32'
layout: post
slug: testing-techniques-managing-external-resources
status: publish
title: 'Testing Techniques: Managing External Resources'
comments: true
wordpress_id: '372'
categories:
- tdd
---

A friend approached me with one of the known problems in the testing world - How do you keep external resources under a test harness? Having heard the question a few times before, I thought I'd share my thoughts, and mainly put together the common advice that drifts around the web.


### The Dilemma


Nowadays, it's hard to get more than a 100 lines of code before adding an external resource to our code. It might be a web service to manage something, or some convoluted API to receive data from or just about anything. Usually, writing tests for code that directly talks with these resources using the resources themselves is very problematic, for numerous reasons:



	
  * It significantly slows the tests, because it requires network access and processing on the service's side.

	
  * It might cost you money, send emails, tweet stuff and do things you'd rather not do 300 times a day as you run your tests.

	
  * Making your code handle error conditions with the service is hard or impossible, as you can't control when those occur.


Basically, all of these factors usually amount up to you having crappy tests that you rarely run. That sucks.


### Decouple & Isolate


The best solution I'm aware of is simply isolating the thing. We usually strive to wrap whatever service we're using with a single-point interface. The decoupling is great since I've yet to encounter a service with an API that matched my thinking of the domain problem. Wrapping it up allows us to keep using our own language and logic throughout the system.

A benefit of that is we now have a simple interface or facade we need to stub/mock out during tests. That's usually relatively easy, and allows us to run our tests blazingly fast and test all those hard to reach to corner cases.


### But what if the service changes?


That's the finishing touch. You should still maintain a suite of tests that run against the real service. Those should be the plain tests that make sure you're using the API right and that would break if anything you're relying on changes. These tests won't be part of your regular suite that gets run constantly. Instead have your CI server run them daily/weekly and let you know when something changes.

This puts us basically in a win-win situation, with us being able to run our tests quickly and yet have the assurance that we won't miss API changes and the likes.

Happy testing!

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
