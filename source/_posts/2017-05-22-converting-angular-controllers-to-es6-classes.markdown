---
layout: post
title: "Converting Angular Controllers to ES6 Classes"
date: 2017-05-20 11:50:39 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Subscribe to get the latest about modern Angular 1.x"
cta_form: 214570
---

After covering the process of transforming Angular [services to ES6 classes](http://www.codelord.net/2017/05/08/moving-anuglar-factories-to-services-with-classes/), and digging into [how injection works](http://www.codelord.net/2017/05/14/angular-dependency-injection-annotations-with-es6-classes/) with ES6 classes, it’s time to take a closer look at controllers.

Controllers, being the basic building block in Angular, is also where you’ll get your biggest bang-for-the-buck for making the ES6 transition, in my opinion.
That is, assuming your project is already making use of [controller-as syntax](http://www.codelord.net/2015/09/30/angular-2-preparation-controller-code-smells/), as opposed to exposing all of your controllers’ logic directly on the `$scope` object.

Let us look at an example controller:

```javascript
function UsersCtrl(UsersStore) {
  var self = this;
  self.$onInit = function() {
    UsersStore.get().then(function(users) {
      self.users = users;
    }):
  };
 
  self.updateUser = function(user) {
    UsersStore.updateUser(user);
  };
}
```

(Note how all initialization is taking place inside the `$onInit` hook, which is [a must starting from 1.6+](http://www.codelord.net/2017/01/01/angular-1-dot-6-is-here-what-you-need-to-know/))

Here is how the above controller would be written as a class:

```javascript
class UsersCtrl {
  constructor(UsersStore) {
    this.UsersStore = UsersStore;
  }
 
  $onInit() {
    this.UsersStore.get().then(users => {
      this.users = users;
    });
  }
 
  updateUser(user) {
    this.UsersStore.updateUser(user);
  }
}
```

The conversion steps are:

1. Change the function to be a `class` definition
2. Create inside it a `constructor` and move all injections to be its parameters. Inside this constructor assign every injected service to be a member of the new class.
3. Change every method declared previously as `this.function` to be declared as a regular method in a class.
4. Update all references to injected services to use the local properties, e.g. `this.UsersStore` instead of `UsersStore`.

Keep in mind that while classes have a constructor, you *should not* be using them for any real logic.
You want to keep them as stupid as possible, only making sure to save injections.
All other logic should be kept inside the `$onInit` hook.

Also note that ES6 classes do not have a concept of private methods/members.
In the function syntax you could have declared a `var innerData` inside the `UsersCtrl` function, and `innerData` would not have been accessible to the template.
That’s not the case with classes, and so I usually opt for a naming convention where templates are not allowed to access any methods or members on the controller that start with a `_`, e.g. `_innerData`.

You might find it icky, but that’s just the way it is.
TypeScript, which you might also be considering, supports private members and even saves you the constructor boilerplate.

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
