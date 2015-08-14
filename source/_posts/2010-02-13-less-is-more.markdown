---
date: '2010-02-13 23:42:02'
layout: post
slug: less-is-more
status: publish
title: Less Code is More
comments: true
wordpress_id: '118'
---

As coders, we should always strive to get as much feedback as soon as possible. Agile tells us we should get frequent feedback from our customers in order to make sure we're always on track. Unit testing and the green-bar loving are all about knowing exactly when your code breaks and when you're safe.

A kind of activity for which feedback is harder to get is our design. A big part of TDD is refactoring frequently. Refactoring often allows us to smooth out the design continuously as we work. The problem is, how can you tell you've done something good? On the one hand, creating abstractions is something good programmers do. On the other hand, taking that too far will usually cause more problems.

When making bigger changes, the best feedback will be from getting another pair of eyeballs go over the change. Pairing is the best way for getting a second opinion. Code reviews can be effective too. Problem is, a lot of people don't get to pair or review most of their code (and yeah, I know that [makes Corey Haines a sad panda](http://bit.ly/aSClmK)).

When I work by myself about the bigger things, there's a handful of things I try to keep in mind, like the [SOLID principles](http://bit.ly/bs003B). But, the measure I like the most of how much shorter am I making the code. I'm not talking about obfuscating code. Readability is a must. I'm talking about abstractions that are really useful right now - they already make the code base smaller. Refactorings that make the code [DRY](http://bit.ly/dizkHM) and thus shorter.

{% img /images/posts_images/delete_key.jpg 150 150 Delete key %}

Whenever I commit and git tells me I deleted more code than I inserted I get this fuzzy warm feeling. One of the [agile manifesto principles](http://bit.ly/cPw2Nr) says "Simplicity - the art of maximizing the amount of work not done - is essential". Problem is I'm not a perfect coder, and because of that I often perform more work than necessary. But I try to simplify my code when I notice this.

Paul Graham has an [essay](http://bit.ly/ae8RfK) where he once showed a way for him to know he's making good progress with Arc, the language he created. He kept track of the number of lines it took him to implement an application (Hacker News) and whenever he made some changes he checked to see if they made the application simpler.

Of course, as any rule, this one has exceptions. Eventually, you will need to add code! But, it always helps me see that what I thought was really good just adds clutter. Try and take a look at the output of `git log --shortstat` - do you tend to add more lines whenever you clean up?

You should follow me on [twitter](http://bit.ly/aU2CaB)!
