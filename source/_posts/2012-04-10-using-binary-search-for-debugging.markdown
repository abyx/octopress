---
layout: post
title: "Using Binary Search for Debugging"
date: 2012-04-10 23:24
comments: true
---

Practically every developer alive has heard about binary search and knows how it can be used for quickly finding something in a sorted array. It's no surprise given how easy it is to grasp and how amazingly efficient it is. Just think that finding something in an array of 1000 elements only takes 8 checks. That's magic!

But I keep getting surprised how many of us only think of binary search when facing exactly that problem (finding something in an array) and nowhere else. It's such a useful tool I thought I'd mention some of the other uses of it I make.

### Finding an offending line

When confronted with a chunk of code that does something I don't want it to and trying to understand which line exactly is causing it I sometimes simply use binary search on the lines themselves. I start with by commenting out half of the lines and seeing if the problem persists. If it is I know it's in the lines left, otherwise I know it's in the lines I commented out. Repeat until you find the culprit!

### Finding an offending commit

Sometimes the problem is something like "I know it worked 2 weeks ago". In those cases you can quickly use your version control tool to effectively pinpoint the commit where it stopped working. If you're lucky enough to be using git you can use the awesome ["git bisect"](http://linux.die.net/man/1/git-bisect) command. By feeding it with a good commit and a bad commit it starts the binary search for you, slowly zooming in on the right commit by asking you whether a certain commit is good or bad. Actually, if you have a fast and easy to run test that can find the problem you can provide `bisect` with it and it will automatically run it against commits until it finds the right one. This kind of magic is quite rare to find in the wild, but it's just so much fun I almost want to write bugs that would be found this way.

### Finding some edge number

This problem might just be me and my weird use of computers but I quite often need to find the upper bound of some set of numbers. For example say I want to find out how many pages of results some site has for a certain keyword. If it doesn't tell me how many there are surely I can't use binary search? Oh yes I can! By using an open-ended variation of binary search we can start searching for the first page that doesn't exist (Say, by changing the number in http://site.com/p/1 to 2, 4, 8 etc.). Once we get a number that doesn't have a page (say, 256) we now know the result is somewhere between it and the previous number (128) and can start the regular binary search routine.

I hope this helped you add another cute technique to your arsenal.

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
