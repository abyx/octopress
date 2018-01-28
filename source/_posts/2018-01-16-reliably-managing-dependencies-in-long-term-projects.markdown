---
layout: post
title: "Reliably Managing Dependencies In Long Term Projects"
date: 2018-01-16 16:20:59 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 325426
---

When you started working on your codebase, you probably set it up with the latest versions of all your dependencies–Angular, React, Node, the whole shebang. 

And at the early stages of a project, especially before going live, it’s relatively easy and fun to always be using the latest shiny.

But, eventually you come across a problem.
Simply updating some dependency has caused an issue that may just have cost you some time debugging, and at worst has caused a major issue that was only found out some time later.
Once these happen once or twice, I see my clients go from trigger-happy-update-hippies to get-off-my-lawn only-update-if-absolutely-necessary-sceptics.

And, frankly, it’s hard to blame them.

Especially after a few too many times of playing whack-a-mole with issues that surface because of an update, and later realizing that had you just waited a month or so, most of these issues would already be gone (e.g. because they would get fixed, or because other people would have already tackled them on Stack Overflow).

But once you go into the never-upgrade camp, you’re setting yourself up for issues later on again.
For example, eventually one of your dependencies will have an important fix/feature that you want _now_, but upgrading it requires upgrading other dependencies.
But, since things have been left stale, you have to sift through so many breaking changes of dependencies, and that’s if you’re lucky and the dependencies have proper documentation.

For example, I recently saw a client that needed a simple update to their e2e testing framework require upgrading _8_ more direct dependencies, some as major as “oh, we need to upgrade a major Node version for this and update our CI chain with it”.
Ain’t nobody got time for that!

## The Just-Right Upgrade Path

The pragmatic solution, maybe obvious at this point, is to have a process for upgrading gradually and with a schedule.
If you’re in it for the long game, and plan on supporting your product for years on, you have to get some recurring task that reminds you to go over your dependencies and see which have updates that are, say, a month old.

Go over those, read their changelogs, make the changes necessary to upgrade and test things in isolation.

Yeah, it’s a hassle to do this in an ongoing fashion, but from my experience it’s always easier than dragging it out until the absolute last minute, when you’ve already got balls to the wall.

{% render_partial _posts/_partials/book_cta.markdown %}
