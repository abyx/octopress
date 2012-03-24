---
date: '2011-03-07 21:56:38'
layout: post
slug: using-chef-to-automatically-configure-new-ec2-instances
status: publish
title: Using Chef to Automatically Configure New EC2 Instances
comments: true
wordpress_id: '348'
categories:
- Programming
- techie
tags:
- chef
- ec2
- Programming
- puppet
---

This is a follow up post to my [post about using Puppet](/2010/12/19/using-puppet-to-automatically-configure-new-ec2-instances/) to get the same result. In the comments to that post I was told by a few people that chef can make my life easier and I decided to give a try. Here's what I came up with.

In this post, as in the previous one, our goal is to be able to start a new EC2 instance with one command, which will in turn be created and started with Apache running.

First of all, instead of having to set up our own server to tell the newly created instances what to do, we are going to use a hosted chef server on Opscode's server. The hosting is free for 5 nodes, and so you can try this out without having to pay them. Go to [Opscode's site](http://opscode.com) and register a new user, then also add a new organization.

On our system, we need to start by installing chef. You will also want to install the dependencies needed to make chef talk with EC2 (these are not installed automatically when installing the gem because they're optional):

{% gist 859076 install.sh %}
Now, we need to setup a chef repository. This repository will contain our cookbooks (libraries that contain recipes, which are scripts for doing stuff, like installing apache) and roles (which map recipes to nodes), among other stuff. To get it run:
{% gist 859076 clone.sh %}
In the repository create a .chef directory. Now back on Opscode's site, you need to download 3 files: your organization's validator key, your user's key and a generated knife.rb. Once installed, copy them all to the .chef directory:
{% gist 859076 cp.sh %}
These will be used by the new instances to connect to Opscode and identify themselves as truly being created by you (this saves us from having to hack an awkward solution for this to work on Puppet).  Add to your knife.rb file your AWS credentials:
{% gist 859076 knife.rb %}
We will now fetch the apache2 cookbook, which will allow us to install apache on our instances by adding a single configuration line. To download an existing cookbook, do the following:
{% gist 859076 download.sh %}
You can see what other cookbooks are made available by looking around [here](http://github.com/opscode/cookbooks). Now, we'll create a role for our instances. Create the file roles/appserver.rb with this data:
{% gist 859076 appserver.rb %}
And to update our Opscode server with the new cookbook and role:
{% gist 859076 upload.sh %}
We're getting really close now! You should have a security group define in AWS that has port 22 (SSH) open, for knife to be able to connect to it and configure it, and port 80 (HTTP) for our Apache to be available. I called mine "chef". You will also need to decide with AMI (image) to use, you can find a list of AMIs supplied by Opscode [here](http://wiki.opscode.com/display/chef/Amazon+EC2+AMIs+with+Chef).  And now, to create an instance with one command line, as promised:
{% gist 859076 create.sh %}

This will take a while, as knife will create the instance, connect to it, install ruby, chef itself, apache etc. Once it says it has finished simply copy the public DNS of the newly created image (it should be printed once knife finishes) and open it in your browser. My, what a sense of accomplishment one gets from seeing the string "It works!"

I find this a lot easier, cleaner, stream-lined and fun. I'm still learning the ropes with chef, but it has already surprised by being easy to change, being completely git-integrated and by Opscode's fast support (even for non-paying customers). You can dig further [in](http://wiki.opscode.com/display/chef/Quick+Start) [these](http://wiki.opscode.com/display/chef/Launch+Cloud+Instances+with+Knife) [links](http://help.opscode.com/kb/start/how-to-get-started).

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
