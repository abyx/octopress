---
date: '2010-12-19 22:30:48'
layout: post
slug: using-puppet-to-automatically-configure-new-ec2-instances
status: publish
title: Using Puppet to Automatically Configure New EC2 Instances
comments: true
wordpress_id: '308'
categories:
- Programming
- techie
tags:
- ec2
- puppet
- techie
- tips
---

_Note: I posted an update about doing the same with chef [here](http://www.codelord.net/2011/03/07/using-chef-to-automatically-configure-new-ec2-instances/)._

This is a quickie techie post that summarizes a few hours of learning that I wish someone else had put up on the web before me. I assume some knowledge about Puppet, and recommend the [Pro Puppet](http://www.amazon.com/gp/product/1430230576/ref=as_li_tf_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=217145&creative=399381&creativeASIN=1430230576)![](http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=1430230576&camp=217145&creative=399381) book and heard good stuff about [Puppet 2.7 Cookbook](http://www.amazon.com/gp/product/1849515387/ref=as_li_ss_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=1849515387)![](http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=1849515387).

So, I wanted to be able to configure via Puppet the way our new instances should be configured, and then be able to easily spawn new instances that will get configured by said puppet. The first part is [installing](https://help.ubuntu.com/10.10/serverguide/C/puppet.html) puppetmaster. I decided to manually setup an EC2 instance that will act as the puppet master:

{% gist 747614 install_master.sh %}

Under /etc/puppet/manifests/site.pp we place the "main" entry point for the configuration. This is the file that is responsible for including the rest of the files. I copied the structure from somewhere where the actual classes were put under /etc/puppet/manifests/classes and import it in site.pp. Do note that currently this setup only supports a single type of node, but supporting more should be doable using [external nodes](http://docs.puppetlabs.com/guides/external_nodes.html) to classify the node types.

{% gist 747614 site.pp %}

{% gist 747614 classes/default_node.pp %}


## Auto-signing new instances


A common problem with puppet setups is that whenever a new puppet connects to the puppet master it hands it a certificate which you then have to automatically sign before the puppetmaster will agree to configure it. This is problematic in setups like mine where I want to be able to spawn new instances with a script and don't hassle with jumping between the machines right after the certificate was sent and approving it. I found two ways to circumvent this:


### 1. Simply auto-signing everything and relying on firewalls


In case you can allow yourself to firewall the puppetmaster port (tcp/8140) to be only accessible to trusted instances, you do not actually need to sign the certificates, you can tell puppet to trust whatever it gets and leave the security in the hands of your trusty firewall. With EC2 this is extremely easy:



	
  * Setup a security group, I'll call mine "puppets"

	
  * Add a security exception to the puppetmaster that allows access to all instances in the "puppets" group

	
  * Create all puppet instances in the "puppets" security group

	
  * Configure puppet to automatically sign all requests: echo "*" > /etc/puppet/autosign.conf


I decided to go with this solution since it's simpler and less likely to get broken. I didn't see it documented anywhere else. The downside is that you've got to have your puppetmaster on EC2 too.


### 2. Automatically identifying new instances and adding them


This is a solution I saw mentioned a few times online. Using the [EC2 API tools](http://aws.amazon.com/developertools/351?_encoding=UTF8&jiveRedirect=1) write a script that gets the DNS names of all the trusted instances you've got and write them. Once you have this getting it to run with a cron job every minute will do the trick. This can be done with sophisticated scripts, but for my (_very initial_) testing, this seemed to work:

{% gist 747614 cron %}


## Getting new instances to connect to the master


The last piece of the puzzle. Since we use Ubuntu, we could simply use the [Canonical-supplied AMIs](http://alestic.com/2009/04/official-ubuntu-ec2). These support [user-data scripts](http://alestic.com/2009/06/ec2-user-data-scripts) that are executed as root once the system boots. Below is a simple script that does this:



	
  1. Update the instance

	
  2. Add the "puppet" entry to DNS - puppet expects the master to be accessible via "puppet" DNS resolution. This little snippet gets the current IP of the master via our DNS name and writes it to /etc/hosts

	
  3. Install & enable puppet and voila!




{% gist 747614 start_puppet.sh %}


Once all of this is up and running, creating a new instance is as easy as:

ec2-run-instances -g puppets --user-data-file start_puppet.sh -t m1.small -k key-pair ami-a403f7cd

Happy puppeting!

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
