---
date: '2010-11-06 12:09:18'
layout: post
slug: refactoring-youre-doing-it-wrong
status: publish
title: 'Refactoring: You''re Doing it Wrong'
comments: true
wordpress_id: '248'
categories:
- pragprowrimo2010
tags:
- clean code
- Programming
- software craftsmanship
---

I've been writing [quite](http://www.codelord.net/2010/11/02/short-intro-to-dry/) [a](http://www.codelord.net/2010/11/03/taking-dry-further/) [bit](http://www.codelord.net/2010/11/04/dry-dont-get-trigger-happy/) about DRY lately, but I think it's time to take a few steps back and talk about something even more fundamental, refactoring. Today, refactoring as a concept is pretty common. I think it's even passed the buzzword stage. It's still not too known in academia (I've yet to hear the term mentioned in my studies), but given that most IDEs come with refactoring support or have supplementary tools for it, people are familiar with the term.

It has been written a lot about that the term refactoring is being heavily misused lately. Have you ever said "we need to do a big refactoring here?" If so, you've done the term wrong. The Big Refactoring is the new Big Redesign in the Sky. Have you ever told your boss you need time to refactor something? You're doing it wrong. Wrote Refactoring as a task on the board? Wrong once more.

Refactoring should be engrained in our constant flow of work. I mean it should be assimilated into the way you think of basic coding. Stop thinking of code changes as a stream of characters. To be an efficient coder you need to think of code at a higher level. The level of refactorings should be the level we think of code.

I really believe that generally [typing is not the bottleneck](http://www.sbastn.com/typing-is-not-the-bottleneck). In spite of that, I believe that being able to perform refactorings quickly, efficiently and seamlessly as part of your flow is a major differentiator in one's ability to quickly check ideas and be able to push design forward. I've deliberately spent time to put all refactorings of IDEs I use into my muscle memory. Extracting a method is not some heavy mind process, it's just a swift movement I do with my fingers.

An interesting example of how refactorings should be used I've heard from Kent Beck is his way to perform changes cohesively. Say you're editing a method 10 lines long and need to perform a change on 2 lines in the middle of it. Most people might simply make the change, but Kent (at least some of the time) will extract those lines to a new method and make the change in that new method. If the new method feels right after the change he'll just leave it there. If not, he'll inline it. If you're thinking that's a lot of hassle, you're missing all the fun here. This whole process has an overhead of 1 second on most IDEs, given you don't have a hard time coming up with a name for the method.

Doing refactorings the right way means you do dozens of refactorings on each coding session. This means you get the ability to tailor your code in much bigger chunks - methods, members, classes, interfaces. After all, we usually don't think about the need to move those parenthesis - we think about intent. Refactoring is all about intent!

Do yourself a favor and note your use of refactoring for a week. Learn all the hot keys your IDE has and make it a point to use them whenever possible. Whether you're doing Java, C#, Python or Ruby, there's no excuse not to use these basic building blocks for your every day use. Our stream of changes should be made of a lot of small, constant refactorings, pushing our design to a better place one small step at a time. Getting so familiar with this technique means you will no longer need to ask your boss for refactoring time. You won't need those big refactorings. You'll stop thinking about refactorings so much, they'll simply happen.

Refactoring's no longer a buzzword, but it's time for us to learn how to use it properly. Refactor constantly and get your groove on.

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and [follow](http://twitter.com/avivby) me on twitter!
