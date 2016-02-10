---
layout: post
title: "Angular 2 migration: what's ng-forward?"
date: 2016-02-03 11:47:29 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Don't let your Angular 1 app become legacy, learn how to upgrade it!"
cta_form: 22340
---

Angular 2 keeps getting closer (beta2 was just released).
This means everyone are getting more anxious and worried about the future of their Angular 1 code.

The [migration path](http://www.codelord.net/2015/09/10/angular-2-migration-path-what-we-know/) keeps getting clearer.
I’ve [shown](http://www.codelord.net/2016/01/07/adding-the-first-angular-2-service-to-your-angular-1-app/) [before](http://www.codelord.net/2016/01/14/adding-the-first-angular-2-component-to-your-angular-1-app/) how easy it is to start integrating ng2 in your existing apps with ng-ugprade.

Yet I keep seeing developers confused [ng-forward](https://github.com/ngUpgraders/ng-forward):
Is it the same as ng-upgrade?
Is it a formal part of the migration path?
When should you use it?

This post will give you the background you need to wrap your head around ng-forward and whether or not you should be using it.

# What’s ng-forward

ng-forward is an open source project that aims to let you write Angular 1 code that looks very similar to Angular 2.
You don’t actually start to use ng2.
Instead, you’re getting familiar with the syntax and a lot of your code will look almost exactly like it would have looked in ng2.

ng-forward isn’t by the Angular core team per se.
It is created by the community, but with a blessing of the core team.

Here’s how a simple service would look like when written with ng-forward:

```javascript
import { Injectable, Inject } from 'ng-forward';

@Injectable()
@Inject('$q', '$timeout')
class TestService {
  constructor($q, $timeout) {
    this.$q = $q;
    this.$timeout = $timeout;
  }

  getValue() {
    return this.$q(resolve => {
      this.$timeout(() => resolve('Value'), 3000);
    });
  }
}
```

As you can see, it’s much alike Angular 2, but of course we’re still making use of Angular 1 services like `$q`.

# What’s the difference between it and ng-upgrade

ng-upgrade, which is an official part of the migration path and comes bundled with Angular 2 for now, is a mechanism to *run actual Angular 2 code alongside Angular 1*.

This means that while with ng-forward you’re writing services that look like Angular 2, with ng-upgrade you write *actual* Angular 2 services.

If you're interested in learning more about using ng-upgrade to move your existing code to Angular 2, and learning Angular 2 in general, subscribe to my newsletter and get more posts like these:

{% render_partial _posts/_partials/cta.markdown %}

# When should you use it

First of all, I’ll mention that ng-forward doesn’t support ES5 (yet), so you can only use it if you want to use ES6/TypeScript.

This is a big advantage of ng-upgrade: it works with ES5 (though documentation is still lacking) so you can start using it in ES5 project without making a lot of infrastructure changes.

Now, the decision of whether to use it or not boils down to personal preference.
They’ve done a marvelous job of making a lot of the syntax closely resemble ng2’s.

If you don’t expect to actually start learning and migrating to ng2 in the near months after its release, ng-forward is an interesting compromise.

You can start getting used to Angular 2 syntax, and won’t have to relearn a lot of things just yet.

Just as with ng-upgrade, there’s no need to rewrite all your code, you can decide to simply write new code with it or migrate specific services/components as it suits you.

Personally, I think that if you can take the hit of bundling Angular 1 and 2 together (which is a bump in download size), you should lean towards ng-upgrade.

Yes, it will take more time (since you’ll have to learn Angular 2), but whatever code you change/write won’t have to be *migrated again* later.

Also, I find the almost-exact-same-syntax a bit of a disadvantage.
Imagine a big project that’s written with ng-forward and that later starts an ng-upgrade migration.

It could easily become confusing to debug and make changes in a code base where neighboring files look very similar yet use a fundamentally different framework underneath.

That said, you should definitely consider using ng-forward if for some reason you won’t be adding ng-upgrade soon.

The sooner you start adjusting the easier it will be down the migration road (or path).

<hr>

Do you have a big *Angular 1.x app* that you're scared will *rot and become legacy code*? Because 2.0 and TypeScript will soon be *the new shiny* yet you have *all this JS code* sitting there? Where will your team find the time, and *management approval*, to learn and move things to 2.0?

But what if you could *migrate your project*, incrementally, while keeping your time's pace and shipping awesome code? What if your team could learn a bit more Angular 2 with each task? Imagine you could get to be *working in 2.0 land without ever stopping your development*!

I'm cooking up a self-served course that will get you there. It will allow you, *on your own pace*, learn Angular 2 and TypeScript bit by bit. With those steps your team will migrate your project and soon you'll write all your new code with Angular 2, TypeScript, and *won't have to stay behind*.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
