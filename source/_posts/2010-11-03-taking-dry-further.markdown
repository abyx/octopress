---
date: '2010-11-03 23:56:42'
layout: post
slug: taking-dry-further
status: publish
title: Taking DRY Further
comments: true
wordpress_id: '239'
categories:
- DRY
---

After learning to [spot basic DRY](/2010/11/02/short-intro-to-dry/) violations, such as code you've just copied from somewhere, it's time to learn how to use DRY to drive a lot more in your system.

DRY can be used extensively in your code base to alert you of problems waiting to happen. For example, similar code structures in different parts of the code are usually a DRY violation. This violation causes coupling which in turn will make it harder to change the code. The good scenario is that you have to tediously go through all the repetitions and change them to accommodate the change. The worse case is you forget to change one and introduce inconsistency in your code.

Train yourself to note these feelings of "yeah, I'll have to do _that_ again here". Lucky for me, whenever I do something too many times I automatically start referring to it as "the dance". So, once I hear myself saying to a teammate that "I'm doing the add-view-dance" I know it's time to do something about it.

But DRY need not apply only to your code. Actually, it certainly shouldn't! Copying is bad, even if you do it in a configuration file, or "just in that script". It's our tendency to disregard these "minor" parts of our system as not worthy of our attention, but these are places that are at least as likely to cause problems as our code. Taking the time to make the deployment scripts tidier will pay off once you decide to leave that server at home and deploy your app on EC2.

DRY used correctly will make driving changes in your app a breeze, be it a configuration change, a DB change or a real feature you need to add. The saved cycles of work saved by not having to dig around the code and look for other places your forgot to update, or hunt the bugs caused after making a change pay off immensely for the time spent on making things the good way.

Let's take this one step further. Do you document your app? For example, do you supply wiki pages with explanations for installing the system, executing it or making configuration changes? There isn't a coder out there that hasn't been bitten by an outdated guide that was updated to reflect the way things should be done now. This is a subtle DRY violation - the is repetition between the description of the process in the wiki and the real process, as is usually saved in people's heads or scripts. If you've got a script, why not simply use it as documentation?

Most people will probably understand your shell script better, and it is sure to be up-to-date. I tend to document the script itself to make it clearer (and generally treat it as part of the code base) which pays off when I don't have to hear people get angry with me for not updating the wiki.

The even more important example is sample code. Almost every app will, at some point, require you to supply sample code for working with it. The knee-jerk solution is to hack some code and put it on a wiki page. You might even go the extra mile and run the code to make sure it works. 24 hours later, you change the code and the samples are now obsolete. Again, duplication between real code and sample code has created a problem for us. The solution, once more, is to fight this duplication. Putting the samples as part of the app's version control, which will make sure they compile and run with every change, and pointing the wiki to these files (or even embedding them in the wiki) will save you a great hassle. Sometimes you can even make these examples part of the code, such as Python's Doctests, which allows you to put executable usage examples right next to the code.

Once more, training your senses to notice these violations and finding creative solutions for them takes practice and time, but gets a lot easier once you get the trick. This is a crucial tool in the pragmatic programmer's belt.

DRY, actually, is a measure of technical debt. The more violations you allow to slip in the codebase, the harder you'll have to work later to change the code. A DRY codebase is usually more cohesive and loosely coupled which leads to a more responsive design. Effort you put into keeping your code DRY pays off, quickly and by manyfold.

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby).
