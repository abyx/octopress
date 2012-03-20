---
date: '2010-11-04 20:11:38'
layout: post
slug: dry-dont-get-trigger-happy
status: publish
title: 'DRY: Don''t Get Trigger Happy'
comments: true
wordpress_id: '243'
categories:
- pragprowrimo2010
tags:
- clean code
- DRY
- Programming
- software craftsmanship
---

Once you've started to assimilate DRY into your regular routine, it usually becomes addictive. The feedback loop constructed of removing moving parts, making stuff clearer and reducing chances of error simply gets you into a certain rhythm that's hard to get enough of.

The problem is, that as with any skill, you have to learn to master even the corner cases and not just blindly follow a mantra. Following a mantra is good enough for starting everything, but there comes a time you have to experience and understand for yourself when using a rule of thumb is a good idea and when it isn't. So, let's now talk about the 'Ha' part of the [ShuHaRi](http://en.wikipedia.org/wiki/Shuhari) cycle in DRY.

We know that duplicate code is a code smell and a DRY violation that needs to be removed. But, as with any rule, it has exceptions. Taking the dumb example, look at this piece of code:


 
In the snippet above you can see the value '0' referenced twice. Is that a DRY violation? I'm sure you'll agree it isn't. After all, even though it is the same value that appears multiple times syntacticly, it has a different meaning semantically. The first zero is an initialization value and the other seems to indicate bad values in the array. The fact that they both are zero is meaningless and a coincidence. It might very well be that the next version will mark bad values as 'null', which surely shouldn't change the way the array index is initialized.  OK, so that was an easy one. Let's look at this next snippet, taking from some code whipped up solve the Game of Life:
 


In that example, 2 appears twice also. Is that a DRY violation? After being in a [code retreat](http://www.codelord.net/2010/05/10/notes-from-the-first-israeli-code-retreat/), and hearing from other code retreaters, I understand that many people that try and focus on DRY think that is in fact a DRY violation. After all, both occurrences refer to the number of living neighbours a cell has and the number is part of the rules of the problem domain. But, let's give this a bit more thought. Although both instances of 2 reference a rule of the game, they reference _different_ rules of the game. Semantically, they are different. If we decide to change the minimal number of neighbours for a cell to stay alive it does not mean we will want to change the number of neighbours it takes to bring a cell to life.

I hope you're catching my train of thought here. Now let's look at another example. This is a snippet of code one might get to while doing the famous Bowling Kata:


 
This snippet adds the current frame's score to the total score of the bowling game, taking into account whether the frame has a strike, a spare, or is a 'simple' frame. Now, you might notice there is some "duplication" here. I can tell you that when I started refactoring this code to make it look better, I had to think a bit whether the calculation of the score in the first branch and the second branch should be extracted to be the same method.
 But again, this is a mere textual duplication, and not a violation of real DRY, which is duplication of _intent_. The first one takes the score of the strike frame itself and adds the strike bonus (2 next rolls), the other takes the score of the spare frame and adds the spare bonus (1 next roll), so even though it takes the same additions, it is not the same logic. The better way is of course this:  

This is a tricky one, and if you noticed it before reading give yourself a pat on the back! If you start and refactor this with an IDE, most IDEs will actually make a bit of a mess for you here, because they usually try and replace same occurrences of code once you extract a method, but here that would not be the better choice. Always keep an eye on your refactoring tools, because they, unlike you, can't tell the difference between syntactic duplication and semantic duplication!

The big money of DRY comes when you learn to tell the difference between duplication of intent and mere duplication of text. This simple rule for judging your code helps you understand your code better, simply by making you actively consider what your real intention is.

I've written more about DRY [here](http://www.codelord.net/2010/11/03/taking-dry-further/) and [here](http://www.codelord.net/2010/11/02/short-intro-to-dry/) if you'd like to hear more.

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
