---
layout: post
title: "Do-It-Yourself Twitter Triggers for IFTTT"
date: 2013-06-21 13:59
comments: true
---

I like twitter, but some parts of it, like the fact you simply can't get all of your past tweets once you go over 3000 or so, make me crazy. Once I realized twitter data is write only, I started backing up my tweets and favorites to Evernote using the great [IFTTT](http://ifttt.com) service.

A few months ago twitter's changes caused [IFTTT's twitter triggers to no longer work](http://thenextweb.com/apps/2012/09/20/ifttt-removes-twitter-triggers-comply-new-api-policies/). I quickly hacked up a workaround using the deprecated twitter RSS feed API and [blogged about it](http://www.codelord.net/2012/10/12/poor-mans-ifttt-twitter-triggers/).

A week ago twitter finally took down the deprecated API, rendering my hack useless and me IFTTT-less once more. I saw no simpler way than writing my own little server that uses twitter's new API to actually fetch my twitter streams as JSON and translate them into RSS so that I could easily wire that up to IFTTT.

Lucky for me it required less than one hour and roughly 50 lines of code. Setting it up on heroku is free and works smoothly so far. In case you would like to use such a server yourself I've made the code public with instructions to do so [here](https://github.com/abyx/fweets).

Hope you find this helpful!
