---
layout: post
title: "Advanced Angular 1.x: Component Communication with Require"
date: 2016-11-30 22:44:21 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 132734
---

Angular 1.5’s components have made scope isolation the default, and rightly so.
But, it does mean that inter-component communication requires more thought to get right.

Angular’s `require` mechanism provides a good way to allow some forms of components communication, especially across a suite of related components.

What does `require` let you do?  
When should you use it?  
Why it’s not the right tool for everything?  
Keep reading!

# How require works?

The require mechanism is an old one, and has been in use quite a lot for advanced Angular directive communication.

Prior to components, you’d use `require` in order to allow a directive access to a different directive’s controller.
That allows directives to expose APIs between one another.

A directive can require the existence of another specific directive, either on its own element or on one of its parent elements.

An example of a same-element kind of communication require is used for, is adding your own validation directive to an `input` element, and accessing that input’s `ngModelController` in order to modify the validators.

Accessing parent controllers is more useful for suites of interacting components, such as the way Angular’s form validation works.
Every input element in the form can notify the form that it has become valid, invalid, dirty, etc. by optionally requiring a parent `ngForm` controller and updating it of changes.

As you can see, require is a very powerful mechanism and an inherent part of Angular, that you can use to make your own components cleaner.

# When should or shouldn’t you use require?

First and foremost, require doesn’t work in all scenarios.
It can only be used by a component/directive to get access to a parent controller (or a controller on the same element).
Sibling components can’t communicate using it, and neither can a parent component access its children using it (at least not directly, keep reading for an interesting option).

Another limitation of require is that it assumes the child component knows the name of the other component that it want to require.
There’s no abstraction/indirection here - the name of the required component is hard-coded in the requiring component.

Also, I wouldn’t rush to use require to replace any kind of simple binding.
It’s totally fine to pass some values between components using bindings–it can be more explicit and simpler to maintain.
After all, it’s usually easier to understand what a component depends on if all you need to do is look at its bindings.

Require shines when it allows you setup a family of interacting components, and exposing a rich interface between them without having to wire up half a dozen bindings across multiple layers of components.

# Real require example deep-dive: Angular’s forms

As already mentioned, Angular’s whole form and validations mechanism makes heavy use of require.

When you create a `<form>` in Angular, every element inside it that uses `ng-model`, such as `<input>`s, `<select>`s, etc. registers itself as a control inside that form.

You can see [here](https://github.com/angular/angular.js/blob/789790feee4d6c5b1f5d5b18ecb0ccf6edd36fb3/src/ng/directive/ngModel.js#L1101) in the source of `ngModel` how it optionally requires the `form` directive.
In case a parent form directive exists, `ngModelController` uses the form directive’s controller and registers as a control.
See [here](https://github.com/angular/angular.js/blob/789790feee4d6c5b1f5d5b18ecb0ccf6edd36fb3/src/ng/directive/ngModel.js#L1124).

The form directive, in turn, keeps a list of all these controls and updates them on changes such as `$setPristine` and `$setUntouched`.

Notice that while there’s no direct way to access a child component from a parent component, the Angular core team did it here by using `require` from the child and registering it in the parent, exposing the child controllers to the parent.

Angular’s forms, in turn, have the ability to be nested inside other forms.
This happens by [optionally requiring a parent form](https://github.com/angular/angular.js/blob/789790feee4d6c5b1f5d5b18ecb0ccf6edd36fb3/src/ng/directive/form.js#L480) controller.
If `require` does find another parent form directive, the nested form registers in it to let the parent form know it has nested forms.

This is an excellent example of setting up a component architecture, where our components know about one another and use that knowledge to their advantage.

# Real talk: How do you use require in your components

Let’s say that we’ve got this structure in our application:

```html
<parent>
  <child></child>
</parent>
```

And we want to allow the `child` component to access `parent` component’s controller.

We’ll add a `require` block in `child`’s component definition, and then be able to access the controller inside the controller, like so:

```javascript
app.component('child', {
  require: {
    parentCtrl: '^^parent'
  },
  controller: function() {
    var self = this;
    this.$onInit = function() {
      self.parentCtrl.someControllerFunc();
    };
  }
});
```

What do we have here?
The `require` object allows us to pass as many required component as we’d like.
`parentCtrl` is the name the required controller will be bound as in our component’s controller.
`^^parent` might seem live a bit of voodoo, but basically we’re saying that we require a parent component called `parent` to exist.

The `^^` prefix means the component has to be a parent.
There’s also the `^`, which means we can use a component that’s either a parent or on the current element.
And if you simply provide the name, e.g. `fooCtrl: 'foo'` it means you expect the `foo` directive to exist on the current element–it will not be searched for anywhere else.

When we’re talking about components, and not directives, you almost always want `^^`, though you can use just `^` if you don’t *really* want to make sure you’re not accidentally requiring the current element.

After we require a component, we can access it from our controller with the name we provided, e.g. `this.parentCtrl`.
I prefer to make sure the name still uses the original component’s name, to be explicit and make maintenance easier.

If the require string is written like we saw above, it means the component is strictly required.
Angular will error out if it can’t find the component we asked for.
In cases where a component can operate without that required component, you can set the requirement as optional:

```javascript
require: {
  parentCtrl: '?^^parent'
}
```

The question mark means that in case Angular can’t find a parent component with that name it will silently ignore it.
If you’ll try to access `this.parentCtrl` you’ll see it’s just nulled.

# With great require comes great responsibility

Require is an advanced Angular technique that can really boost certain parts of your app.
It’s great for exactly those few highly-interactive components you need to write.

But, `require` surely shouldn’t be your default or go-to solution for all communication.
Start by using regular [one-way](http://www.codelord.net/2016/05/19/understanding-angulars-one-way-binding/) (`<`) and [expression](http://www.codelord.net/2016/05/13/understanding-angulars-and-binding/) (`&`) bindings, and reach for `require` when it’s required (pun slightly intended).

{% render_partial _posts/_partials/book_cta.markdown %}
