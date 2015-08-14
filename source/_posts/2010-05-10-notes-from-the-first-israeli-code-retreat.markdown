---
date: '2010-05-10 18:12:52'
layout: post
slug: notes-from-the-first-israeli-code-retreat
status: publish
title: Notes From the (First?) Israeli Code Retreat
comments: true
wordpress_id: '173'
---

Today I had the honor of running a Code Retreat right here in our little country.

A [Code Retreat](http://www.coderetreat.com/) is a concept that was born in the beginning of 2009. It's a day that consists of a bunch of programmers working in pairs about a problem - a session is 40 minutes long and after each pairs rotate and the start from scratch.

This code retreat was a bit special. It wasn't a public one. My previous employer liked the concept and I was asked to help with running one for some of their coders. The group consisted of 15 coders that are in the company at least 2 years.

Most of the people don't pair at work and none TDD (only some unit test). Because of this we've decided before starting not to make TDD a must, but introduce it and encourage trying it out.

One of the things that surprised me was that after 3 sessions, some people asked if it was possible to get a different exercise. I haven't heard of a code retreat with more than 1 exercise and I'm puzzled why this team has brought this up. Currently, my only guess is that the Israeli temper and to-the-point attitude ("Dugri" or "Takhles" in Hebrew)  caused it (even though there were many wicked implementation ideas running around). I'm still not sure giving them another option was a good thing, as I believe squeezing more ideas from one exercise is where things get really interesting (and some preferred staying with the original one).

Another point was that some people said they would have appreciated more structure/direction - what to do in each session and getting a list of implementation ideas for Game of Life.

We were also asked for longer sessions - 40 minutes felt like too little and our single 50 minutes session felt more like it.

A bit unsurprisingly, when we performed the [String Calculator Kata](http://bit.ly/aSwMdV) to demonstrate some TDD, most people thought this was going overboard with tests for such a simple thing. I hope some got the message and I think that the fact we actually had bugs caught instantly by the tests helped!

To sum it up, I think that all-in-all people had a good time. I practically had to pull some from the keyboard at the end of sessions. Can't wait for the next one! I'm thinking of getting a bunch of [Clean Code wrist bands](http://bit.ly/aPug4e) to give away.

For future reference, here's the list of [Game of Life](http://bit.ly/cePVyl) ideas people have tried:

  * Cell centered
  * Board/Universe centered
  * if-less (as possible)
  * Uber-threaded (each cell is a thread)
  * Performance-centered (board is a byte array)
  * Focus on the neighboring-connection (the "lines" between cells)
  * Implement in a few different languages and their idioms (we had Java, Python and some C)
  * Different topologies (hive-like and 3D)
  * Calculate results by hashing certain parts of the universe and the expected results for them

And, the second problem that was given is the Poker Hands Kata:

  * Go through the cards and seek the best hand
  * After each card is added to the hand, hand-types that are no more possible are removed
  * Encode the hand as a 64bit number, and then find better hand by subtracting the numbers

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
