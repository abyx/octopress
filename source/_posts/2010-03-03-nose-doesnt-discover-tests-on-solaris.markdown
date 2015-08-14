---
date: '2010-03-03 16:05:31'
layout: post
slug: nose-doesnt-discover-tests-on-solaris
status: publish
title: nose doesn't discover tests on Solaris
comments: true
wordpress_id: '138'
---

**Note:** this is a technical post, to help poor souls that google this :)

When using _nose_ on Solaris machines, simply running `nosetests` without specifying the file names will not work if you are the root user. To fix this, you must either not be root, or pass _nose_ the argument `--exe`. That's it.

Gory details: by default, _nose_ ignores executable files. Each file it encounters it checks with `os.access(test_file, os.X_OK)` to see if it's executable. Problem is that Solaris' `access` function always returns success for root, regardless of actual file permissions. This is discouraged by POSIX, but known behavior.

Ensuring that you're aware of known behaviours is crucial, as it prevents you from looking up issues with software unnecessarily. Of course, you can find these out on the web and it's not difficult to test run them if you're unsure what they'll entail in terms of reversing the process or even repairing a bug or glitch yourself.

I hope this saves someone the 3 hours it wasted for me :)
