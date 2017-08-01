---
layout: post
title: "Angular 1.5 is close - here's the interesting parts"
date: 2015-12-10 16:41:04 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
---

The first release candidate of Angular 1.5 was just released.
This means the official release is probably right around the corner. 

It can be hard to keep up with the changes in Angular.
Things change pretty fast.
I know a lot of companies that haven’t even moved to 1.4 yet (or 1.3, or 1.2).
And everyone are trying to at least keep an ear open for the upcoming changes in 2.0.

And now there’s *another* version looming.
When will you ever find the time to learn what’s changed?

Well, fear not fellow Angularist!
I’ve gone over the [changelog](https://github.com/angular/angular.js/blob/master/CHANGELOG.md#150-rc0-oblong-panoptikum-2015-12-09) and gathered the interesting points below.
In five minutes you’ll know what’s all the new rage about.
Here are the interesting bits:

# .component method

This is a new addition to Angular modules, along `.controller`, `.directive`, etc.
The new `.component()` method is actually syntax sugar for creating a directive in the now-standard manner.
This makes it easy to create isolated directives, with controllers using controller-as syntax.

This is a great step in the right direction of setting a proper Angular style in my opinion.
But, it comes with a few interesting changes we’ll have to get used to.
I will be writing more in depth about this soon (subscribe below to get notified!).
In the mean time, there’s an excellent write up of all the options in [Todd Motto’s blog](http://toddmotto.com/exploring-the-angular-1-5-component-method/).

# Multiple transclusion

Finally.
This means we can, at last, create reusable components with several transclusion slots.

For example, we can create a modal dialog directive with set sections, such as header and body, and use it like so:

```javascript
<modal>
  <modal-title>My title</modal-title>
  <modal-body>The body goes here</modal-body>
</modal>
```

Prior we had to do all kinds of workarounds to get a similar solution.

While you may not be writing directives that use transclusion daily, it will make the libraries we all use much more powerful.

You can see the relevant commit [here](https://github.com/angular/angular.js/commit/a4ada8ba9c4358273575e16778e76446ad080054).

# Lazily compiling transclude functions

This change means that things like `ng-if` (which you’re using instead of `ng-show` [where appropriate](http://www.codelord.net/2015/07/28/angular-performance-ng-show-vs-ng-if/), right?) will now work faster.

It might come as a surprise, but if you were using lots of `ng-if`s that were never displayed on screen you still took a performance hit in page load time.

Luckily, 1.5 will improve this, making workarounds such as [lazy-ng-if](https://github.com/ravello/lazy-ng-if) no longer necessary.

# Not a lot of breaking changes

You should really go over the [changelog](https://github.com/angular/angular.js/blob/master/CHANGELOG.md#150-rc0-oblong-panoptikum-2015-12-09), but from what I see it seems like most projects will be able to easily upgrade.

The breaking changes are quite obscure and shouldn’t matter for most of us.

*Yay!*

So, it seems like 1.5 is going to be a nice release.
I’ll keep you posted if the next release candidates have any more interesting points.

{% render_partial _posts/_partials/book_cta.markdown %}
