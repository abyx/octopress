---
date: '2011-11-30 23:23:43'
layout: post
slug: how-i-moved-my-wordpress-blog-from-dreamhost-to-a-free-ec2-instance
status: publish
title: How I Moved My WordPress Blog from Dreamhost to a Free EC2 Instance
comments: true
wordpress_id: '660'
---

Just recently my Dreamhost plan, the one this blog is hosted on, expired and I had to renew it. Seeing the amount of money they took charge me realize that surely I can find something cheaper than >$10/month. After some snooping around I've settled on moving my WordPress blog to EC2. This is my story.

_Disclaimer: this worked for me. If you lose your blog, too bad. Backup is your friend, my friend. You need some devops-chops to follow along._

After being tipped of by a couple of friends, I decided to look into setting up my site on EC2. Basically, my blog is really small (the WordPress export file is about 2MB), and it's not like I get tons of traffic. That alone means that for a year now I can use the EC2 free tier, making this blog cost pretty much nothing.


### Initial setup


First step was to register and AWS account. I created a micro instance, which is enough for most blogs and free for a year. The AMI (image) of the instance I used was Bitnami's prebundled WordPress image, which you can read more about [here](http://bitnami.org/stack/wordpress). Do make sure to create your instance on an EBS and not instance store. That means that the data will be persistent. Change the instance's security group to allow connections to port 80 (HTTP) and port 22 (SSH) from any IP.

You can assign a static IP to your instance for free! Just allocate a new Elastic IP on the EC2 console and attach it to your instance. Note that Elastic IPs cost nothing while attached, by if they aren't attached your bill will start growing (after all, fresh IPs are a rare resource).

So you've got your instance up, eh? You can point your browser to your instance's public DNS name, like so http://ec2-something-something.com/wordpress and see the default WordPress hello page. Go to /wordpress/wp-admin to login as admin (the default bitnami user/password are user/bitnami). Here you can start and setup your blog again.


### Importing


On your original blog, you can use the export utility and then import all your posts and comments to the new machine. Easy as pie. If you have a lot of plugins and configurations, you might want to search for one of the many plugins that do that for you. If you're like me and only have a couple of plugins and one theme, installing them manually takes about 3 minutes.


### Moving WordPress to the root of the site


If you'd like to move WordPress to the root of your site (/ instead of /wordpress), remove the path from the General settings page and then SSH to the machine. Replace the first two lines of the file /opt/bitnami/apps/wordpress/conf/wordpress.conf with:

    
{% codeblock lang:apache %}
Alias / "/opt/bitnami/apps/wordpress/htdocs/"
{% endcodeblock %}

Then, go to /opt/bitnami/apache2 and do:

{% codeblock lang:bash %}
sudo ./bin/apachectl restart
{% endcodeblock %}

### Gotchas


Got permalinks? You'll need to:

    
{% codeblock lang:bash %}
chmod g+rw /opt/bitnami/apps/wordpress/htdocs/.htaccess
{% endcodeblock %}


Want to receive email notification for new comments etc.? You'll need to do:

{% codeblock lang:bash %}
sudo apt-get install sendmail && sudo ln -s /usr/sbin/sendmail /usr/bin/sendmail
{% endcodeblock %}

If you have attachments in any of your posts, you might need to fix the URL after the final move.

### Testing


Make sure all your links, widgets etc. are working before making the final move. Post something, add a comment.


### Going live


In the General settings panel, change the URL of the blog to your domain. Go to wherever you were hosted before, find the DNS panel and change the DNS entries for your blog. Danger: This is an "expert" step, and if you don't know what it means, I recommend grabbing someone with more knowledge. Change the A records for your domain to point at the elastic IP you gave your instance. That's it! Wait a bit for DNS propagation and everything should be working!


### Backups


I found out about the [backup to dropbox plugin](http://wordpress.org/extend/plugins/wordpress-backup-to-dropbox/), which simply uploads all your blog to dropbox! Sweet, awesome and easy for small blogs!


### Costs


So, using 1 micro instance with an EBS store of 10GB is free for the first year. Given nothing crazy in terms of network, you shouldn't be paying at all for the first year, maybe about $1 a month. After that year passes, the instace and EBS store start kicking in. If you're in it for the long run, like me, paying for the instance a year in advance costs about $9/month (3 years is like $7), and the EBS store costs $0.1 per GB, meaning $1. That's about $10-$8/month, depending on how you pay for the instance. A great save compared to Dreamhost!

You should [susbcribe](http://feeds.feedburner.com/TheCodeDump) to my feed and [follow](http://twitter.com/avivby) me on twitter!
