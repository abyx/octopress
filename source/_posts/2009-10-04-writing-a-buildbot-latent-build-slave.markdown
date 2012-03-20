---
date: '2009-10-04 21:33:24'
layout: post
slug: writing-a-buildbot-latent-build-slave
status: publish
title: Writing a BuildBot Latent Build Slave
comments: true
wordpress_id: '50'
categories:
- Programming
---

We've been working on creating a scalable and stable building and testing environment for our team.
After some checking, [BuildBot](http://buildbot.net) was found to be the best (for our needs, at least).

Gathering the different abilities that are needed for testing our products, and the different limitations we've got in our testing lab, we came to the conclusion that using some sort of distribution framework is needed. Being the code monkeys that we are, we started designing a whole solution for integrating BuildBot with our distribution framework of choice, when looking at the BuildBot manual I saw it already has support for this concept, the Latent Buildslave !

One small thing is, that adding support for a new one isn't so clear. The [manual](http://djmitche.github.com/buildbot/docs/0.7.11/#Writing-New-Latent-Buildslaves) simply states that one needs just to implement start_instance and stop_instance methods and be done with it, but, in my opinion, lacks some details, so here is what we figured:



	
  1. The start_instance method should return a [deferred](http://twistedmatrix.com/projects/core/documentation/howto/defer.html) that, when called, will return once a new build slave is ready to go.

	
  2. How do you return the new slave's IP to BuildBot? No need! Once it will be connected, the master will figure it's the one you just created (via AbstractLatentBuildSlave.attached).

	
  3. The actual value returned from start_instance is pretty insignificant (will be printed to the log, as the manual states).

	
  4. The stop_instance method is pretty much the same, and should take care of making the distribution framework aware that the allocated buildslave is free to be destroyed/reused.




### Why don't my latent slaves die?


As you may have noticed, once _start_instance_ is called and a slave connects to the master, BuildBot is in no hurry to call your _stop_instance_ once the build is completed. Actually, as far as BuildBot is concerned, that slave is there to stay (at least, as far as we figured). In case you'd rather to generate a new slave for each build, you will need to override the _buildFinished_ method of the abstract slave, and in it call the _unsubstantiate_ method. A bit of a headache, but that's the way it is.

Happy testing!

P.S. If you're using the latest BuildBot (from the git repository), try out the Console view, it's really awesome!

You should follow me on twitter [here](http://twitter.com/avivby).
