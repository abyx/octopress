---
layout: post
title: "Poor Man's IFTTT Twitter Triggers Hack"
date: 2012-10-12 16:53
comments: true
categories: 
- Programming
- Twitter
- IFTTT
- python
- tornado
---

Ever since IFTTT were [forced to remote][1] Twitter triggers I, as many others I'm sure, was having problems getting similar, trivial tasks done without a lot of work.

After a bit of searching I found out that twitter's v1 API has RSS feeds, which IFTTT supports. Though that API will probably be shutdown in March since it's deprecated, I discovered that for now it can be a decent replacement to some stuff I used to do with twitter triggers.

## The simple stuff

I used to have IFTTT tasks that evernote'd my tweets and favorites for future reference. I found out that these were easily replaceable using the [timeline][2] and [favorites][3] feeds, and then wiring IFTTT to listen to these feeds and save their contents to evernote.

## Where things got messy

I've set up a tumblr that basically just monitors links (photos actually) that two awesome dudes tweet at eachother, for prosperity. [The Feathers-GeePaw][4] was got a new post via IFTTT everytime a tweet appeared from @mfeathers to @GeePawHill starting with a link ("http"). Now unfortunately, this wasn't trivial to mimic using feeds.

Though IFTTT's feed triggers allow matching, which would hopefully would have allowed matching the right tweets and links, it doesn't allow extracting the link.

### The workaround

I spent an hour whipping up a simple proxy tornado server running on Heroku that does the easy filtering job by itself and set IFTTT to poll that thread. The hacky code is available [here][5] (you would have to excuse the poor name I chose).

## The future

As I mentioned, the v1 API is going to die in March. I'm hoping that by then IFTTT would find a better workaround, or I will have to implement a few more of these dumb proxies, these time in the v1.1 API (which requires actually setting up a twitter development account and authenticating for each request).

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!


[1]: http://thenextweb.com/apps/2012/09/20/ifttt-removes-twitter-triggers-comply-new-api-policies/
[2]: https://dev.twitter.com/docs/api/1/get/statuses/user_timeline
[3]: https://dev.twitter.com/docs/api/1/get/favorites
[4]: http://feathersgeepaw.tumblr.com/
[5]: https://github.com/abyx/mfeatherss
