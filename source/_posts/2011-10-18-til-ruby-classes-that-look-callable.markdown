---
date: '2011-10-18 08:01:07'
layout: post
slug: til-ruby-classes-that-look-callable
status: publish
title: 'TIL: Ruby Classes that Look Callable'
comments: true
wordpress_id: '478'
categories:
- Programming
tags:
- Programming
- ruby
---

One of the concept I had to get used to moving from Python to Ruby was that regular objects aren't callable, and that there was a closed set of objects that can be called. Meaning that where in Python it was possible for any class to implement __call__ and so allow us to call it with obj(), Ruby doesn't allow this. One of the advantages of that syntax in Python is that each class implements its constructor using this. For example:

[gist id=1294707 file=python_class_is_callable.py bump=2]

This was a nice little trick I liked in Python but quickly got used to living without it. That was until I saw Ruby code that seemed to allow the exact same behavior:

[gist id=1294707 file=ruby_class_looks_callable.rb]

How's this so? Can we really make classes callable? A quick glance at Integer's source code in the Rubinius code reveals that there's no magic going on in it, and that it actually has no reference for this method I'm looking to call. Instead what we'll see is that alongside the class definition there's also a method definition:

[gist id=1294707 file=integer.rb]

So the whole trick is simply to define both. But how exactly does this work? How are names not clashing?

What actually happens is that whenever we define a new class or module, its name is added as a constant that points to the actual class. Similarly, when we define a method at the top level it's added as a private method to Object. That means that whenever we type in a name that looks like a constant (starts with a capital letter) without parenthesis, Ruby will search for that constant:

[gist id=1294707 file=const_lookup.rb]

But when we add parenthesis, Ruby understands that it should seek for a method instead:

[gist id=1294707 file=method_lookup.rb]

This nifty little trick is all it takes for Ruby to allow this nice syntax.

Hope you learned a new thing! In case you want to dig deeper, two great books that really helped me wrap my head around dark corners of Ruby are [Eloquent Ruby](http://www.amazon.com/gp/product/0321584104/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0321584104) and [Metaprogramming Ruby](http://www.amazon.com/gp/product/1934356476/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=1934356476).

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
