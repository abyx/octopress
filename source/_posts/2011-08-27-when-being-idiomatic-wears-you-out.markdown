---
date: '2011-08-27 13:25:33'
layout: post
slug: when-being-idiomatic-wears-you-out
status: publish
title: When being idiomatic wears you out
comments: true
wordpress_id: '453'
categories:
- Programming
tags:
- Programming
- software craftsmanship
---

I believe that when learning a new programming language, it's really important to learn its idioms and use them. I've written procedural C-like code in Java, and bloated Java-like code in Python, but only once you start using a language "like it was meant to" can you really say you've started mastering it. Had I not read [Effective Java](http://www.amazon.com/gp/product/0321356683/ref=as_li_tf_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=217145&creative=399381&creativeASIN=0321356683)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0321356683&camp=217145&creative=399381" style="width: 0; height: 0; display: none; border: none !important;"> I don't think I could have ever written a sensible line in this language.

I practically cringe whenever I see someone creating a new list in Java and then adding to it a single element when he just could have used `Collections.singletonList(element)`. I'm that kind of a fanatic.

But, lately I'm getting worn out of being verbose. Yes, you can use the trick above to save a line of code and a lot of typing, but damn it - I just want to say `[element]`!

Less than a month into BillGuard we realized we don't want to do all of our coding in Java and started calling Python code from Java (not in the JVM though, since Jython just doesn't seem solid enough). Running away from Java's notoriously long idioms, we preferred adding the overhead of having multiple programming languages in one project (which I think justified itself plenty, but it is an overhead).

This solution helped us when doing big stuff we didn't want to do in Java, stuff that we'd represent in a unique class. But the smaller stuff just kept nagging us. We kept finding ourselves writing 10-15 lines of code to do something we thought trivial and then putting a 1-2 lines of comments before it saying what we actually meant in Python. These eventually lead to a lot of extracted methods which are generally good, but rarely would I extract such logic in Python/Ruby - where it would be a single concise line of code.

Lately, we started toying with just saying "screw the idioms" and doing what feels right. If that means having a `JavaSucksUtils` class with methods such as `zip()` and `defaultdict_int()` so be it. I think that with time this will lead to using a wholly different language in the JVM mostly, but in the mean time this seems to be a nice transition.

I mean, common:

{% gist 1175248 %}

Now we'll have to wait and see where this gets us.

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
