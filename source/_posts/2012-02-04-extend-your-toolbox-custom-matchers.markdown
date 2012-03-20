---
date: '2012-02-04 14:53:41'
layout: post
slug: extend-your-toolbox-custom-matchers
status: publish
title: 'Extend Your Toolbox: Custom Matchers'
comments: true
wordpress_id: '726'
categories:
- Programming
- testing
tags:
- DRY
- ruby
- software craftsmanship
- tdd
- testing
---

I'd like to point out a really nice testing practice that I've been loving more and more lately.

Just about every mature testing framework out there supports the concept of custom matchers, which provide us with the ability to define our very own assertions seamlessly into the tests. Even though this ability is quite old, we don't see it used too often and I think that's a shame. I've seen this practice heavily used in the mind expanding [GOOS](http://www.amazon.com/gp/product/0321503627?ie=UTF8&tag=thcodu02-20&linkCode=shr&camp=213733&creative=393185&creativeASIN=0321503627) book and just now am starting to realize its awesomeness.
[caption id="" align="alignright" width="240" caption="Your Testing Toolbox"][![toolbox](http://farm2.staticflickr.com/1155/1403240351_68114a0c53.jpg)](http://www.flickr.com/photos/dipster1/1403240351/)[/caption]
Note: examples in this post are shown in Ruby using [RSpec's matchers](https://github.com/dchelimsky/rspec/wiki/Custom-Matchers) but the concept is pretty much identical (as can be seen for example in Java's [Hamcrest Matchers](http://code.google.com/p/hamcrest/wiki/Tutorial)).



### Matchers 101


Creating your own matcher usually means creating a Matcher class that performs the assertions, supplies human readable error messages and a nice constructor.

Here's an example from the [RSpec documentation](https://github.com/dchelimsky/rspec/wiki/Custom-Matchers):

{% gist 1737631 rspec_matcher.rb %}


### Matchers increase readability and intent


As you should know, one of the [most important rules for design](http://c2.com/cgi/wiki?XpSimplicityRules) is _Reveals Intent_. Take a quick look here, which way do you think reveals more intent?

{% gist 1737631 intent.rb %}

Also, which error message do you prefer? "expected false to be true" or something along the lines of "expected comment to be anonymous"?


### Matchers create robust tests


The most important advantage of all is how using matchers easily allows you to steer away from fragile tests which are the bane of a lot of testing efforts.
The mark of good tests is that a change in your code doesn't require you to perform changes in multiple tests that don't really care for the change.
Take this code for example:

{% gist 1737631 sucky_non_dry.rb %}

This might seem like a standard test, but that's not really the case. A test should assert for a single piece of knowledge, and this test actually checks several. If the purpose of this test is to check the behavior of anonymous comments, why should it change if we no longer allow replies? Or if we no longer require users for posting comments?

The magic of matchers is exactly here. You create a new matcher to check specifically the aspect your test cares about and *boom*, you're decoupled!

{% gist 1737631 beautiful_and_dry.rb %}

This simple change makes your tests DRY and cool.

Happy testing!

Your should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed or [follow](http://twitter.com/avivby) me on twitter!
