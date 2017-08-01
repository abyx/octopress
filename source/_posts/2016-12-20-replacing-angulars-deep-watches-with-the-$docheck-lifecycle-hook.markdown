---
layout: post
title: "Replacing Angular's Deep Watches with the $doCheck Lifecycle Hook"
date: 2016-12-20 17:26:51 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 141643
---

After [digging into](http://www.codelord.net/2016/12/13/replacing-%24scope-dot-%24watch-with-lifecycle-hooks/) Angular’s components `$onChanges` lifecycle hook to show how you can replace a regular shallow `$scope.$watch` with it, let’s see what the latest Angular has to offer when it comes to deep watches.

Deep watches are what Angular does when you supply a third argument to `$scope` with the value of `true`:

```javascript
$scope.$watch(() => this.foo, this.handleChange, true);
```

*Note:* I’m using [ES6’s arrow functions](http://www.codelord.net/2016/05/05/using-es6-arrow-functions-in-angular-1-dot-x-plus-cheatsheet/) for brevity, but obviously you don’t have to.

By using deep watches, we can ask Angular to keep track of changes happening inside an object, by mutating it, instead of only notifying us when the object’s reference has changed (which is the default behavior of `$scope.$watch`).

While it’s possible to use `$onChanges` for being notified about changes to references on bindings, there’s no easy way to do it for mutations without `$scope.$watch`.

The problem is that Angular is moving off `$scope`, and we would like to be able to use it only where it’s really a must, so what can we do?

First, think whether you really need to be mutating state.
In a lot of scenarios, using immutable models makes a lot more sense, and using one-way data flow makes code easier to maintain.

But, in cases you have to keep using deep watches, there’s some more modern solution offered by Angular.
The `$doCheck` lifecycle hook is a bit peculiar.
It’s basically a hook that Angular calls on each turn of the digest cycle, for us to add our logic in it.
That allows us to regularly check if anything has changed and requires our component’s attention.

What this enables us to do, in practice, is replace our deep watches.
Here’s an example:

```javascript
function FooCtrl() {
  var previousFoo = undefined;

  this.$onInit = () => { previousFoo = angular.copy(this.foo) };

  this.$doCheck = () => {
    if (!angular.equals(this.foo, previousFoo)) {
      this.handleFooChange();
      previousFoo = angular.copy(this.foo);
    }
  };
}
```

Now, this is a bit of a mouthful.
As you can see, when we want to drop deep watches we actually have to do quite some work on our own: keep track of the previous value, make the comparison, and make sure we are holding a copy of the value (otherwise we’ll never see changes).

Angular is basically telling us that deep watches belong to the past, and that there’s a way to keep doing them without scopes, but you’ll need to work for it.
Personally, I don’t love the extra typing, but I think that if you have to keep using deep watches for now and are upgrading your code to the latest 1.6 standards, you should probably be doing this.

Nowadays, a modern Angular app should be making very small use of scopes, and deep watches are a big red flag usually.
This makes sense both from the standpoint of moving to a one-way data flow, and for keeping your options open when it comes to migrating to Angular 2+ down the road.

{% render_partial _posts/_partials/book_cta.markdown %}
