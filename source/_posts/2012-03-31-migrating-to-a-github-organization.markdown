---
layout: post
title: "Migrating to a GitHub Organization"
date: 2012-03-31 17:19
comments: true
---

Recently we finally made the move to a GitHub organization. For the past 18 months or so we've been using private repositories on our CTO's personal GitHub account. Having reached the maximum number of allowed collaborators on a personal account, we decided to make the move.

Basically, it wasn't that big of a deal at all, but since I couldn't find any writeup describing it I thought I'd throw it here.

When you want to create a new organization, you can either choose to transform your own account into an organization or just create a new one. We opted for creating a new organization for BillGuard in order to avoid causing Raphael an identity crisis.

The steps were amazingly easy:

   1. Create a new organization.
   2. Add to its owners whoever needs to be an owner (up till now you had no owner except for the actual account holder).
   3. Create a team for everyone that needs access to the repositories. We started simple with a team for developers that allows pushing and pulling.
   4. For each repository that needs to be migrated go to its Admin section, choose "Transfer Ownership" and move it to the new organization.
   5. Now everywhere you have a migrated repository cloned needs to run this simple command: `git remote set-url origin git@github.com:ORGANIZATION/REPO.git`

That's it! GitHub magically moves the different web hooks, server deploy keys etc. that were configured on the repositories so they keep working.

Some things to note: In case your repositories have been forked, you need to contact GitHub support to change roots as described [here](http://help.github.com/move-a-repo/). Also, you might need to change repository URL someplace else like your CI servers.

Happy git hacking!

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) to my feed or [follow](http://twitter.com/avivby) me on twitter!
