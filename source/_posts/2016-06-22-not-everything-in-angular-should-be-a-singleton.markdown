---
layout: post
title: "Not Everything in Angular Should Be a Singleton"
date: 2016-06-22 19:46:40 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 68384
---

When all you have is a hammer, everything looks like a nail.

Angular services/factories are singletons.
This has caused so many teams to forget about the joy of self contained objects that take care of themselves.

You don’t have to put all your code in static singletons and sling dummy json objects back and forth across your app.

You can enjoy real objects that make code easier to maintain!

# How your code probably looks

You have a service for handling some kind of model, e.g. a `Course` would have a `CoursesService`.
That service would be responsible for creating the courses and manipulating their data.

For example, you’ll use `CoursesService.create(name, students, schedule)`.
That will return some json object that you’ll then keep in your controller.

Whenever the controller would need some data about the course, it would have to use the service, passing it the object:

`CoursesService.getEndDate(course)`

Not only is this not very OOP-ish, it means that every binding you have in your template, e.g. to show the end date, would have `$ctrl.getEndDate(course)` which you’ll then implement in the controller just to proxy it to the `CoursesService`.

Also, having the course json object by itself isn’t usually enough, and to use it you’ll have to inject `CoursesService`.

*Bleh.*

# How your code could look

Instead, we can create a real `Course` model that encapsulates its own data and knows how to manage by itself.

We create a service like so:

```javascript
angular.module('app').factory('Course', function() {
  return Course;

  function Course(name, students, schedule) {
    this.name = name; // Etc.

    // Put the logic here!
    this.getEndDate = ...;
  }
});
```

And now, all of a sudden, our code has become nicer!

You create a course using `new Course(...)` and then just use this instance, instead of always holding on to an object and the service.

And, for example, your templates could now directly use `$ctrl.course.getEndDate()` instead of proxying it using the controller.

*Huzzah!*

<hr>

Do you have an existing Angular 1.x app that makes you worried about its future?  
You don't want your app to be *left behind* and become *legacy code*.  
But it's not easy clearing the time to learn Angular 2.  
And who has the energy to convince management that you need to change frameworks, delay your schedules and do the Big Ol' Rewrite?

But what if you could make sure your app keeps its options open?  
What if you could make it future-proof, all the while *shipping features like a boss*?  
You'll work in a codebase that uses the latest and greatest, have easy maintenance and happy stakeholders!

The *Future-proof Angular Guide* can help you get there.  
With this no-fluff course you'll learn how to quickly adapt your existing Angular 1.x app to the latest components paradigm, as you go about your regular work.  
You'll gradually turn your app into something that is modern and idiomatic, converting directives and getting rid of controllers.  
And then, once your app is shaped The Right Way™, you'll be able to keep shipping like a boss, and have your options open.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
