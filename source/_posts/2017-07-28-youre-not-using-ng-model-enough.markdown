---
layout: post
title: "You're Not Using ng-model Enough"
date: 2017-07-28 14:14:49 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Get the modernization email course!"
cta_form: 244240
cta_paragraph: |
    <h2>"Maintaining AngularJS feels like Cobol 🤷‍♂️…"</h2>
    <p>
    You want to do AngularJS <em>the right way</em>.<br>
    Yet every blog post you see makes it look like your codebase is obsolete.
    Components? Lifecycle hooks? Controllers are dead?
    </p>

    <p>
    It would be great to work on a modern codebase again, but who has weeks for a rewrite?<br>
    Well, you can get your app back in shape, without pushing back all your deadlines!
    Imagine, upgrading smoothly along your regular tasks, no longer deep in legacy.
    </p>

    <p>
    Subscribe and get my free email course with steps for upgrading your AngularJS app
    to the latest 1.6 safely and without a rewrite.
    </p>
---

You sit down and start your next frontend task.
Likely, that task will require you to get input from the user.
Maybe you’re adding a comments section, maybe it’s a little survey, or some simple form.

Handling inputs and forms with AngularJS can be a breeze, especially since AngularJS provides a lot of tools for efficiently doing just that.
You need to add validations, like making sure the user filled all the fields, and it’s just a matter of adding a `required` attribute to all controls and checking the form’s `$valid` property.

I love it when instead of writing lots of code I simply do something along the lines of:

```html
<button ng-disabled="!$ctrl.form.$valid" type="submit">Save</button>
```

(I’m not missing an `ng-click` there BTW, for submitting a form you should usually have `ng-submit` on the `<form>` element.)

But, what happens when you have use some custom control, instead of the browser’s builtins (e.g. `input`s, `textarea`s, `select`s)?

It usually looks ends up looking like this:

```html
<my-custom-control value="$ctrl.someValue"></my-custom-control>
```

And suddenly, you can’t just use `required`, and the form’s `$valid` doesn’t work, and instead of using `$ctrl.form.$valid` to check everything is filled you have to write code along the lines of:

```javascript
function isValid() {
  return self.form.$valid && self.someValue !== '';
}
```

## Custom Controls Don’t Have to Suck

You don’t have to leave the comforts of Angular’s forms just because you have a custom control.
You just need to make sure to wire things up properly.

It’s as easy as using `ng-model` to pass the value to the control, instead of some binding of yours.
Here’s an example of refactoring a component to use ngModel:

```javascript
angular.module('app').component('myCustomControl', {
  template: '...',
  bindings: {
    value: '=ngModel'
  }
});
```

You can still use the same name the component used before, such as `value` above, but make sure that the external name is `ngModel`.
Using that component looks like so:

```javascript
<my-custom-control ng-model="$ctrl.someValue" required>
```

Just by using the `ng-model` attribute, Angular’s `ngModel` directive will be used, and sprinkle its own magic.
That means that it’ll register with the parent form, and add the needed validations.

For example, the `required` above will simply work now, and so will our original button, no need for custom code.

So _please_ don’t write custom controls like an animal.
Use Angular properly.

{% render_partial _posts/_partials/cta.markdown %}
