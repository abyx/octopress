---
layout: post
title: "Why I Don't Believe in Refactoring Tasks"
date: 2012-06-04 06:53
comments: true
---

Recently, we were talking about tackling an area of our code base in which we have accrued a large technical debt, and what would be the best way to get rid of it.

At first, the very attracting idea of a rewrite came up, this time specifically accompanied by dumping the old tools for new, sexier tools that would surely make everything better.

After some more discussions though, we reached the conclusion that as good as the new tools would be, there certainly is [no silver bullet](http://www.amazon.com/gp/product/0201835959?ie=UTF8&tag=thcodu02-20&linkCode=shr&camp=213733&creative=393185&creativeASIN=0201835959&ref_=sr_1_1&qid=1338782128&sr=8-1) involved, and so the real question was - why do we think this time we would be any better and not get into the same mess a few months after completing the rewrite? Also, as everyone knows, rewrites are scary shit and never end well. While the idea seems quite easy when you start, you always realize down the line that the code got convoluted for a reason, and that you're going to miss your estimates by a long shot.

The next idea we had is, of course, to first refactor our way out of the mess we got into and then gradually start using better tools as new features and changes to existing code are required. This is the responsible, own-up-to-our-mess choice. Of course we liked this idea, but the big question is: how should we go about this refactoring?

Some thought that the team should dedicate developer time for several sprints and have a developer work full time on these refactorings. This notion made me cringe and I thought I'd share why:

  * We're in a startup goddammit! If you can afford taking a developer off to play with code for several sprints instead of working on valuable features then, surely, you have too many developers! As an aspiring software craftsman I long for adding value to my users, not to get paid to play architect.
  * Refactoring for the sake of refactoring, as much fun as it can be, is never as good as actually changing the code because you need to. I can really spend a whole day polishing a piece of code. The issue is that if you have no target in mind, like "it should be easy to add a new page to our app" then you don't know when to stop. I'd hate for us to do this coder-masturbation (excuse my French) instead of doing actual work.
  * Having refactoring tasks makes it OK for regular quality to be lower because it can be "refactored later". That kind of crap is what got us in this mess in the first place!

To sum, I do believe refactoring is the way to go, but that the good path is to devote more time to tasks that require changing messy parts so that the developers would have the time to make sure they leave the code better than they found it, and clean stuff up, so that next time changes there would take *less* time.

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) or follow me on [twitter](http://twitter.com/avivby)!

