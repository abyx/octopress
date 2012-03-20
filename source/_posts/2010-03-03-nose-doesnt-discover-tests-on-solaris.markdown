---
date: '2010-03-03 16:05:31'
layout: post
slug: nose-doesnt-discover-tests-on-solaris
status: publish
title: nose doesn't discover tests on Solaris
comments: true
wordpress_id: '138'
categories:
- Programming
- techie
- testing
---

**Note:** this is a technical post, to help poor souls that google this :)

When using _nose_ on Solaris machines, simply running _nosetests_ without specifying the file names will not work if you are the root user. To fix this, you must either not be root, or pass _nose_ the argument `--exe`. That's it.

Gory details: by default, _nose_ ignores executable files. Each file it encounters it checks with _os.access(test_file, os.X_OK)_ to see if it's executable. Problem is that Solaris' _access_ function always returns success for root, regardless of actual file permissions. This is discouraged by POSIX, but known behavior.

Ensuring that you're aware of known behaviours is crucial, as it prevents you from looking up issues with software unnecessarily. Of course, you can find these out on the web and it's not difficult to test run them if you're unsure what they'll entail in terms of reversing the process or even repairing a bug or glitch yourself.

Then again, if you're reading this tutorial you're probably already fairly IT-savvy, so don't pay it too much heed. Everything has its own unique digital behavioural patterns, from the [latest O2 uk I phone 4](http://shop.o2.co.uk/update/iphone.html) to the newest Alienware MX. It's just a case of running checks before you start to ensure that you're prepared for any eventuality.

I hope this saves someone the 3 hours it wasted for me :)
