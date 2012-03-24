---
date: '2011-08-04 06:36:15'
layout: post
slug: shell-hackery-the-use-of-cd
status: publish
title: 'Shell Hackery: The Use of "cd ."'
comments: true
wordpress_id: '421'
categories:
- Programming
- techie
- bash
- shell
---

I have a nasty habit of going over my bash history every once in a while. Usually I sort commands by frequency to find stuff I can automate/alias. Last time I came across `cd .` and thought I'd write up a little explanation of why I find this seemingly useless command useful.

So what does it do? `cd .` literally means "change directory to the current directory", which sounds like a no-op. The point is that sometimes the current directory is no longer the current directory! Let's start with an example.

Say I have a git repository on my_repo/ and on its master branch there's a my_repo/folder directory and on its bugfix branch that directory doesn't exist. Now imagine I have a terminal window open after performing the following command:

    
    cd my_repo/folder # now on branch master


And now, while that terminal is open I need to switch to the bugfix branch for a few minutes, do my thing and return to it. If I switch branches using a different terminal or some GUI tool, what becomes of my terminal's shell? When I switched to the bugfix branch, git essentially removed that directory the shell was in, and when I returned to the master branch, the directory was put back into place.

So, one might expect that after switch back and forth between branches and returning to my original terminal, simply executing `ls -l` will show that everything is ok. But it won't. What I would actually see when running `ls -l` is that the current directory is empty!

Oh no! Are all our files lost? Nope. They're right there in my_repo/folder, but our shell doesn't know that. To understand why, we need to dig a bit deeper. When a unix process accesses any file or directory, it obtains a file descriptor to it. That includes a shell's current directory - all throughout its lifetime, it has an open fd of the current dir. You can see that by running `lsof -p [your shell pid]`.

When process A holds an open fd to a file/directory and process B removes that directory, what should happen? Unix doesn't have that file locking mechanism windows does. What it does do is remove the file from anywhere except still holding it somewhere til process A finishes working with it. What this means is that if, for example, you've got a file open in some software and accidentally "rm"ed the file, you can still recover the file because it's held somewhere by the open program. You can see an example for restoring files this way on linux [here](http://www.linux.com/archive/articles/58142).

Back to our problem! Our shell process is now sitting with its current directory actually being some phantom directory that is no more. That means that even after we checked out the master branch again and the directory was already there, no one updated our shell regarding that. It does know it's in "my_repo/folder", though.

That means that in order to quickly get our terminal back to being useable (say, we want `ls` to actually show stuff) we can, of course, be all lame, close the shell and open a new one. Or, we can "refresh" the file descriptor to the current directory. How?

    
    cd .


Hope you learned something new!

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
