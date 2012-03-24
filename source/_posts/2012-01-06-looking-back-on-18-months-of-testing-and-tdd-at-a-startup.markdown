---
date: '2012-01-06 22:34:25'
layout: post
slug: looking-back-on-18-months-of-testing-and-tdd-at-a-startup
status: publish
title: Looking Back on 18 months of Testing and TDD at a Startup
comments: true
wordpress_id: '701'
categories:
- Programming
- testing
tags:
- billguard
- tdd
- testing
---

As we're approaching a year and half here at [BillGuard](https://www.billguard.com), I've started thinking back a bit about our testing habits and how well that's turned out.

I've seen a lot of posts about testing in startups, some saying startups shouldn't bother to test because they'll have to change the whole damn thing 5 minutes after they're done, others claim testing is the only reason they were able to keep working. Here are some of my thoughts looking back.


### Our Background


When we started, only two of us had a test-infected background out of the five technical guys, me being big on [TDD](http://www.amazon.com/gp/product/0321146530/ref=as_li_ss_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0321146530)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0321146530" style="width: 0; height: 0; display: none; border: none !important;">. Two other developers never wrote tests before. We agreed that tests were important, but that's about it. I set up a continuous integration server and with that we were off. With time, the habit of writing tests spread out among the team. Some are TDD passionate, some write tests after the fact, but we generally all believe that tests should be written extensively.

{% img /images/posts_images/test_my_code.png 240 300 %}

### Not everything is worth testing


We've seen several quite rapid changes to our UI. Having less tests in this area makes sense. We rely on QA for making sure all buttons are displayed etc. To make this clear: we have no selenium-like tests for UI components but have tests for most logic being done by the UI. I think this is generally a good practice, since having to maintain selenium tests would be hard when you throw things around a lot and change flows. Some basic automated sanity tests pretty much does it.


### Everyone learned to love tests


I love seeing other guys in the team delete a line of code to see which test breaks and understand why it's there. Even more I love the frowning face when no tests break. This addiction to tests shows how much value the team's getting out of having solid tests, hands down. No need to stress this further I believe.


### Tests save our asses repeatedly


Having an extensive suite of tests allows us to make rapid changes to our code base, as is needed in most startups, and rely on the solid tests to tell us whether we've screwed something up. All the code that has anything whatsoever to do with sensitive and important information is heavily tested which is a huge bonus and a necessity in our line of business (personal finance protection).


### TDD is just magical with complex algorithms


We have quite a few complex algorithms that require multiple entities and ideas to perform. I find that the parts we're most satisfied with maintainability-wise are the heavily TDD-ed algorithms we've got. Being written with rigorous TDD gives us so many advantages:

  * This critical code usually has a lot less defects.
  * The code is a lot more readable, well decomposed and allows for easy changing once we find out a need for tweaking the algorithms.
  * Working in TDD magically forces us to form our problem domain better, making us have a language of our own in talking about the problem. This happens less naturally in other forms of working on algorithms.

### Summing our testing experiences

All in all, I think the whole team would agree that dedicating time to writing thorough tests is proving itself valuable and because of that people are writing more and more tests without any of us ever stopping and saying "we should write tests" (well, I swear I didn't do it too much). It happens naturally when people get the value out of it. It's fun seeing how today BillGuard has become a company that organically values testing so much I don't even feel a great need to stress it to new people because they'll quickly see there's no real other way. We're far from being the poster children of [Clean Code](http://www.amazon.com/gp/product/0132350882/ref=as_li_ss_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0132350882)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0132350882" style="width: 0; height: 0; display: none; border: none !important;">, but I've got my fingers crossed.

If you're interested in accomplishing the same at your work, you might find [this recent post](http://www.codelord.net/2011/11/28/stop-bitching-write-those-damn-tests/) of mine of some help.

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed or [follow](http://twitter.com/avivby) me on twitter!
