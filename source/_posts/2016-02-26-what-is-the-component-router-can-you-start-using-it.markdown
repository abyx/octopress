---
layout: post
title: "What is the Component Router? Can you start using it?"
date: 2016-02-26 10:32:10 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 27514
---

*Update:* The component router has finally been officially deprecated and discontinued.
You *should not be using it*.
This post is here for posterity's sake, but it goes to show how flakey our industry can really be.

A new router for Angular 1.x was announced over a year ago.
That router is usually called the Component Router, but you may have seen the name “new router” (or `ngNewRouter`) thrown around.

Its release keeps getting delayed.
Documentation is scarce.
The [GitHub repo](https://github.com/angular/router) is abandoned.

I keep seeing people wondering whether they should be using it and how.
Let’s try and answer those concerns.

# What is different about it?

The component router is aimed to make routing easier in a world of [components](http://www.codelord.net/2016/02/19/writing-pragmatic-angular-components/), like the awesome ones we got in 1.5.

It has some similarities to the Angular 2 router.

The component router also incorporates some features that have long been considered a standard in ui-router, such as nested routes.

The gist is that you define a *root component* - that’s the component that starts all your app’s rendering.

In it you render sub-routes using an outlet (`<ng-outlet></ng-outlet>`), much like the old `ng-view` or ui-router’s `ui-view`.

But, you can keep on nesting these outlets, which isn’t possible with `ng-view`.

You can read more in the [design doc](https://docs.google.com/document/d/1vl8_mA7rBSTVnPUMDiPpM37OPeM81SypKVvbBSuISgw/edit).

# Can you start using it?

Well, it hasn’t been released yet, but according to the [Angular weekly meeting notes](https://docs.google.com/document/d/150lerb1LmNLuau_a_EznPV1I1UHMTbEl61t4hZ7ZpS0/edit#heading=h.v9yw0ynxk8hq) it should be out very soon.

I wouldn’t start writing code in it just yet, but you should definitely spend a few minutes reading the code of [this demo](https://github.com/petebacondarwin/ng1-component-router-demo) by one of the Angular core maintainers.

And if you really want to play with it, that demo is a good starting point.

Once it’ll be out officially (hopefully in a couple of weeks) check this space for more information on using it and migrating your existing apps to it.

{% render_partial _posts/_partials/book_cta.markdown %}
