---
layout: post
title: "Fixing Angular Template Overuse"
date: 2017-06-11 17:33:03 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Subscribe to get the latest about modern Angular 1.x"
cta_form: 223947
---

Templates in AngularJS quite powerful, but just because something can be done in the template doesn’t mean you _should_ do it there.
The separation between controller and template can be vague in Angular, which is why I have a couple of guidelines which I consider to be best practices in any Angular project.

One of those rules of thumb is: *Don’t do in the template what can be done elsewhere.*

In this post, I will go over the different symptoms of template overuse and why it can be problematic.

# Template Overuse Symptoms

_Template Overuse_ (noun): Performing work in the template that will be better placed somewhere else.

## `ng-click`

A popular example is `ng-click` abuse:

```html
<button ng-click="$ctrl.validate() && $ctrl.submit()">
  Submit
<button>
```

As you can see, the `ng-click` handler is first making sure that the form is valid before actually calling the submit operation.

This extra logic is misplaced.

A similar, yet different, example is:

```html
<button ng-click="$ctrl.counter = 0">Reset</button>
```

As a guideline, _template event handlers should trigger functions on the controller_, and not any other expression/statement (e.g. the above would be `ng-click="$ctrl.reset()"`).

This goes the same for similar directives, such as `ng-submit`, etc.

## `ng-init`

This, for some reason beyond me, is not an uncommon sight:

```html
<div ng-init="$ctrl.setup()">
```

In case you’re not aware of it, `ng-init` simply runs the code given to it when the template initializes.
Its valid use cases are so rare, even the [documentation](https://docs.angularjs.org/api/ng/directive/ngInit) warns against using it.

And yet, a [GitHub search](https://github.com/search?l=HTML&p=1&q=ng-init%3D&type=Code&utf8=%E2%9C%93) comes up with 785K+ hits at the time of this writing.

There’s a good place to initialize stuff: the controller’s [`$onInit` hook](http://www.codelord.net/2015/12/17/angulars-component-what-is-it-good-for/)!

## Underusing CSS

All the power we get from templates might make it easy to forget that not all visual logic has to be done inside them.
A good example is using `ng-if` or `ng-class` for targeting special cases that can be handled in CSS, like special casing the first element in a list, or coloring every other row, like I’ve shown [here](http://www.codelord.net/2017/06/04/the-magic-properties-of-angulars-ng-repeat/).

## Forgetting the Basics

I see too many developers reinventing the wheel instead of making use of the power of the web.

Consider the first example here, which showed `ng-click="$ctrl.validate() && $ctrl.submit()"`.
There’s a known mechanism for preventing actions on buttons in case the form state is invalid, which is setting those buttons to be `disabled`.
This can be done by using Angular’s [validators](http://www.codelord.net/2015/11/06/angular-forms-and-validation-step-by-step-example/), or even simply by using `ng-disabled`:

```html
<button ng-disabled="!$ctrl.validate()" ng-click="$ctrl.submit()">
  Submit
</button>
```

# Why is Overuse Bad?

First, having extra logic in the template makes it harder to refactor code at a later point.
I’ve yet to come across the perfect IDE that makes refactoring templates as smooth as refactoring JavaScript code.
If that’s the case, I opt for the style that makes refactoring easier.

Further, it’s very easy for templates to contain a bunch of dense expressions and overly long `ng-if` conditions.
These in turn make code maintenance a PITA.
Templates should be easy to change when view requirements change, and are best when they make it easy to understand and visualize what is happening on screen.
The more code in your templates, the harder they become to follow.

Also, logic in template also makes it harder to properly unit test controllers.
For example, if the template contains an `ng-init` hook, then usually the test would also have to invoke whatever expression the `ng-init` is calling.

Essentially, all these reasons boil down to complicated templates making code maintenance harder in the long term.
Making a point of keeping templates succinct will make for a codebase that everyone will be happier working on.

# Fixing Overuse

To repeat, the basic guidelines you should strive to follow are:

1. _Don’t do in the template what can be done elsewere_.
2. _Template event handlers should trigger functions_.
2. _Remember the basics_, like CSS and HTML form validation.
3. _Don’t use `ng-init`_. Just don’t.

<hr>

You want to do Angular *the right way*.  
You hate spending time working on a project, only to find it's completely wrong a month later.  
But, as you try to get things right, you end up staring at the blinking cursor in your IDE, not sure what to type.  
Every line of code you write means making decisions, and it's paralyzing.  

You look at blog posts, tutorials, videos, but each is a bit different.  
Now you need to *reverse engineer every advice* to see what version of Angular it was written for, how updated it is, and whether it fits the current way of doing things.

What if you knew the *Angular Way* of doing things?  
Imagine knocking down your tasks and spending your brain cycles on your product's core.  
Wouldn't it be nice to know Angular like a second language?

You can write modern, clean and future-ready Angular right now.  
Sign up below and get more of these helpful posts, free!  
Always up to date and I've already done all the research for you.

And be the first the hear about my Modern Angular 1.x book - writing future proof Angular right now.

{% render_partial _posts/_partials/cta.markdown %}
