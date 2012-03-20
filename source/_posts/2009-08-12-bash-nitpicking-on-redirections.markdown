---
date: '2009-08-12 15:13:17'
layout: post
slug: bash-nitpicking-on-redirections
status: publish
title: Bash Nitpicking on Redirections
comments: true
wordpress_id: '46'
---

This little excerpt from the bash man page explains the reason I just wasted 2 hours:


_Note that the order of redirections is significant.  For example, the command
ls > dirlist 2>&1
directs both standard output and standard error to the file dirlist, while the command
ls 2>&1 > dirlist
directs only the standard output to file dirlist, because the standard error was duplicated as standard output before the standard output was redirected to dirlist._
