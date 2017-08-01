---
layout: post
title: "AngularJS Form Properties Guide"
date: 2017-07-02 10:10:14 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 232724
---

Essentially every single web application being developed out there gets inputs from its users.
Maybe it’s got a comment feed with a few text boxes.
Or maybe it has some sort of calculator with different inputs and sliders.
Of course, there’s almost always the **login** page.
Yes, the email and password are inputs as well.

When working on web apps you’re going to be handling inputs quite a bit, and if so, you should be well equipped to use the right tools for the job.
With AngularJS, those tools should include the extensive support for forms, inputs and validations.

I’ve covered the basics of writing forms [before](http://www.codelord.net/2015/11/06/angular-forms-and-validation-step-by-step-example/), but in this article I’d like to point out how Angular’s forms have a few magic properties that are worth knowing, since they can spare you some bugs and code!

# First Things First: Getting Access to the Form

Forms in AngularJS have special properties, but how exactly are you meant to get access to these forms?
The trick is to name the form.
Once provide a name for your forms, AngularJS will automatically expose it under that name in your scope.

For example, say that we have this as part of the template of a component with `$ctrl` as its controller-as name:

```html
<form name="$ctrl.exampleForm">
  <!-- inputs etc. go here.. -->
</form>
```

Setting the name to `$ctrl.exampleForm` means that in the template we can get access to the form, simply by using `$ctrl.exampleForm`.
It can also be accessed from the controller’s code, using `this.exampleForm`.

Now that we know how to get access to the form, let’s start making use of it!

## Testing Whether the User Has Interacted With the Form

A very common use case is the need to display certain error messages or help tips only after the user has started changing values in the form (or hasn’t started yet).

To do just that, forms in AngularJS come supplied with two handy boolean properties, `$pristine` and `$dirty`.
These two booleans are always the negative of the other (i.e. `$pristine === !$dirty`).

When the form is in its virgin state and the user hasn’t changed anything yet, `$pristine` is set to `true`.
Once the user has interacted with the form’s inputs, `$pristine` is set to `false` and `$dirty` is true.

In case you need to programmatically force the form back to its pristine state (e.g. the user clicked on reset, or after a successful save), you can call `$ctrl.exampleForm.$setPristine()`.

## Display Things After Form Submission

Sometimes, we want form validations to only be displayed after the user has clicked the save button, instead of changing as the user types or moves between fields.

In those cases, simply hiding validations until the form becomes `$dirty` won’t do, which is exactly why forms also have the handy `$submitted` property.
This property gets set to `true` once the user has submitted the form, even if the form is invalid.

Submitting a form means clicking a button that has the attribute `type="submit"`, or pressing Enter/Return inside an input.

AngularJS won’t prevent the form from being submitted if it’s invalid, meaning your `ng-submit` callback is called.
You need to make sure not to act in case the form isn’t in a valid state.

## Checking if the Form Is Valid

And just in order to check whether the form is valid or not, forms come equipped with a few more swanky properties.

First of all are the `$valid` and `$invalid` couple.
If `$valid` is `true` - go right ahead.
If `$invalid` is `true` - something is amiss.

In case the form is invalid, the form’s `$error` hash will contain all the necessary information about which fields are invalid and for what validations.

**But**, there’s another state here, which is when both are `undefined`.
This is possible when the form has [asynchronous validators](http://www.codelord.net/2014/11/02/angularjs-1-dot-3-taste-async-validators/).
This means that it’s important to test these are `true` or `false` and not just “falsy” (e.g. `undefined` or `null`).

You can also check whether the form is currently pending, and see which of the validators are being processed, by accessing the `$pending` hash (which is structured similarly to `$error`).

There’s lots more that can be written about forms and their inputs in AngularJS, so if you’d like to hear more please subscribe below!

{% render_partial _posts/_partials/book_cta.markdown %}
