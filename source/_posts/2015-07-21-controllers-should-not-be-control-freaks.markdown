---
layout: post
title: "Controllers Should Not Be Control Freaks"
date: 2015-07-21 23:23:01 +0300
comments: true
categories: 
- Programming
- angular
- angularjs
---

It's super easy to get baffled about what *should* you put inside your controllers. Especially if your background is with frameworks touting MVC, you might think that the name "controller" in Angular indicates some kind of *control*.

The fact is, though, that the idiom in Angular is to keep your controllers extremely thin. That is the common paradigm, and is the general direction things are going as you can see in this [great and common style guide](https://github.com/johnpapa/angular-styleguide), the introduction of ["controller as" syntax](http://toddmotto.com/digging-into-angulars-controller-as-syntax/) and with [Angular 2's upcoming removal of controllers](http://boyan.in/angular-2-no-controllers/).

Let's try to make sense of the controllers' valid responsibilities.

# Why keep controllers thin?

There are several reasons people are gravitating towards smaller and thinner controllers. First and foremost, writing your code this way tends to result with more maintainable code. When you don't watch out controllers tend to become tangled beasts that take on too much responsibility. This makes it extremely hard to test them properly, reuse stuff and is just bad programming as agreed by everyone who's learned of the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle).

Add to that the fact that I already mentioned that Angular 2.0 is dumping controllers. No, you should not [start working in 2.0](http://www.codelord.net/2015/06/27/should-you-use-angular-2-dot-0-or-1-dot-x/) now or worry about it too much, but it does make sense to be aware of where things are headed and to start accepting the lessons the Angular community has learned and accepted.

# What should not be in controllers?

Getting technical, let's start with all the things that you should probably not put in your controllers.

- **Model logic**: Most controllers are responsible for manipulating/displaying a specific model and tend to take on the responsibility for managing that model. You should take that logic outside of the controller, preferably into a Model object that is a good old object. Yes, even though Angular doesn't have an `angular.model()` function it doesn't mean you can't still have them. Just create plain JavaScript classes or even use a service to declare the class of your models.
- **Business logic**: Business logic is important, changes a lot, and usually will be reused across multiple controllers as your app grows. Because of this it makes a lot of sense to create specific services for the different aspects of your business logic and use them from your controllers. This makes the logic easily testable and reusable.
- **HTTP stuff**: Probably the easiest way to get scolded on an Angular forum these days is to share code that's performing `$http` calls directly from your controllers. It has become common practice to hide this inside services as well, even if some Angular documentation has examples doing otherwise. Having a specific service for handling the requests of a certain aspect (e.g. a REST resource) means that you can easily find everyone that's using it and can make changes in a single place in case the server's representation of the object changes. Software engineering, who would've thought.
- **DOM manipulation**: There's a reason that controllers don't have access to their element easily. That's because DOM access is reserved to directives in Angular. You probably know this already, but still.
- **Complex view logic**: While controllers are bound to views and end up managing them, if you notice that your logic is become complex you should consider pushing it outside to a specific directive or maybe put some of the logic in a specific service.

# What *should* be in controllers?

After going through all the things that you should not put in your controllers, you're probably wondering WTF should you put in them. Actually, thinking about it, this is truly one of the cases where it would be shorter to list what should not be done (but less educational!).

Controllers with Angular zen should essentially map actions from the view to the different models and services, with as little logic as possible. Most of your controllers should be basic delegation once they've set up the view model on initialization.

In a way, good controllers *let go of control!*

Keep (cont)rolling!

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Don't miss the next Angular and frontend tip, subscribe! (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline"><!--
    --><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
