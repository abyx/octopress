---
date: '2011-02-05 19:27:12'
layout: post
slug: stop-wasting-my-code
status: publish
title: Stop Wasting My Code
comments: true
wordpress_id: '329'
---

During my service in the army I had the opportunity to move around some electronic equipment from place to place. A lot of it was pretty old (and by that I mean it predates me), but worked perfectly where it was. We had systems running for decades without a problem, but once we unplugged them and moved them to a different room they went dead.

Over time we've identified this phenomenon and simply noted that things that aren't in use stop functioning. It used to puzzle me, but eventually I came to accept this. What still is hard for me to accept though, is the fact that this is exactly the same with software as it is with hardware, if not worse.

I thought I learned this lesson a few years ago, after reading the [Pragmatic Programmer](http://www.amazon.com/gp/product/020161622X?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=020161622X)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=020161622X" style="width: 0; height: 0; display: none; border: none !important;"> and having it hammer YAGNI and KISS to my head, but I keep getting surprised every time I find out that I've just done it again.

Actually, learning Git has made this problem rear its ugly head again. Git makes it easy to write up some code and then keep it somewhere. I'd either stash some changes or keep a side branch with some work I started. The really bad part is adding this code to production code, simply because it's there. The problem is that _code gets stale_ if it's not really used, and fast.

I can't think of a single case where we added code before it was actually needed and got something good out of it. Fact is, every line of code you write before there's a real use case or actual need for is just you guessing. And we're mostly guessing anyway about stuff we actually need to get done, so why add more ambiguity in there?

As I read in [Growing Object-Oriented Software](http://www.amazon.com/gp/product/0321503627?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0321503627)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0321503627" style="width: 0; height: 0; display: none; border: none !important;"> code isn't sacred simply because it's there, and it won't take as long to write it again if you'll need to. Don't be afraid to delete code that isn't actually needed just because you put two hours in it. The time you'll spend maintaining it will take much more.

This is exactly the Lean definition of _Waste_ - everything not adding value to customers, and adding code just for you to feel better isn't helping your customers. I now consider waste as one of my sworn enemies. At my work I've decided to take on myself the role of do-we-really-need-that dude. It means being a PITA sometimes, but it pays off tenfold.

Next time you feel tempted to commit that code you're not sure you'll need anymore, keep in mind the best code is no code.

You should subscribe to [my feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)
