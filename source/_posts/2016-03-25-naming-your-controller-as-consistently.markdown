---
layout: post
title: "Naming Your Controller-As Consistently"
date: 2016-03-25 10:26:09 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 35689
---

Conventions have always been a problematic part of Angular, especially when they seem to change all the time.

A very common issue that I’ve been asked about again and again is *what name to use in controller-as*.

Here are my 2 cents on a style that, to me, makes the most sense.

First, understand that the options basically divide to either using the same name in all your components/directives, or to use a specific name in each.

I strongly recommend to *use the same name* in all templates. It means less typing, less thinking about boring details and of course means easier refactoring down the road.

Now, the question is what name should you use.
Prior to Angular 1.5, the community seems to have settled on “vm” as the name (e.g. that’s the default in [John Papa’s style guide](https://github.com/johnpapa/angular-styleguide)).

But, with the introduction of components in 1.5 the default there is now “$ctrl”.
Even though I personally dislike the look of `$ctrl` I have to recommend sticking to it.
It is only a matter of time before this becomes the de-facto standard as the community upgrades to 1.5.

## What about referencing parent controllers??

One of the arguments I’ve heard quite a bit for using a different name in each directive/component is so it will be possible to reference parent controllers in the scope.

But, you should *never* do that.
Your scopes should virtually always be isolated, so that name clashing would be impossible.

And in the (truly) rare occasion where you do reference some parent controller you should do it using the `require` mechanism.

<hr>

Do you have a big *Angular 1.x app* that you're scared will *rot and become legacy code*? Because 2.0 and TypeScript will soon be *the new shiny* yet you have *all this JS code* sitting there? Where will your team find the time, and *management approval*, to learn and move things to 2.0?

But what if you could *migrate your project*, incrementally, while keeping your time's pace and shipping awesome code? What if your team could learn a bit more Angular 2 with each task? Imagine you could get to be *working in 2.0 land without ever stopping your development*!

I'm cooking up a self-served course that will get you there. It will allow you, *on your own pace*, learn Angular 2 and TypeScript bit by bit. With those steps your team will migrate your project and soon you'll write all your new code with Angular 2, TypeScript, and *won't have to stay behind*.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
