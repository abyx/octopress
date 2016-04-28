---
layout: post
title: "Angular Performance: Updating bind-once elements"
date: 2016-04-21 23:37:30 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 45056
---

Performance can be [tricky](http://www.codelord.net/2015/08/03/angular-performance-diagnosis-101/) with Angular.
It’s quite easy to have a page that’s slow or unresponsive because you got [too many watchers](http://www.codelord.net/2015/08/14/angular-watches-watches-everywhere/) going on.

Angular 1.3 shipped with the new [bind-once syntax](https://toddmotto.com/angular-one-time-binding-syntax/), but I hardly see people use it.
Even if you add it, you hardly never want things to *never change again*.

Usually, you have a bunch of stuff that change together.
Plainly using bind-once would remove all the watches and make your page responsive and your digest cycles fast.
But, how would you go about updating it?

It’s a bit tricky, but doable.
In this post we’ll show an example of performing such an optimization.

# Our use case: search results

Let’s say you have a page in your app that let’s you search something.
You get from the server a response with 100 items that you them display:

```html
<div ng-repeat="item in $ctrl.results">
  <div>{% raw %}{{ item.name }}{% endraw %} - {% raw %}{{ item.description }}{% endraw %}</div>
</div>
```

If we display 100 results at once we already have 200 watches: 2 bindings (`name` and `description`) per item displayed.

This can easily get out of hand.

But look at your results.
They’re not going to change individually.
The will only change as a whole, when, for example, the user goes to the next page or types a different search query.

Let’s get rid of them watches!

# Binding once

You might first start with something trivial like this:

```html
<div ng-repeat="item in $ctrl.results">
  <div>{% raw %}{{ ::item.name }}{% endraw %} - {% raw %}{{ ::item.description }}{% endraw %}</div>
</div>
```

This simple change (adding `::` in two places) rids us of those 200 watches.
Yay!

But, what would happen if you now update the description of items inside `$ctrl.results`, e.g. because the user marked them as read?

*Nothing.*

It’s a bit crappy that there’s no easy way to tell Angular to refresh these bind-once expressions.

But don’t give up yet.

Note: In this example, if you add/remove elements from `$ctrl.results` they will be added/removed to the `ng-repeat`.
If you never change the inline elements you wouldn't need anything more than this.
This is a simple example, but pages with performance problems usually aren't simple :)

# Forcing an update of bound-once content

This requires a bit of coding.
Basically, we want to tell Angular to throw away those frozen elements and recompile stuff to use our new content.

Our end result would look like this:

```html
<refresher condition="$ctrl.lastUpdate">
  <div ng-repeat="item in $ctrl.results">
    <div>{% raw %}{{ ::item.name }}{% endraw %} - {% raw %}{{ ::item.description }}{% endraw %}</div>
  </div>
</refresher>
```

We wrap our content with a specially crafted directive, `refresher`.
This directive listens for a given property.
Once that property changes its value, `refresher` recompiles the content inside it.

This means that we effectively have a *single watch* active, and once that watch’s value changes everything updates.

In our case, we can have `lastUpdate` be whatever you want as long as it is updated when your content changes.
I usually just use a timestamp that I update whenever the content changes.

Here’s how `refresher` looks:

```javascript
app.directive('refresher', function() {
  return {
    transclude: true,
    controller: function($scope, $transclude,
                         $attrs, $element) {
      var childScope;

      $scope.$watch($attrs.condition, function(value) {
        $element.empty();
        if (childScope) {
          childScope.$destroy();
          childScope = null;
        }

        $transclude(function(clone, newScope) {
          childScope = newScope;
          $element.append(clone);
        });
      });
    }
  };
});
```

There’s not a lot of code going on around here.

`refresher` is a basic directive (why not a component? because components have to have isolated scopes, which I don’t want in this case).

This directive basically watches for changes in the value of whatever you pass to its `condition` attribute.

Whenever that value changes, `refresher` throws out whatever it previously contained and recompiles things, so they’ll appear on screen updated.

This is a basic example of using the `$transclude` service manually.

That’s it!

<hr>

Do you have a big *Angular 1.x app* that you're scared will *rot and become legacy code*? Because 2.0 and TypeScript will soon be *the new shiny* yet you have *all this JS code* sitting there? Where will your team find the time, and *management approval*, to learn and move things to 2.0?

But what if you could *migrate your project*, incrementally, while keeping your time's pace and shipping awesome code? What if your team could learn a bit more Angular 2 with each task? Imagine you could get to be *working in 2.0 land without ever stopping your development*!

I'm cooking up a self-served course that will get you there. It will allow you, *on your own pace*, learn Angular 2 and TypeScript bit by bit. With those steps your team will migrate your project and soon you'll write all your new code with Angular 2, TypeScript, and *won't have to stay behind*.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
