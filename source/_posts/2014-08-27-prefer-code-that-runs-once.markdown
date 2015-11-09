---
layout: post
title: "Prefer Code that Runs Once"
date: 2014-08-27 18:22:25 +0300
comments: true
---

While working with clients I've noticed that a lot of startups that are in the "move fast" mentality seem to abuse the great tools we now have.
In a world where you can have all your stack be in dynamic languages, and your storage totally schema-less (e.g. MongoDB) you may be tempted to postpone committing to changes in the data model for too long. Effectively, many companies don't really have a data model. They have this blob of data.

A lot of us might feel the client side is more flexible and safer for making quick changes than the server or database are. For example, you may decide a certain field in your model that is currently just a string should instead be an object. Yet you'd rather do the quick win and not migrate all of your data. Instead you simply have your client run a transformation on the data it receives if it notices that it is using the old format.

Seems like an easy win, right? It means you only make changes in the client code, you don't need to think too hard about running a migration on your backend, etc. And that's actually what I might do first, when just trying to choose the right change to make.

But let's take this a couple of months forward. You're a tiny startup, with barely any real amount of data and still lots of changes to be made. Yet your code is starting to get bloated with conversions and hacks. Half of the data is getting transformed in the client to provide it with a consistent data model (or, worse, the different `if`s etc. are scattered all over your code). Making changes means you have to understand this whole map of conversions and you have to maintain all this boilerplate code. And of course, if you ever decide to add, say, a native mobile app it can't rely on your API and has to do all those transformations again. Fun, right?

Instead, you could go with writing code that runs just once. Don't have transformations that happen whenever someone refreshes your site. Write your transformation (or... can I use the word "migrations" without scaring too many people nowadays?) and have them... you know... *transform* the data. Right there and then. That's it. You just run it and then you can forget about that code. You don't need to maintain it. You don't need to debug it. It won't slow up your UI's startup time. There's significantly less code to futz around with. 

And the best part is that you get everything to be synced. All your clients, be they native apps, JavaScript rich apps, etc. use the same data model. That's the same data your server has. It might even be the same data that you can then query on your database! No need to transform in your head what you see in the database and how that probably looks to your client after it did its business.

Code that runs once is easier to write and verify, can be effectively forgotten later, and gives use familiarity. Because our jobs are hard enough and we need all the time we have to try to solve real problems. You want to be able to move on from your previous schema mistakes, not to have to drag it around with you forever.

Can you find a chunk of code that can run one last time, today? Do it, make the world a better place.

{% render_partial _posts/_partials/cta.markdown %}
