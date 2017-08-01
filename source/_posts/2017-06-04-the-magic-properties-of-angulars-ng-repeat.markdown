---
layout: post
title: "The Magic Properties of Angular's ng-repeat"
date: 2017-06-04 09:53:14 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 220700
---

One of the basic building blocks of Angular is, of course, the `ng-repeat` directive.
It’s certainly one of the things newcomers pick up right when starting to learn Angular.
Yet, it’s very easy to just learn the basics and miss out on some of its lesser known but useful features.

In this post you will learn what automatic properties `ng-repeat` creates on the scope object, to make common tasks easier.

# `$index`

The scope property is most probably the most popular one.
When using `ng-repeat`, every block of repeated content has access to a property called `$index`.
This property is a number, and contains the current index of the “loop” `ng-repeat` is doing:

```html
<div class="task" ng-repeat="task in $ctrl.tasks">
  <span ng-bind="$index"></span>: <span ng-bind="task.name"></span>
</div>
```

As you can probably guess, this will display next to each task’s name its index in the `$ctrl.tasks` array.

Yet while it is most known, it is probably the one that should be used the least.

# `$first` and `$last`

It’s common when using `ng-repeat` to add specific behavior to the first or last element of the loop, e.g. special styling around the edges.

I’ve seen too many programmers do it awkwardly using `$index`:

```html
<div ng-if="$index == $ctrl.tasks.length - 1">Last</div>
```

Instead, `ng-repeat` already supplies you with two ready boolean properties.
`$first` is `true` for the first element, and `$last` is `true` for the last element.

While we’re at it, I’ll mention that if all you’re doing here is styling, e.g. `ng-class` according to the first/last index, you might be better off doing this purely in CSS using the [`:first-child`](https://developer.mozilla.org/en/docs/Web/CSS/:first-child) and [`:last-child`](https://developer.mozilla.org/en/docs/Web/CSS/:last-child) pseudo-classes.

# `$middle`

This simple property is simply used to tell whether the current element is neither the first element in the loop, nor the first.

It’s equivalent to `!$first && !$last` (to please the logic nerds, this is also `!($first || $last)`, according to [De Morgan’s Laws](https://en.wikipedia.org/wiki/De_Morgan%27s_laws)).

# `$odd` and `$even`

These properties simply state whether the current `$index` is odd or even.
It’s very common to style grid with alternating colors between rows for easier readability, and if you’re using `ng-class` to add an `.even` class, you’d better use `$even` instead of `$index % 2 == 0`.

Yet, again, I’ll say that in case you’re using this solely for styling, doing this in [CSS](https://developer.mozilla.org/en/docs/Web/CSS/:nth-child) would probably be the better choice, e.g. `:nth-child(odd)` and `:nth-child(even)`.

You can read more about these properties and `ng-repeat`’s other features in [the documentation](https://docs.angularjs.org/api/ng/directive/ngRepeat).

{% render_partial _posts/_partials/book_cta.markdown %}
