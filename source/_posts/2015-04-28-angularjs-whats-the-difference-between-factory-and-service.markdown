---
layout: post
title: "AngularJS: What's the difference between factory and service?"
date: 2015-04-28 23:25:10 +0300
comments: true
---

When getting started with Angular it can be a bit overwhelming to try and make sense of all the different tools and types of components that are available to us.

A very popular example of this are Services and Factories: they seem so similar yet they both exist for some reason. You're trying to understand whether there's really any difference. No one wants to pick the *"wrong one"* or *"make the wrong choice"*.

## Factories vs. Services

First, right off the bat I'll say they're pretty much equivalent. Why do we have them both, then? That's for the gods of Angular to know. They both allow us to create an object that can then be used anywhere in our app.

Most important is to realize that both are **singletons** in your app, even though the name "factory" might imply differently.

Essentially, factories are functions that *return the object*, while services are *constructor functions of the object* which are instantiated with the `new` keyword.

## To the code!

To the users of our services and factories it all looks the same. This code below would be written the same regardless of which was used:

```javascript
angular.module('app').controller('TheCtrl', function($scope, SomeService) {
    SomeService.someFunction();
});
```

Here is a matching factory:

```javascript
angular.module('app').factory('SomeService', function() {
    return {
        someFunction: function() {}
    };
});
```

This will result in an injectable object called `SomeService` with a single public function `someFunction`.

And here is a matching service:

```javascript
angular.module('app').service('SomeService', function() {
    this.someFunction = function() {};
});
```

This will result in... well... the *same* injectable object as above.

## What to do? Use factories!

Now that you know the difference and can see that there's none really, I'd recommend just going with one and get on with coding. Which one? Factories are the popular choice in the Angular community. I went with this decision years ago and recently saw that it is also the recommended way according to [John Papa's (excellent) style guide](https://github.com/johnpapa/angular-styleguide).

{% render_partial _posts/_partials/cta.markdown %}
