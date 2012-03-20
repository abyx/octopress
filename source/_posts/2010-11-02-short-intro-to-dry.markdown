---
date: '2010-11-02 21:43:24'
layout: post
slug: short-intro-to-dry
status: publish
title: Short Intro to DRY
comments: true
wordpress_id: '234'
categories:
- pragprowrimo2010
- Programming
tags:
- clean code
- DRY
- Programming
- software craftsmanship
- tips
---

If you're just starting to learn programming you might be feeling the need for a few solid guidelines for producing better code right now. Joining an industry with so many Best Practices, Rules of Thumb and The Right Things is not easy and certainly not too welcoming for newbies.

One of the best programming mantras that everyone can understand and use for better code right away is DRY - Don't Repeat Yourself. DRY is about removing duplication from the code base at pretty much every level, and this, I believe, is one of the pillars of good software engineering.

Academia rarely talks about DRY with enough stress. I've heard something like it only twice. Once, when I was told to use constants instead of magic numbers. This is maybe the simplest way to get started with DRY - replace magic numbers that you use several times in your code with a constant. All of a sudden the numbers got a real meaning but the more important thing is that changing the value becomes a no-brainer. Want to send more bytes with every packet? Just update the constant! That's real value right there, instead of having to start searching files for the current number, and distinguishing between the times 512 is the packet size and when it's just the maximal file size.

Another reference to DRY in Academia is "Reuse". Reuse is the holy grail of software engineering. I know that after taking a few courses it seemed that Reuse is that peace of mind only OOP Gurus can get to by writing speckless code with good design. Although in academic courses you're not likely to see real reuse and examples of code that reaches this goal in a good way, this is still a DRY manifestation that's easy for a lot of people to grasp. What's a better way to refrain from repeating myself than to not write new code at all and use that GenericAwesomeThing class I created before?

But, as with many things, those 2 well-rehearsed topics are only the tip of the DRY iceberg. Once you get it into your head that DRY is one of the easiest and most effective ways to get better and cleaner code, you'll start seeing its violations left and right.

The easiest way to spot DRY violations is by looking at your typing. Pretty much any time you catch yourself using copy and paste, you know you're doing it wrong. The mear act of copying some code around means, literally, you're repeating the same thing somewhere else. Spotting those is usually a happy occasion, an opportunity to learn. This usually means you're code is missing some basic abstraction to make that idea you're trying to replicate a concrete concept of your system.

For example, whenever I copy a few lines from a method I know I probably need to extract a method. There are so many advantages to simply sticking to this as a golden rule that Uncle Bob is calling this "Extract till you Drop". Practice DRY enough and "Extract Method" will become a regular coding step. It is no longer a "refactoring". It is no longer a "task". For me, it's as simple as adding a variable, or writing a loop. It's a tool, the simplest we've got.

But until you get familiar enough with extracting methods, you should be aware of these acts of copying stuff around and fight them with wrath. If extracting methods scares you, I'd start with even simpler stuff. Are you using the same string a couple of times, e.g. "Error: " is all over your code? Keep it DRY! Some simple computation appears a few times? Keep it DRY!

To start the ball rolling in the craftsmanship direction and adhering to what people that are wiser than you and I, keeping things DRY is a pretty simple, sure-fire way to do things better. Keep your watch for patterns that look all too similar. Imagine your keyboard has a DRY key that simply removes the duplication, be it by extracting a method, a constant or a class.

Try sticking a DRY post it to your monitor and do your best for a week. You will likely gain a whole new perspective of your code and learn to notice minute details you used to disregard. The magic is that once you start following DRY, you will also notice that the amount of places you need to go through to make changes is decreasing. There's nothing better than finding that change you wanted to make is a one-line change, as there's nothing more frustrating than finding out you now need to untangle 8 snippets in 5 files in order to get that simple change done.

DRY is a power tool you should master quickly and add to your tool box. I've written more about taking DRY further [here](http://feeds.feedburner.com/TheCodeDump).

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby).
