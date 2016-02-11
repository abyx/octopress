---
layout: post
title: "Angular's .component - what is it good for?"
date: 2015-12-17 10:53:25 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 23918
---

*Note:* This post was updated for the official release of 1.5

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
    controllerAs: '$ctrl',
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
Also, we get to enjoy some default and save on boilerplate: `bindToController` is the default, `controllerAs` is on and defaults to `$ctrl` (I would have prefered a nicer looking default, but it'll do).  
Another nice point is that we don’t need to write a stupid function that always returns the same object.  
We just define that object right here.

# When can/should you use it?

Clearly there are a few cases where you *can’t/shouldn’t* use it:

- If you need the `link` function (though you rarely should)
- If you want a template-less directive, e.g. `ng-click` that doesn’t have a template or separate scope

For all your other directives, this should work.
And because it saves on boilerplate and less error-prone it’s nicer to use.

I usually prefer to go with whatever would work everywhere.  
And here it goes against `.component()` that it can’t fully replace `.directive()`.  

But, using it saves so much boilerplate.  
And, non-component directives should be rare, which means they’ll stand out even more.

That’s why, in my opinion, using this new syntax is worthwhile.
You can read the full docs about it [here](https://docs.angularjs.org/api/ng/type/angular.Module#component).

# Lots of new goodies

## $onInit

It has been pretty common to group initialization code of your controllers inside some function.
For example, John Papa's style guide [recommends](https://github.com/johnpapa/angular-styleguide#style-y080) an `activate()` function to fire promises.

With 1.5 there's official support for this much-needed concept.
If the controller has a `$onInit` function, it will be called once all bindings are initialized:

```javascript
app.component('foo', {
  templateUrl: 'foo.html',
  controller: function() {
    this.$onInit = function() {
        console.log('Foo component initialized');
    };
  }
});
```

This will also make transitioning components to ng2 easier (since it has the equivalent `ngOnInit` function).

## You can require other components/directives

In the first RC releases of 1.5, there was no (nice) way for using the awesome `require` property directives have.
It meant that making a structure of components that communicate using nice APIs on their controllers wasn't really possible.

But, with the final release we got it all sorted out:

```javascript
app.component('parent', {
  templateUrl: 'parent.html',
  controller: function() {
    this.helperFunc = function() {};
  }
});

app.component('child', {
    templateUrl: 'child.html',
    require: {
        parent: '^parent'
    },
    controller: function() {
        this.$onInit = function() {
            this.parent.helperFunc();
        };
    }
});
```

This greatly helps in writing maintainble Angular, as I've recommended (2 years ago!) [here](http://www.codelord.net/2014/03/30/writing-more-maintainable-angular-dot-js-directives/).

## One way bindings

First, make sure you don't confuse this with 1.3's [one-time bindings](http://blog.thoughtram.io/angularjs/2014/10/14/exploring-angular-1.3-one-time-bindings.html) (or "bind once").

One-way binding does half of what two-way binding does (surprisingly).
Previously, we could pass objects to child directives/components with the `=` binding:

```javascript
app.component('foo', {
  templateUrl: 'foo.html',
  bindings: {
    bar: '='
  },
  controller: function() {}
});
```

This would have created a two-way binding with the component's parent.
Whenever the parent would assign a new value, it would be propagated to the child.
And vice-versa, if the component assigns a new value it will be copied to the parent.

This, while helpful, isn't a very common scenario in my experience.
That's why Angular has finally introduced one-way bindings.

These create just a single watch, that watches for changes in the parent and syncs them to the child.
We gain performance (by cutting in half the amount of watches created) and things become less error prone.
This also is a step towards the way things will usually behave in ng2.

The syntax is similar:

```javascript
app.component('foo', {
  templateUrl: 'foo.html',
  bindings: {
    bar: '<'
  },
  controller: function() {}
});
```

Yeah, we just change `=` to `<`.

All in all, `.component()` is a great addition to Angular.
It's a real upgrade for code quality and helps you preper for ng2.

So, upgrade to 1.5 and start using `.component()`: you have unlocked a new skill!

<hr>

Do you have a big *Angular 1.x app* that you're scared will *rot and become legacy code*? Because 2.0 and TypeScript will soon be *the new shiny* yet you have *all this JS code* sitting there? Where will your team find the time, and *management approval*, to learn and move things to 2.0?

But what if you could *migrate your project*, incrementally, while keeping your time's pace and shipping awesome code? What if your team could learn a bit more Angular 2 with each task? Imagine you could get to be *working in 2.0 land without ever stopping your development*!

I'm cooking up a self-served course that will get you there. It will allow you, *on your own pace*, learn Angular 2 and TypeScript bit by bit. With those steps your team will migrate your project and soon you'll write all your new code with Angular 2, TypeScript, and *won't have to stay behind*.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
