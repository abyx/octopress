---
date: '2010-06-02 21:48:20'
layout: post
slug: case-study-refactoring-interfaces-with-tdded-tests
status: publish
title: 'Case Study: Refactoring Interfaces with TDDed Tests'
comments: true
wordpress_id: '190'
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

I've been practicing TDD for a couple of years now, and keep learning all the time.

In the past year I've been mainly working on a single project, the longest I've worked on a project with TDD. Putting aside how fun it is (TDD saved me quite a few times for me to be sure it's worthwhile), working on a project for so long I finally got to see some of the main problems people have against TDD.

With the hundreds of test you have, refactoring on the class-interface level (that is, the interfaces of classes, and not inside classes) can be problematic, with you having to update all the tests.

I'm still learning how to handle this efficiently, and would like to share an experience I had today. This is an example of a problem regarding 2 collaborators and an interface change. Such refactorings in a TDD environment weren't mentioned in the excellent "[TDD by Example](/2010/01/12/every-coder-should-read-tdd-by-example/)" book and similar works, so I'm pretty much guessing here.

The example:

{% gist 422831 %}

The change we're interested in is making "eject" simply open the lid, without rewinding, and making the rewind operation public. This is in order to allow LazyPerson to take the tape out, without having to wait.  Gary Bernhardt [wrote](http://blog.extracheese.org/2009/10/my-personal-failures-in-test-isolation.html) about this kind of changes a bit. I agree, the fact I need to make such a change is against the [OCP](http://en.wikipedia.org/wiki/Open/closed_principle). What can I say, I'm not perfect and made a design mistake. Saying "that's not OCP" doesn't help me - **I've got this code and tests, and I need to change them**.
 
I used to succumb to the temptation and make all the changes in one sweep. That means changing all the tests and the classes, then running the tests and hope they still pass. This, of course, is a crappy way of doing this. Had I been able to actually perform such tasks, I'd write less tests.  The secret is **baby steps**. The pressure Kent Beck puts on baby steps and gradually working towards change made me consider this and force myself to find a safe way of doing this.
 
I decided to start with the VCR and its test (the AutomaticPresenter doesn't use the VCR itself but an interface, and the tests use test doubles. This means changing one part won't break the other's unit tests).  The path to enlightenment lies in finding the baby step that allows starting the refactoring without breaking the rest of the tests. I decided to add a test for the should-now-be-public "rewind" operation, while not breaking the existing tests.
 
The solution is adding a default value for telling the "eject" function whether it should rewind or not. This means existing users (be them tests or not) will still get the previous behavior, and new tests can start work with the new interface (in Java I'd probably do this with method overloading): 

{% gist 422856 %}

This got me to green pretty fast. Now I can slowly remove every rewind-related assertion from the old tests and also add the "should_rewind=False" flag to them, all with quick-green cycles. And we're done with the first half.

The next move is to change the AutomaticPresenter to call "rewind" before "eject", which is now really easy to do in the tests. Once we hit green, we remove the "should_rewind" flag and be done with the refactoring. Baby steps save the day:

{% gist 422862 %}

Being able to get the refactoring working so easily makes me happy, but I'm still not sure this is the smartest way, and there are harder refactorings to master ahead. Yet, I hope this will help TDD adopters see that it's possible to handle refactorings even with many tests, because once the right baby-step is found, each test can take practically seconds to convert.

I'd really love getting feedback on this cycle.

You should subscribe to my [RSS](http://feeds.feedburner.com/TheCodeDump) feed or follow me on [twitter](http://www.twitter.com/avivby)!
