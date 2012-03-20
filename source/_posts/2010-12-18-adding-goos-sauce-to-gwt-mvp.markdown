---
date: '2010-12-18 18:06:29'
layout: post
slug: adding-goos-sauce-to-gwt-mvp
status: publish
title: Adding GOOS Sauce to GWT MVP
comments: true
wordpress_id: '289'
categories:
- Programming
tags:
- clean code
- goos
- Programming
- software craftsmanship
- tdd
- testing
---

For a few months now I've been using [Google Web Toolkit](http://code.google.com/webtoolkit/). One thing that was bothering me was that even when following the praised MVP (Model-View-Presenter) pattern as per the documentation, you pretty quickly get into messy land.

Here's a snippet from the official GWT MVP [tutorial](http://code.google.com/webtoolkit/articles/mvp-architecture.html):

In this example, you see that our Presenter, when bound, registers a click handler for a button, in order to perform some action when it is called. This might seem nice and all, but there's a smell. This is a violation of the [Law of Demeter](http://en.wikipedia.org/wiki/Law_of_Demeter) (the missing SOLID rule, one might say).  This simply makes it harder to test, since we now have to add another layer of indirection between the SUT and its collaborators. Instead of making the view a tiny bit smarter, we use it as a dumb collection of widgets the presenter manages. This is clearly not in "Tell, don't ask" form.
 
The thing that really bothers me is how coupled the presenter gets with its view. Take the above example, and say that you decided that it would be better to have two "save" buttons on the UI. Does the presenter really care? Should it even change? And what if you actually want the save button to change to a remove button when the user picked something? Should the presenter now deal with getSaveOrRemoveButton() ? Of course not.



### GOOS it up



After beating around this bush for quite some time, I decided to try and find a better way. I'm currently reading the brilliant Growing Object Oriented Software book, and decided to try its approach to push a better implementation. After a bit of refactoring I got this:
 

[![](http://codelord.net/wp-content/uploads/2010/12/goos.jpg)](http://www.amazon.com/gp/product/0321503627?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0321503627)![](http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0321503627)

This might seem like a tiny change. And it is. But it makes all the difference in the world in how more responsive your design gets, especially in our world where the view is most likely to change a dozen times before settling on something. Once there are enough of these, I push the presenter as a dependency into the view, and let it call the presenter directly. The funny thing is this style is actually implicitly mentioned in the [second part](http://code.google.com/webtoolkit/articles/mvp-architecture-2.html) of the GWT MVP tutorial. Just some GOOSing helped us get to a better, more malleable design!

Don't be afraid to do something differently than the documentation, especially if you gave it a fair shot and it didn't work out.

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
