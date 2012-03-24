---
date: '2010-11-09 07:19:20'
layout: post
slug: letting-dry-drive
status: publish
title: Letting DRY Drive
comments: true
wordpress_id: '265'
categories:
- pragprowrimo2010
- Programming
- clean code
- DRY
- software craftsmanship
---

The reason I [stress](/2010/11/02/short-intro-to-dry/) [DRY](/2010/11/03/taking-dry-further/) [so much](/2010/11/04/dry-dont-get-trigger-happy/) is because it is one of the simplest yet most effective pieces of knowledge we have gained for software development. When I first read about DRY (in [The Pragmatic Programmer](http://www.amazon.com/gp/product/020161622X?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=020161622X)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=020161622X" style="width: 0; height: 0; display: none; border: none !important;">) I got it's amazing strength in saving extra maintenance by making sure that changes will be localized as much as possible in the future. And I've used it as such for a couple years.

Only after I started practicing TDD did I realize how significantly DRY can drive coding. Whenever I test drive code, the third step of the cycle, Refactor, is usually a lot about removing duplication. And the amazing part is that this alone drives a useful implementation. In the awesome book [TDD By Example](http://www.amazon.com/gp/product/0321146530?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0321146530)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0321146530" style="width: 0; height: 0; display: none; border: none !important;">, Beck describes a method of implementing called Triangulation. It's for those rare occassions where you really have no real clue what way is best to solve the problem - the ground that allows TDD to flourish. In this method, you start by getting a couple of tests to pass with dumb implementations and then refactor to generalize the code and make it DRY. The mere act of DRYing your code can simply through a solution at you. I'm still amazed when this happens to me, both because of the sheer beauty of the process, and because it means I'm doing something right.

About 5 years ago, when first heard about the concept of TDD, I wrote a greenfield project for about 5 months in what I believed was TDD. Only more than a year later did I realize that I wasn't doing TDD at all, but TFD (Test First Development). I did in fact write all my tests before I wrote production code, but I didn't let the tests _drive_ the development. Now although that is better than not testing at all or TAD, it just wasn't it, and I didn't get why.

Whenever I wrote a test, I already knew how the implementation was going to look, be it simple or complex. Sometimes I might have alreayd decided that I was going to add a decorator there, and then wrote the test that forced me to implement a decorator. This, of course, is wrong. When I learned to let go and stop micro-managing my code, things took off at a better direction.

I write a simple test that explicitly uses the code as I would like to use it had someone else already imlpemented it. This is crucial, as it makes sure that I am not allowing myself to sustain a lousy interface simply because it's the easier one to implement. The harder part is to always disconnect yourself from prejudice - what you might think the code should become. Currently this is a deliberate effort for me, to make sure I'm not thinking a few steps further and adding what I think I'll need then too early. Even adding code I believe I'll just have to add anyway in about 2 tests is wrong.

After making the test pass by the simplest way I could come up with I start DRYing the code up. I actually do more stuff, such as improving naming etc. but generally, DRY is the main force behind the changes in this phase for me. I listen to the code and try to make it. This is where knowing your refactorings well pays off. I might extract a method only to inline it 20 seconds later and extract a different part of it. I move things around a bit and see what feels right. Because I've already got the tests, there's no reason not to use them right away to see just how far I can stretch the code to my ideal vision.

For me the magic is when I notice, after 30 minutes of doing this, that I've suddenly got a solution without realizing it. Suddenly the code falls into place. A lot of the times it turns out simpler than what I thought I'd turn out with.

Jumping from basic DRY to full blown TDD isn't easy or straight forward, but let DRY drive you design for a while and see it grow on you. I've yet to meet someone that's given it a shot and disagreed this a whole new way to programming.


You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)
