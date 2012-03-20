---
date: '2011-11-28 23:27:09'
layout: post
slug: stop-bitching-write-those-damn-tests
status: publish
title: 'Stop Bitching: Write Those Damn Tests'
comments: true
wordpress_id: '510'
categories:
- Programming
tags:
- agile
- autonomouscraftsmanshipcore
- Programming
- software craftsmanship
---

Diving deeper into the idea of the [Autonomous Craftsmanship Core](http://www.codelord.net/2011/11/12/stop-bitching-the-autonomous-craftsmanship-core/), this time I'd like to talk about one of the first problems a lot of developers face when wanting to start doing clean code.

You read Uncle Bob's [Clean Code](http://www.amazon.com/gp/product/0132350882/ref=as_li_tf_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=217145&creative=399369&creativeASIN=0132350882)![](http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0132350882&camp=217145&creative=399369), or went to a talk and then go all "Next day at work I'm gonna write tests!!" Then you come to work, and you give the "let's write tests man!" speech to your teammate, and he just yawns, and slowly the rush fades.

Lots have been written before about introducing tests to a team as a grunt, but I'll do a quick recap:

You _don't have to ask anyone_ in order to start and write some tests. Write that first test. Make it pass. Commit. Not that hard, isn't it?

Usually the next problem is that if no one else on your team runs the tests, they will keep breaking. But can you blame your team? You need to make them understand that running the tests will actually get them something.

For example, I've seen that after someone makes a commit that breaks the tests because of a bug, coming over to him and telling him what went wrong and how you found out might make him more interested in the idea of testing. A friend recently told me that he made running tests as simple as a double-click for the developers that don't write tests. Once it got _that_ easy, they started running them because everyone likes knowing that what they wrote works.

What if your boss won't let you write tests? Frankly, _why the fuck should your boss care_? Does he also tell you when to use "while" instead of "for"? I don't find things such as these to be something any boss should decide about. As I've said in the first post, if you find yourself in a place so resistant to change, **leave**. If you have to stay, do what you have to do. If they won't let you commit your tests to source control or set up a continuous integration machine, there are solutions, which I'll discuss on my next post.

In the mean time, focus on writing tests that help your teammates find problems and see how slowly your little tests get more and more traction. It'll work, because **Success begets attention!**

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
