---
layout: post
title: "Angular's .component - what is it good for?"
date: 2015-12-17 10:53:25 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Always be in the loop for new updates to Angular and get guides for painless upgrading!"
---

In my [Angular 1.5 sneak peek](http://www.codelord.net/2015/12/10/angular-1-dot-5-is-close-heres-the-interesting-parts/) I mentioned the new `.component()` method.
A lot of people are quite excited about this method.
But, as with anything new, there are open questions:

When should you use it?  
*Why* should you use it?  
What’s the difference between it and `.directive()`?

Today we’ll understand what exactly it does and whether it’s good for you.

# Syntax sugar

First things first: this method is truly just syntax sugar for the good old `.directive()` method you know (and hate?).

There’s nothing you can do with `.component()` that you can’t do with `.directive()`.

# So what is it good for?

It aims to simplify the way we create “components” - which roughly means UI directives.
It also pushes the community to use the defaults that have become best practices:

- Components have isolated scopes by default
- They automatically use controllerAs syntax
- They use controllers instead of `link` functions
- The `bindToController` option is on by default

If this sounds familiar, you might remember this is basically how I’ve recommended we write directive controllers in [this post](http://www.codelord.net/2015/10/07/angular-2-preparation-killing-controllers/).

# Show me the code: before and after

Here’s an example component directive:

```javascript
app.directive('list', function() {
  return {
    scope: {
      items: '='
    },
    templateUrl: 'list.html',
    controller: function ListCtrl() {},
    controllerAs: 'list',
    bindToController: true
  }
});
```

It’s a simple component directive, with an isolated scope, binding, and a controller.

Here’s how you’ll write it with `.component`:

```javascript
app.component('list', {
  bindings: {
    items: '='
  },
  templateUrl: 'list.html',
  controller: function ListCtrl() {}
});
```

As you can see, not much has changed.  
But, things are simpler and more straightforward.  
Also, we get to enjoy some default and save on boilerplate: `bindToController` is the default, `controllerAs` is on and defaults to the component’s name.  
Another nice point is that we don’t need to write a stupid function that always returns the same object.  
We just define that object right here.

# When can/should you use it?

Clearly there are a few cases where you *can’t/shouldn’t* use it:

- If you need the `link` function (though you rarely should)
- If you want to use `require` to pass parent directive’s controllers
- If you want a template-less directive, e.g. `ng-click` that doesn’t have a template or separate scope

For all your other directives, this should work.
And because it saves on boilerplate and less error-prone it’s nicer to use.

I usually prefer to go with whatever would work everywhere.  
And here it goes against `.component()` that it can’t fully replace `.directive()`.  

But, using it saves so much boilerplate.  
And, non-component directives should be rare, which means they’ll stand out even more.

That’s why, in my opinion, using this new syntax is worthwhile.
You can read the full docs about it [here](https://docs.angularjs.org/api/ng/type/angular.Module#component).

So, start using `.component()` once 1.5 is out: you have unlocked a new skill!

{% render_partial _posts/_partials/cta.markdown %}
