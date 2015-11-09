---
layout: post
title: "Angular Forms and Validation: Step By Step Example"
date: 2015-11-06 15:55:24 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Get more guides of maintainble Angular and learn how to prepare for 2.0!"
---

We all have to get input from users, validate it and act on it. But everywhere I look I see developers that aren’t using Angular’s form capabilities to their full potential.

Yes, it requires learning the right buttons to push. Let’s spend a few minutes getting to know Angular forms. You’ll be surprised how easy it is to implement most of your forms’ UX.

In this post we’ll go through the steps of setting up a sign up form. We will implement a custom password validator and an asynchronous check that the supplied email address hasn’t been used yet.

# The raw form

```html
<form name=vm.form novalidate ng-submit=vm.signUp()>
  <label>
    Email:
    <input type=email name=email
           ng-model=vm.email required>
  </label>
  <label>
    Password:
    <input type=password name=password
           ng-model=vm.password required>
  </label>
  <button type=submit>Sign Up!</button>
</form>
```

This should look familiar. We have a simple form with 2 fields and a nice button. Some things to note:

- We’re adding a `name` attribute to the form and inputs so they’ll be bound to our controller. We will use this shortly below.
- Specifying `required` and `type=email` already gives us basic validation by Angular. But since some browsers have validation too we use the `novalidate` attribute so it won’t clash with Angular’s stuff.
- Use `ng-submit`. You should always either pick `ng-submit` or have `ng-click` on the submit button, never both. I prefer `ng-submit` since I consider this action to be at the form’s level.

# Prevent submitting an invalid form

This one’s an easy peasy. Just use `ng-disabled` to prevent our form from getting submitted when the state of the form is invalid:

```html
<button type=submit ng-disabled=!vm.form.$valid>
  Sign Up!
</button>
```

**Angular Weirdness Alert**: It’s important to use `!vm.form.$valid` and not `vm.form.$invalid` here. An Angular form can be in a third state, pending, which we’ll talk about soon. This means that `$valid != !$invalid`. *Le sigh*. We don’t want to allow the form to submit in any state other than the valid state.

Playing with the form would now prevent us from submitting it if we don’t supply a value in both inputs.

# Add password validation

Now we’re getting serious. Let’s add some basic validation: passwords should have at least 8 characters and contain both letters and numbers. We’ll use the awesome validators introduced in 1.3+. We’ll use a little directive that we’ll then attach to the password element:

```javascript
app.directive('password', function($timeout) {
    return {
      require: 'ngModel',
      controller: function($element) {
        var ctrl = $element.controller('ngModel');

        ctrl.$validators.password = 
          function(modelValue, viewValue) {
            return viewValue && viewValue.length >= 8
              && /[0-9]/.test(viewValue)
              && /[a-z]/i.test(viewValue);
        };
      }
    };
});
```

And add that directive to the element:

```html
<input type=password name=password
       ng-model=vm.password
       required password>
```

We’re placing our directive on the same input element with an `ng-model` and so we can gain access to `ngModelController` and add our validator. As you can see, validators are pretty straightforward.

Just add a function that gets called with the view value — the input’s value — and returns whether that value is valid or not. 

You can now see the button remains disabled until you enter a valid password.

# Add email validation with a loading indicator

We’d like to make sure the supplied email address hasn’t been registered with our site yet as part of the validation.

Starting from version 1.3, Angular has support for asynchronous validators. That means we can easily supply a promise and Angular knows to wait for the promise to either be resolved or rejected to tell whether the field is valid. Sounds like exactly the case where you want to query your server and make sure the field is valid.

Here’s our email validator directive:

```javascript
app.directive('availableEmail', function(UserService) {
    return {
      require: 'ngModel',
      controller: function($element) {
        var ctrl = $element.controller('ngModel');

        ctrl.$asyncValidators.availableEmail =
          function(modelValue, viewValue) {
            return UserService.isValid(viewValue);
        };
      }
    };
});
```

This is pretty similar to the password validator. We’re using `$asyncValidators` instead of `$validtors` and our function now returns a promise.

While the validation is happening we’d like to show the user that something’s going on. Here’s a very basic change to our template:

```html
<div ng-if=vm.form.email.$pending.availableEmail>
  Checking email availability...
</div>
```

As you can see, while an asynchronous validation is going on, Angular sets the `$pending.availableEmail` property on the form’s email attribute (the name `email` is coming from `name=email` on the `input`). Voila!

# Adding error messages

Right now our form has all of its functionality implemented. It won’t allow submitting an invalid form.

But, of course we’d like to show the user what he’s done wrong, instead of leaving him to guess.

That’s why Angular introduced the `ng-messages` directive. Let’s see how we can add error messages to our email field:

```html
<div ng-messages=vm.form.email.$error
     ng-if=vm.form.email.$touched>
  <div ng-message=required>
    Please specify an email address
  </div>
  <div ng-message=email>
    Please specifiy a valid email address
  </div>
  <div ng-message=availableEmail>
    Email address is already taken
  </div>
</div>
```

As you can see, `ng-messages` is a lot like `ng-switch` and lets us display an appropriate error message depending on the validator that’s failed.

Also note the `ng-if=vm.form.email.$touched` bit. We wouldn’t want the form to show these errors right when it first loads. But, when it’s empty it is already invalid.

Angular keeps track of whether the user has interacted with an input, i.e. focused it and then clicked outside of it. That’s what the `$touched` means. Awesomely simple!

Check out a live example of the resulting form [here](http://abyx.github.io/angular-form-validation-example), and the source [here](https://github.com/abyx/angular-form-validation-example). In it you can see a bonus: how to use Angular’s forms to style the error messages and the form in invalid states.

{% render_partial _posts/_partials/cta.markdown %}
