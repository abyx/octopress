---
date: '2011-07-27 21:10:58'
layout: post
slug: why-i-regret-choosing-rightscale
status: publish
title: Why I Regret Choosing RightScale
comments: true
wordpress_id: '416'
categories:
- Programming
tags:
- chef
- ec2
- puppet
---

A few months ago we had to decide on some framework/environment to use for our devops needs. I've blogged about my experiences with [Puppet](/2010/12/19/using-puppet-to-automatically-configure-new-ec2-instances/) and [Chef](/2011/03/07/using-chef-to-automatically-configure-new-ec2-instances/) on EC2. Somehow, we eventually ended up using [RightScale](http://www.rightscale.com).

Quick disclaimer: this is not a rant and I don't intend any bashing. It's just a report of my impression from using it.

RightScale provide a system for configuring and managing your cloud infrastructure, from defining how servers are created to monitoring and changing them. RightScale has a few nice features. It has a pretty nice clustering setup of MySQL solution for EC2. It also has decent monitoring and alerting capabilities.

My main problem with it, though, is that they basically took a few steps backwards from all other known solutions, making my life so much harder. I've pointed most if not all of these issues to RightScale on twitter and private emails, yet I can't imagine seeing these issues solved any time soon.


#### Scripting (Dis)Abilities


If you've used Chef or Puppet, you probably got hooked on the ease of managing and creating your own set up scripts. RightScale's solution, RightScripts is a weaker, 1990ish kind of solution:

  * No templates - remember the days you had files with placeholders like `@@REPLACE_HERE@@` to `sed` out? Know how nice are real templates in Chef for example, where you can use .erb files? Well, with RightScale it's all gone again. Sed away.
  * No dependencies - RightScale do have a nice RightScript to install MySQL. Problem is, it depends on a bunch of other scripts and there just isn't any link to it. Install it, hopefully find a reference for dependency name in README. Install dependency. Look for its dependencies. Error prone and tiresome.
  * Made up version control model - No longer can you use git to update and manage your scripts. RightScale has a dumb-down version control system where you can "commit" changes to scripts you make. These aren't accessible locally on your machine and lack all the nice features of real VCS: can't grep, can't search history. You can't do a `git status` and see what has changed all over your servers. Chaos.
  * Scripts are edited in text areas - that's right. That means I'm constantly copying the script from the browser to vim, edit it, copy back and save.
  * No easy sharing of scripts - with Chef you could download cookbooks from all over the internet. With RightScale you're limited to a closed and pretty empty market of rightscripts.
  * No composability - say you've got a generic script to attach an EBS volume to a server. Want to attach 2? Thought you can just call the script twice with different parameters? Wrong! You can't. Only option is to copy and paste the script with a new name and new parameter names.

Some of these issues might be solved soon, since RightScale seem to be working on enabling use of Chef for scripts. We've tried to set up this beta on our installation but got a lot of exceptions and left it as it is for now.

#### Mouse Control

The UI is centered around clicking way too much. They're pretty nice monitoring dashboard per machine is not configurable. That means that for each and every server we have a routine of doing over a few graphs, clicking and dragging stuff the way we like them. Want to change alert type of a server? Click them all one by one. Need to run a script on all your servers? Click, click, click. This is a painstakingly slow process that makes me feel undervalued each and every time.

#### No Automatic Updates

The beauty of systems like Chef and Puppet is that you can make a change in the configuration and it will automatically get to all of your servers. That's not the case here. You have to go over each server, figure its state and then run the proper scripts.

#### Bottom Line

If you have decent coding ability and know your way around a server, chances are you'd be better off no using RightScale. There's just so much you'll be missing out and a major time waste. I truly hope to see these issues taken cared of, but I think we're far from it.

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
