---
date: '2011-11-05 22:38:24'
layout: post
slug: stepping-up-do-the-pre-commit-skim
status: publish
title: 'Stepping Up: Do the Pre-Commit Skim'
comments: true
wordpress_id: '497'
categories:
- Programming
tags:
- Programming
- software craftsmanship
---

I'm always looking for the easiest way to make my code better, or to train myself to pay more attention to the quality of the code I produce. My latest find is quite obvious yet so very powerful I had to share. Simply put, it's just _going over your code once more before a commit_.

Every once in a while, I commit code and forget to add a file. Even worse, I sometimes leave around dead code that I really hate. I've found out that simply making a mental note to go over every file I changed before making a commit makes a big difference. It seems like the Boy Scout Rule from [Clean Code](http://amzn.to/sf6KkN) is a special case of this rule.

The trick is to simply go over every file you've changed and **look for common pitfalls**:

**Unused code** - Are there methods your changes just made obsolete? Maybe a conditional with an "else" clause that can no longer happen? Delete code! It's the best code you'll write today!

**Zombie code** - Did you start with something that was too complex and is no longer needed? Often in retrospect you can see how to simplify something and spare your colleagues the [woes of zombie code](http://www.codelord.net/2011/10/28/fight-zombie-code/).

**Overdue refactoring** - Look at your changes. Are you pushing a method too far? Maybe making a class too bloated? Maybe it's time to for some cleaning.

**Do you have a better name for it now?** Sometimes when you start with something you don't have a great name for it. After finishing it, you might be able to slap a better name on that class that will make it more obvious to everyone.

**Any dangling TODOs?** I hate committing TODOs unintentionally.

**Make sure it's all coherent in class-level** - Some changes make sense when you're knee-deep in a change. But step back and make sure it all still makes sense.



You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
