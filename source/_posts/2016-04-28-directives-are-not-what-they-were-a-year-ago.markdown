---
layout: post
title: "Directives are not what they were a year ago"
date: 2016-04-28 10:02:38 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 47390
---

Since the very early days of Angular, directives have been one of the gnarliest pieces to grok and wrap your head around.

There have been countless of posts on forums and groups asking *what exactly are directives* and what should they *be used for*?
And thousands of words were published trying to answer these questions.

But, most of those *no longer hold true*.
If you’re just getting into Angular 1.x, most of what you’ll find online about the role of directives is *outdated*.

And if, on the other hand, you’ve been doing Angular for quite some time now, then you should know that *things have changed*.
The community is flowing in a different direction, and you should get with it (or at least know what you’re missing out on).

# The “old” thinking behind directives

In the first version of Angular, controllers were held as a very big part of the framework where most of the logic would lie.

Directives, it was commonly said, should be used only for *DOM manipulation* or for *reusable components*.

When learning Angular, you’d be told that you can wait with learning about directives, since you rarely write ones yourself.
After all, with the awesomeness of Angular you don’t need to reach your hands down to the DOM on a daily basis.

And, really, how many reusable components do you write in a given week?

# The new standard - directives and components for ALL THE THINGS

Over the past year, Angular 2 has matured and the [migration path](http://www.codelord.net/2015/09/10/angular-2-migration-path-what-we-know/) to it is getting clearer.
With that, the Angular team have been moving Angular 1.x towards these new concepts.

We know that controllers are *gone* in Angular 2, and you should be [killing yours](http://www.codelord.net/2015/10/07/angular-2-preparation-killing-controllers/).

The old/new stars are *directives*, mostly in their fancy new cloths as *components*.

I’ve written before about [what components are](http://www.codelord.net/2015/12/17/angulars-component-what-is-it-good-for/) and [how](http://www.codelord.net/2016/02/19/writing-pragmatic-angular-components/) you should [use](http://www.codelord.net/2016/04/14/angular-1-dot-5-new-component-lifecycle-hooks/) them.
90% of the time you should be able to use a component instead of writing a directive.

And you should basically no longer be writing any controllers that are not directive-controllers or component-controllers.

Yes, even if that directive is not reusable at all and will only be used in a single place.
And even though there’s no DOM manipulation going one.

*The world is changed*.
Do not shy away from directives.
Nowadays, Angular consists of UI code in directives/components and logic in services.
That’s it.

## What to use directives/components for

- Pages
- Reusable components
- DOM manipulation
- Wrapping up non-Angular widgets
- Non-reusable components (e.g. just breaking up a bigger component to smaller pieces)
- Routes

Basically, **the rule of thumb** is: *don't* use controllers, put logic in *services*, everything else is in components.

{% render_partial _posts/_partials/book_cta.markdown %}
