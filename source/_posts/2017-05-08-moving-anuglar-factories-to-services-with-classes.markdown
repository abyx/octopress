---
layout: post
title: "Moving Angular Factories to Services With Classes"
date: 2017-05-08 17:14:32 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
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

{% render_partial _posts/_partials/book_cta.markdown %}
