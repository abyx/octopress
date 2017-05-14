---
layout: post
title: "Moving Angular Factories to Services With Classes"
date: 2017-05-08 17:14:32 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Subscribe to get the latest about modern Angular 1.x"
cta_form: 208371
---

When I first [wrote](http://www.codelord.net/2015/04/28/angularjs-whats-the-difference-between-factory-and-service/) about the differences between services and factories in Angular, the bottom line was that the difference is semantic and so you should just pick one and stick with it.

Back then I made the point that, personally, I find factories require less boilerplate code and so they are often my choice.

Since then, a use case for using services has become more common, and that’s when using ES6/ES2015 classes.

**When making use of classes, services are the right choice.**

That’s because classes map naturally to an Angular service, let’s see how.

Take a look at this non-ES6 `UsersStore`:

```javascript
angular.module('app').factory('UsersStore', function($http) {
  return {
    getAll: function() { ... },
    get: function(id) { ... }
  };
});
```

Converting this to an ES6 class would look like this:

```javascript
class UsersStore {
  constructor($http) {
    this.$http = $http;
  }
 
  getAll() { ... }
  get(id) { ... }
}
```

The registration line would then be changed to this: 

```javascript
angular.module(‘app’).service(‘UsersStore’, UsersStore)
```

The behavior for all existing code that injects `UsersStore` will remain the same, this is a seamless transition.

An important note, though, is the way injection is now performed.
Note that `$http` is now provided to the class’s `constructor`.
In order to be able to access the injected service later, for example in the `getAll` method, we have to save it as a member.
Then, the code in the converted `getAll` function should make sure to reference it as `this.$http`.

The extra typing around a constructor might put off some people, but looking at the bright side I find it helps making it more painful to write uber controllers and services that take on too much responsibility :)

Subscribe below to learn more about modern Angular and using Angular with ES6.

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
