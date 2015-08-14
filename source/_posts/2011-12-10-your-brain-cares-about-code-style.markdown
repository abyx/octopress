---
date: '2011-12-10 20:38:18'
layout: post
slug: your-brain-cares-about-code-style
status: publish
title: Your Brain Cares About Code Style
comments: true
wordpress_id: '670'
---

My first team had (among many other great attributes) the custom of strictly following a style guide. It was followed so religiously, I've yet to come across another place that does so to the same extent. It wasn't really written down anywhere, but after a couple of weeks of pairing with the other guys you got it.

What does that mean exactly? It means that we wrote code that looked, to a large extent, like it was written like the same guy. We put 2 blank lines between regions. Members had a specific way of documenting. We even used the same idioms for creating empty lists etc. (Java).

If we paired with someone and saw him indent the code the wrong way, we'd go all _OCD until it was fixed_. And it was regarded totally OK. We didn't feel like we were nitpicking on each other. It was the way things got done. I even know a guy that would notice extra whitespace at the end of lines (without any IDE help).

Ever since, whenever I see code written with careless indentation and whitespace I feel like the coder who wrote that just doesn't care enough for the craft. Yes, **No Whitespace - No Care**!


### What's the big deal?


If code isn't written in a consistent style in your team, whenever you come across code with the spacing a bit wrong, the first thing your head's going to process is "**I didn't write this.**" This is a natural feeling, and as we all know coders have a hard to restrain impulse to rewrite any piece of code they didn't write. Once all the code looks the same, that feeling isn't that hard and you can actually focus on the code itself and have a better sense of ownership. I know, it sounds stupid, but that's the way our stupid minds work in.

A big part of the [Extreme Programming](http://www.amazon.com/gp/product/0321278658/ref=as_li_tf_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0321278658)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0321278658" style="width: 0; height: 0; display: none; border: none !important;"> principle Collective Code Ownership is obtained by simply keeping a consistent style. Anything important enough to become a core value of the only methodology that works must be worth the effort to take notice of.

The next time you see code with reckless spacing, change it and let your teammates know. It might be hard at first but the end goal is important - the ability to fluidly read code, without feeling like you're wearing someone else's shoes.

You should subscribe to my [blog](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
