---
date: '2011-10-11 07:02:04'
layout: post
slug: submitting-your-first-patch-to-rubinius
status: publish
title: Submitting your first patch to Rubinius
comments: true
wordpress_id: '463'
categories:
- Programming
tags:
- github
- Programming
- rubinius
- ruby
---

I always love helping interesting open source projects, and Rubinius is one of those great projects that are very cool to play with. In case you don't know it, Rubinius is a Ruby implementation written (almost) entirely in Ruby. Just playing with such a code base is quite interesting and whenever a peek around in the code I learn new stuff about Ruby.

At the moment, the people at Rubinius are working hard on making it compatible with ruby 1.9, and so there are a lot of easy changes that are waiting for you to do and start contributing. I'd like to show you a quick walk-through of how to find such simple tasks and get started.


### Setup


Clone the project from the GitHub [repo](https://github.com/rubinius/rubinius). Once that's done, to make sure that everything works properly do this:

` ./configure
rake spec
`

The specs should be all passing on your machine. It will take a few minutes the first time, but afterwards whenever you make small changes it will be faster.


### Finding interesting work


Of course you can submit whatever patch you find interesting, but in my opinion a quick way to get started is to find incompatibilities with 1.9. Fortunately for you, it's pretty easy to find those.

Rubinius, along with the other Ruby implementations, uses mspec in order to have written specs of the language written in Ruby and is checked against that. These specs are similar to RSpec. Among other options, some specs are simply marked as having to pass only on Ruby 1.9 and of these, those that are currently failing are our hunt.

I came up with this command in order to find and execute such 1.9 specs that were last reported by Rubinius developers to be failing:

`bin/mspec tag --list fails -tx19 :ci_files`

This command will list the RubySpecs that are tagged as failing on Rubinius in 1.9 mode.

You should see plenty (at the time of this writing, over 500) of failing specs. Just pick something that seems easy enough to get started with.

Once you spot a spec that looks interesting you can run it specifically and see the code. For example, if you see an interesting spec for String#squeeze, you can run it with:

`bin/mspec -tx19 spec/ruby/core/string/squeeze_spec.rb`


### Doing some work


For example, let's look at one of the really simple specs I decided to get passing, you can see the commit [here](https://github.com/rubinius/rubinius/commit/723fc5ee6c57267c92744b24a100c595375ef39c). I wanted to make a simple change to the String#ord method, but only on 1.9 version. The way to do that on Rubinius is that many of the files, say string.rb now have also "string18.rb" and "string19.rb" that contain the code that differs. In my case, I just made a simple change to the version used on 1.9 by editing the ord method on the string19.rb file (in case the 19 and 18 files don't exist yet, you can simply create them like shown [here](https://github.com/rubinius/rubinius/commit/42fe03c5e6b82b712dcdbdf5875581f854e21af7)).

After you've made your changes, be sure to run the specs again and see that everything works. Before submitting it, you should make sure to run all specs thoroughly using the command rake spec. If all is well, just do the regular GitHub [pull-request dance](http://help.github.com/send-pull-requests/) and off you go!

Further than that, you can include in your pull request another commit that removes the failing tags from the specs you've just fixed. Find the appropriate file and just remove it, as you can see in [this commit](https://github.com/rubinius/rubinius/commit/bfde3637a454eade1972a636dd8a1ad05d9fdc57).

For some more in depth review of how to start contributing to Rubinius, see this [excellent post](http://rubini.us/2011/10/18/contributing-to-rubinius/) on the official blog.

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
