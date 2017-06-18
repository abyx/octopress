---
layout: post
title: "Angular Dependency Injection Annotations With ES6 Classes"
date: 2017-05-14 23:29:22 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Subscribe to get the latest about modern Angular 1.x"
cta_form: 211387
---

After covering how ES6 classes can be used for defining services in Angular in the [previous post](http://www.codelord.net/2017/05/08/moving-anuglar-factories-to-services-with-classes/), I was asked how do these play along with Angular’s [dependency injection annotations](http://www.codelord.net/2015/11/18/the-deal-with-angular-and-minification/).

To recap, dependency injection annotations are used so that Angular would know what it should be injecting even when code is obfuscated/minified.
This is a regular service with injection in ES5:

```javascript
angular.module('app').service('Service', function($http) {
  this.get = function() { ... };
});
```

And that example with explicit annotations would look like so:

```javascript
angular.module('app').service('Service', ['$http', function($http) {
  this.get = function() { ... };
}]);
```

How does this play along with ES6 classes?

The above example as a class looks like this:

```javascript
angular.module('app').service('Service', Service);

class Service {
  constructor($http) {
    this.$http = $http;
  }
  get() { ... }
}
```

And in order to add proper annotations to it, simply add this line at the bottom:

```javascript
Service.$inject = ['$http'];
```

That’s all there’s to it, if you insist on adding these manually.

But please, stop doing it *like an animal*, and incorporate something like [babel-plugin-angularjs-annotate](https://github.com/schmod/babel-plugin-angularjs-annotate).
Given that you’re using ES6, you very likely already transpiling your code into ES5, and this plugin can simply go over your code at that point and add these as necessary, given little hints.
I've written more about it [here](http://www.codelord.net/2017/06/18/ng-annotate-deprecated-what-that-means-for-your-projects/).

Keep it classy! `</dadpun>`


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
