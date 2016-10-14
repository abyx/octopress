---
layout: post
title: "Angular 2 Is Out: Should You Start Using It?"
date: 2016-10-09 21:41:21 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to make your Angular 1 app modern, step by step!"
cta_form: 109875
---

> “Should I learn Angular 1.x or Angular 2?”  
> “Can we start developing in Angular 2?”  
> “When should we start migrating our 1.x app to Angular 2, if ever?”  
> “Is anyone really using Angular 2 yet?”

In all the time I’ve been working in Angular and blogging about it, the most frequently asked question by far has been “when should I start using Angular 2?”
It’s been this way since it was announced 2 years ago.
Now that 2.0 has finally been released it’s becoming even more frequent.

I decided to put into writing the same answer that I’ve been giving my clients lately.

Keep in mind, this is my pragmatic recommendation for companies with teams, new hires, paying clients and business goals (i.e. businesses).

# tl;dr No Angular 2 in production yet

I think the responsible approach for anyone who needs to consistently ship features in the upcoming months and support the project they’re working on for at least a year, is to *wait and see how things turn out*.

Yes, Angular 2 is great.
Yes, I’m sure it’s going to be *sooo* stable and full of rainbows from now on.

*But maybe*, it’s gonna get changed some more in a significant way real soon.
I certainly don’t feel confident enough in its stability yet to recommend any company to invest hundreds of thousands of dollars and risk missing deadlines just to be on the bleeding edge.

# Why not just yet

## Changes are coming

I love the core Angular team, I trust them to be professionals and I’ve been making a living writing Angular for 4 years now.

And yet, I’m not as confident as they are about the near-term stability of Angular 2.
I’m pretty certain we’ll have some more medium-sized changes soon.

I mean, there were still major changes going on just 2 months ago.
And now we’re really really *really* done changing the router?
I hope so, but won’t be putting money on that.

Wait a few more months, see how things look after a few update releases.

## 3rd party libraries are still not baked

This is one of the most crucial points.
You don’t just want Angular 2, you want an ecosystem.

Lots of libraries are still working on finalizing their Angular 2 support (and given the previous section, can you blame them for not being ready yet?).

Writing a big project now means you might be able to use the final Angular 2.0, but most other libraries will be in alpha/beta.
It’s cool and edgy, but it’s not how you run a business.

## If you’re not into TypeScript you’re gonna have a bad time

The Angular 2 docs for plain JavaScript, both ES5 and ES6/2016 are still MIA.

The vast majority of material you’ll find is in TypeScript.
TypeScript looks very nice, and the team is pushing it very hard to be the default in Angular 2.

But can we be 100% certain that TypeScript will be the most popular way to do Angular in a year?
Google has a nasty track record with languages-that-compile-to-JS (*cough* GWT *cough* Dart *cough*).
Are we sure this is the one that’s going to take off?

And since TypeScript is used mainly in the Angular corner of the universe, it means investing in learning a language, tool chain, editors, and more - quite a leap of faith.

If you want to do it in JS, which is officially supported, you’re gonna have a very hard time finding resources right now.

Heck, there’s even Dart(*?!?*) documentation on the official site before the JS docs.
I mean, *come on*.

## Lack of docs and knowledge in general

In my side projects I might enjoy investing lots of time digging into a problem in order to understand how best to use a tool for a specific need.

At work, where my real intention is to deliver working products, I rather focus on my *business’s* problems and actually find answers for questions on Stack Overflow etc.
Yes, things are getting better, but they’re not quite there yet.

Not just for Angular 2 itself, but also for all the libraries which haven’t reached a stable release yet or aren’t widely used (i.e. all of them).

## Hiring experienced developers in the near term

I’ll be the first to say that any developer worth their salary should be able to learn whatever tool is thrown at her.
And yet, no one can become a master in something this complicated in a couple of days.

If you have business goals you need to accomplish and expect to hire more developers soon, it will be about an order of magnitude easier to get someone experienced in Angular 1.x than 2.

# Who should use Angular 2 in production?

Anyone that doesn’t care about the above.

That’s basically people working on small scale projects, POCs and prototypes.

# Then when should we start using Angular 2?

I used to think 2.1 would be a good time, but with the announcement of semantic versioning coming to Angular, it sounds like Angular 3 will be good time (expected to be released in Q1 2017).

# In the mean time

## LEARN

Just because you shouldn’t writing major projects in it at work doesn’t mean you can’t start prepping for it.

Start learning, do some tutorials, play with TypeScript, write a few sample apps (yes, you’re probably going to write another To Do app).

It’s good to be in the loop, and even if things change - you don’t care about maintaining your sandbox code, you just care about starting to be acquainted with the concepts.

## Don’t get stressed about the hype

The JS community is mainly obsessed with hype, and in our Angular part of the world, that means Angular 2 stuff.

You can’t open reddit/ng-newsletter/whatever without seeing Angular 2 posts.
Actually, on most of them the majority is Angular 2 posts.

This might make you feel like you’re the only one keeping the lights on for Angular 1.
You’re not.
Really.

I promise.

Heck, I wrote quite a few Angular 2 posts.
That doesn’t mean you should start using in in production just yet.

## Prepare your existing Angular codebase

Maybe in 6 months we’ll all as a community come to the realization that it’s best to rewrite all your existing code in TypeScript and Angular 2.

Maybe we’ll just settle on interoperability between Angular 1.x and Angular 2.

And maybe we’ll see Angular 2 needs some more time and keep at it with plain 1.x

(And yes, maybe you’ll decide that it’s best *for you* to drop Angular entirely. Ssssh.)

But, in just about 99% of the cases you’ll profit from making sure the current Angular 1.x development you do is *modern Angular 1.5*.

Writing component-based Angular, getting rid of controllers, etc. will benefit most code bases and make pretty much any future move easier.

I wrote about [some](http://www.codelord.net/2015/12/17/angulars-component-what-is-it-good-for/) [aspects](http://www.codelord.net/2015/09/30/angular-2-preparation-controller-code-smells/) [here](http://www.codelord.net/2015/10/07/angular-2-preparation-killing-controllers/).


I also plan on releasing a course about modern Angular 1.5 soon: the *Future-proof Angular Guide*.  
With this no-fluff course you'll learn how to quickly adapt your existing Angular 1.x app to the latest components paradigm, as you go about your regular work.  
You'll gradually turn your app into something that is modern and idiomatic, converting directives and getting rid of controllers.  
And then, once your app is shaped The Right Way™, you'll be able to keep shipping like a boss, and have your options open.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
