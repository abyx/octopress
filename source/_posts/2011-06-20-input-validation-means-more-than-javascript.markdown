---
date: '2011-06-20 06:14:56'
layout: post
slug: input-validation-means-more-than-javascript
status: publish
title: Input Validation means more than Javascript
comments: true
wordpress_id: '397'
categories:
- Programming
tags:
- Programming
- security
---

So much has been written about security before, that I never thought I'd end up writing something about it. Then again, I never thought one of the top [U.S. banks will get hacked](http://consumerist.com/2011/06/how-hackers-stole-200000-citi-accounts-by-exploiting-basic-browser-vulnerability.html) simply by twiddling digits in a URL.

Basically, the only thing you should take away from this post is that when it comes to external data - trust no one. And I mean absolutely no one.

I think and hope that by now most web developers know not to trust data that users entered in input fields. That trust is what gave birth to [SQL injections](http://en.wikipedia.org/wiki/SQL_injection). Nowadays, just about no one should be exposed to such a lame problem, especially since pretty much every ORM framework out there protects you from these. But checking your input fields is just the beginning.

Every form of input you accept, even indirect input, is still untrusted input. I just want to go over a few examples, because you all should have this in mind:

**URLs** - Just like I mentioned above, CitiBank got hacked simply because someone noticed an integer on his browser address bar and started incrementing it. Any parameter you accept from a URL should be examined. Accessing an email by id? Make sure it corresponds with the current user. Always.

**Form arguments/JSON** - These are just the same thing as validating input fields. Everyone should know by now that it's wrong to trust and validation done on the client side, since every moderately capable person can craft his own POST/GET requests and bypass any validation. Validate everything on the server. And don't use the client as a place to put some state in, unless it really belongs there. I can't tell you how many ecommerce sites I've seen that pass the price of products along your regular forms as hidden input fields. From that point it's just a few right clicks in firebug and you're gonna get that LCD TV for $1.

**Cookies** - Again, these are inputs generated from your clients. Yeah, you put the cookie there in the first place, but since you put it there your users had the chance to do whatever they want to it. So, putting in a cookie any kind of integer means it has to be validated again on the server side, just like a URL parameter. Any data you put there might have been mangled. The solution is to either not use cookies for anything like that, or sign your cookies the way Rails does.

**Really anything possible** - Have you ever used a service that allowed you to update certain stuff via email? That's, for example, another form of input. You wouldn't want someone to change some URL/number in the email when he's replying and get access to a different user's data, would you?

These are really just the tip of iceberg, but I'm constantly surprised to see how many around us are popping up web sites with no thought given to these problems. Just a tiny bit of thinking can prevent you from topping reddit for being a lame developer.

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
