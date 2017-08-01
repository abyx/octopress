---
layout: post
title: "Stop ng-repeating options: use ng-options"
date: 2016-08-12 11:08:36 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 86729
---

A pet peeve of mine is seeing Angular code with `<select>` tags that uses `ng-repeat` to generate the options, like so:

```html
<select ng-model="$ctrl.mode">
  <option ng-repeat="option in $ctrl.options"
    ng-value="option" ng-bind="option.name">
  </option>
</select>
```

One of the great little details about Angular is the awesome `ng-options` directive, which I find more concise and is very powerful.

First, here is the basic translation of the above:

```html
<select ng-model="$ctrl.mode"
  ng-options="o.name for o in $ctrl.options">
</select>
```

The trick here is that `ng-options` is completely in charge of creating the actual `<option>` elements for us.

Now, let’s see where it shines.

## Nullability of a select

When using `ng-options`, once you initialize the `ng-model` value to one of the options there’s no way for the user to reset it to an empty value by default.

To allow setting it to null, we simply add a special empty `<option>` tag.
Here’s how the above example would look with nullability:

```html
<select ng-model="$ctrl.mode"
  ng-options="o.name for o in $ctrl.options">
  <option value=""></option>
</select>
```

## Using an object as a value

Another thing is that a lot of developers miss the fact that Angular lets us use selects with values that aren’t simple strings, but actual *objects*.

In the first example I showed how you do it manually, using `ng-value`, instead of the `value` property.
This tells Angular to bind to our model the actual object that the expression evaluates to.

`ng-options` of course does that automatically for us, but we can customize the bound value even more if needed, for example:

```html
<select ng-model="$ctrl.mode"
  ng-options="o.value as o.name for o in $ctrl.options">
  <option value=""></option>
</select>
```

## Disabling elements

Another reason that I usually prefer using native HTML elements and not wrappers (e.g. Select2) is because they usually pack *so much* under the hood.

For example, you can easily have a few options be disabled dynamically:

```html
<select ng-model="$ctrl.mode"
  ng-options="o.name disable when $ctrl.disabled(o)
              for o in $ctrl.options">
  <option value=""></option>
</select>
```

The `disable when` clause lets you specify an expression that decides which options will be displayed but won’t be enabled for actual selection.

So, please, don’t roll your own `<option>` elements unless you have a good reason!

{% render_partial _posts/_partials/book_cta.markdown %}
