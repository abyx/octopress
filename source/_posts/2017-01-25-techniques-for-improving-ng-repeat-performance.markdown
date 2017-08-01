---
layout: post
title: "Techniques for Improving ng-repeat Performance"
date: 2017-01-25 18:03:47 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 158242
---

`ng-repeat` is notorious for often being the biggest performance bottleneck in Angular apps.
It is common practice, when performance tuning lists, to use [`track by`](http://www.codelord.net/2014/04/15/improving-ng-repeat-performance-with-track-by/) or [one-time bindings](http://www.codelord.net/2016/05/19/understanding-angulars-one-way-binding/).
Surprisingly, trying to combine both of these practices usually has unexpected results.
In this post, we’ll go over the different scenarios `ng-repeat` is usually used for, and the possible improvements for speeding it up `ng-repeat`.

Note that before diving into any optimizations, I highly suggest [measuring and tracking down](http://www.codelord.net/2015/08/03/angular-performance-diagnosis-101/) the problematic parts of your app.

# Refreshing the whole list

## Scenario
The list you’re rendering with `ng-repeat` isn’t edited/changed on a per-line basis, but simply reloaded, e.g. with a “Refresh” button that fetches the model again from the server and replaces the currently displayed list.

The act of re-rendering the whole list feels laggy.
Usually this means there’s some jank, or the browser seems to freeze for a bit before actually rendering.

## Improvement: track by
Use `track by` as detailed [here](http://www.codelord.net/2014/04/15/improving-ng-repeat-performance-with-track-by/).
In the above scenario, when the list is changed Angular will destroy all DOM elements in the `ng-repeat` and create new ones, even if most of the list elements remained identical to their previous versions.
This, especially when the list is big, is an expensive operation, which causes the lag.

`track by` lets Angular know how it is allowed to reuse DOM elements in `ng-repeat` even if the actual object instances have been changed.
Saving DOM operations can significantly reduce lag.

# A completely static list

## Scenario
Your component displays a list of items that’s never changed as long as the component is alive.
It might get changed when the user goes back and forth between routes, but once the data has been rendered and until the user moves on to a different place in your app, the data remains the same.

This is common in analytics apps that display results of queries and don’t actually manipulate the data afterwards.

While the list is on the screen the app might feel sluggish when interacting with it, e.g. clicking on buttons, opening dropdown, etc.
This is usually caused by the `ng-repeat` elements introducing a lot of watchers to the app, which Angular then has to keep track of in every digest cycle.

I’ve seen my fare share of apps with simple-looking tables that made an app grind to a halt because under the hood they had thousands of watchers, heavy use of filters, etc.

## Improvement: one-time bindings
Just for the case where the data should be rendered for a single time we were given the one-time binding syntax.

See the full explanation [here](http://www.codelord.net/2016/05/19/understanding-angulars-one-way-binding/), but basically by sprinkling some `::` inside the `ng-repeat` elements’ bindings, a static list can have the number of watchers reduces to even nothing.

This means that once the rendering has finished the table has no performance impact on the page itself.

# Editable content

## Scenario
Your app displays a list or a table that can be changed by the user.
Maybe some fields can be edited.
Or perhaps there’s a table cell with a dynamic widget.

The list is big enough to have the same performance problems discussed in the previous part, but, since it needs to pick up on changes in the data, simply using one-time bindings breaks its usability.
The list stops displaying changes, since all our watches are gone.

## Improvement: immutable objects and one-time bindings
When you mutate one of the objects inside a list, Angular doesn’t recreate the DOM element for it.
And since the DOM doesn’t get recreated, any one-time bindings will never be updated.

This is a great opportunity to start moving into the more modern one-way data flow and use immutable objects.

Instead of mutating the objects, e.g.:

```javascript
function markTodoAsDone(todo) {
  todo.done = true;
}
```

… treat your models as immutable.
When a change is needed, create a clone of the data and replace the model object inside the list:

```javascript
function markTodoAsDone(todo) {
  var newTodo = angular.copy(todo);
  newTodo.done = true;
  todosListModel.replace(todo, newTodo);
}
```

Why does this work?
Consider this template:

```html
<div ng-repeat="todo in $ctrl.todosListModel.get()">
  <div ng-bind="::todo.title"></div>
  <div ng-if="::todo.done">Done!</div>
  <button ng-click="$ctrl.markTodoAsDone(todo)">Done</button>
</div>
```

Since all the bindings inside the `ng-repeat` template are one-time bindings, the only watcher here is the `$watchCollection` used by `ng-repeat` to keep track of `$ctrl.todosListModel.get()`.

Had we simply mutated the todo object, the `$watchCollection` would not get triggered and nothing would get rendered.
But since we’re putting a new object inside the list, `$watchCollection` will trigger a removal of the old todo, and an addition for the new one.
The addition will create a new DOM element for our todo, and so it will get rendered according to its latest state.

# Summary

`ng-repeat` can be tamed, at least partially, if you take care to use it according to your specific use case.

I hope this helps you speed your app a bit!

{% render_partial _posts/_partials/book_cta.markdown %}
