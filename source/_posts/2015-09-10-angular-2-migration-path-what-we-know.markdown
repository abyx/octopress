---
layout: post
title: "Angular 2 Migration Path: What We Know"
date: 2015-09-10 06:21:24 +0300
comments: true
facebook:
    image: /images/posts_images/migration-path.png
---

The main concern among us Angular developers recently has been the future of our existing Angular 1 apps. The community was abuzz with fears of apps they won’t be able to upgrade:

> *“Will it be possible?”*  
> *“Will it require a ton of work?”*  
> *“Will my boss never forgive me for making us write a huge app in a dead framework that we’d be stuck with?”*

In their [latest post](http://angularjs.blogspot.com/2015/08/angular-1-and-angular-2-coexistence.html) the core team shared some *very* positive changes.

**tl;dr** - Seeing the changes in the migration path makes me feel a lot more comfortable. It eliminates most of my fears about my existing Angular 1 projects and their future. *w00t!*

# What’s Newly Announced

Essentially, we’ll have **nearly complete interoperability** between Angular 1 and 2. I don’t know about you, but when I first read this I was literally going “*YES*” and did a fist pump.

The core team is working on `ng-upgrade`, a library that enables calling Angular 1 code from Angular 2 and vice versa.

## Directives and Services FTW

We will be able to migrate our directives and services one-by-one to Angular 2. These will still be able to inject Angular 1 services and use other Angular 1 directives. Also, code that you haven’t migrated yet will still be able to use them. Really, a dream.

## Baby Steps == Bigger Wins

I’m really pumped about this because it means we will really be able to migrate one little part at a time. Migrating whole routes - which was the previous suggested migration path - would have been really time consuming and tricky.

## Reducing Fears About Dependencies

A big thing we were worried about is getting stuck until all 3rd party code will be migrated as well.

These changes mean most libraries we use should still operate nicely even if they haven’t been officially migrated to Angular 2. *Sweet*!

# What remains to be seen

**No real code examples:**  The [ng-upgrade](http://github.com/angular/ngUpgrade) repository has **0** lines of code. Angular’s 1.5 milestone is currently dubbed *migration-facilitation*, so let’s cross our fingers and hope to see all this goodness come to life soon.

**What about controllers:** I’ve haven’t mentioned *controllers* anywhere in this post. We’ve known for a while that controllers are dead in Angular 2. We will probably have to convert them by hand. This is one more reason you should get used to using the controller-as syntax, pushing as much logic as possible out of your controllers and probably just using controllers less.

**ES5, ES6 and TypeScript:** The core team highly recommends doing Angular 2 in TypeScript. How hard will the conversion be? What will happen to those of us that decide to stay with ES5/6? They say all options will work, but we haven’t seen a lot of love for these setups yet.

# Should you start using Angular 2?

My answer remains the same as it was [a couple of months ago](http://www.codelord.net/2015/06/27/should-you-use-angular-2-dot-0-or-1-dot-x/): **Not yet**. You should start making sure your app is in shape for easier migration. More on that in the upcoming posts.

<!-- Begin MailChimp Signup Form -->
<div id="mc_embed_signup" class="cta">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Subscribe to learn how to prepare for Angular 2 &amp; avoid pitfalls!</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline"><!--
    --><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
    <div class="promise">~3 mails a month, unsubscribe anytime, no spam, promise!</div>
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
