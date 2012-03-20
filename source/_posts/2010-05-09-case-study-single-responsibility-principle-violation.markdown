---
date: '2010-05-09 20:15:25'
layout: post
slug: case-study-single-responsibility-principle-violation
status: publish
title: 'Case Study: Single Responsibility Principle Violation'
comments: true
wordpress_id: '159'
categories:
- Programming
tags:
- clean code
- Programming
- software craftsmanship
---

Having recently finished the amazing PPP book (more [here](http://www.codelord.net/2010/05/02/agile-software-development-you-will-never-code-the-same-again/)) my code-sense is getting better in putting the finger on the smells in code that make it painful for me to use. This is the story of one of them, in [Buildbot](http://buildbot.net/).

Disclaimer: Buildbot is a pretty awesome building/continuous integration system that I use and contribute code to regularly. Indeed, it is far from perfect, but none of the coders should take offense.

So, what is the Single Responsibility Principle ([SRP](http://bit.ly/bs003B)) ?


> **A class should have one, and only one, reason to change.**

> 
> If a class has more than one responsibility, then the responsibilities become coupled. Changes to one responsibility may impair or inhibit the class’ ability to meet the others. This kind of coupling leads to fragile designs that break in unexpected ways when changed.




And now, to the gory details. Buildbot has a built-in class for executing shell commands, called _ShellCommand_. Now let's say we want to create a class, _VerboseCommand_ that always executes commands with the '_-v_' flag. One would assume this is the right way to do it:


But this turns out to be wrong. Say we tried to execute '_nosetests_', the actual command that will be executed is '_nosetests -v -v_' (which is harmless, but you might have guessed my real use-case wasn't adding the '_-v_' flag).  The reason is, as the [Buildbot manual](http://djmitche.github.com/buildbot/docs/0.7.12/#Writing-BuildStep-Constructors) will happily tell you, that **every step is also its own factory**.
 
Wait, what? Given the fact the a certain step will need to be run in multiple builds on multiple slaves, a new one needs to be created every time. But, as a user you only instantiate the step once. Turns out that behind the scenes, Buildbot will save the arguments given to the command's constructor and call it with them again every time it needs a new instance.
 
This means that in our case, we must find a way to tell in the constructor whether we're instantiating the factory or being instantiated by the factory, and add the flag only in one case but not both. My cute example turns to this mess:  

(If you're really bothered with understanding every detail, read the [manual](http://djmitche.github.com/buildbot/docs/0.7.12/#Writing-BuildStep-Constructors), but I'm sure you can get the gist of it without doing so.)

Now, if you're anything like me, you're looking at this and wondering something along the lines of "_what the hell were they thinking?_". That feeling, that tingling in your code-sense, is the smell of an SRP violation.

Because this class has to also act as its own constructor, the coupling between the two actions is high, and as the definition clearly states, the class now has 2 reasons to change.

Surely, separating this to 2 different classes (the actual step and a factory) will have solved this problem elegantly. Given that this might be considered "advanced" usage I'm willing to accept that creating a factory will be _optional_. But really people, this _addFactoryArguments_ screams _HACK_.

If you liked this post, you'll definitely want to read the [PPP book](http://www.codelord.net/2010/05/02/agile-software-development-you-will-never-code-the-same-again/).

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
