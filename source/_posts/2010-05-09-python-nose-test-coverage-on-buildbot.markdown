---
date: '2010-05-09 19:03:07'
layout: post
slug: python-nose-test-coverage-on-buildbot
status: publish
title: Python (nose) Test Coverage on Buildbot
comments: true
wordpress_id: '155'
categories:
- Programming
- testing
tags:
- buildbot
- nose
- Programming
- testing
---

Once we got our builds happily running on Buildbot, there's really no reason not to add coverage since it's so easy (especially if you get bragging rights over your non-TDDers teammates).

All you have to do is this (code is based on this [blog post](http://copypasteprogrammer.blogspot.com/2010/03/buildbot-and-nose-test-coverage.html), with adaptations to work on slaves that don't share directories with the master, since the createSummary method runs on the master):

{% gist 395269 %}
