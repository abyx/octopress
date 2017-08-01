---
layout: post
title: "AngularJS: Decisions, Decisions & My Preferred Choices"
date: 2014-05-26 07:26:34 +0300
comments: true
---

Angular is the land of too much free choice. You are faced with decision after decision, over and over again. Choice is good, but sometimes too much choice can cause paralysis. Let's take a look at some of these choice and what I usually go with:

#### Factory vs. Service

Chances are you saw these two common ways of creating injectable objects, `factory` and `service`, and couldn't help but wonder “what the *f@#$@* is the difference?”

Essentially, `factory` takes a function whose return value is the thing that would be injected. So if we have this:

```javascript
angular.module('app').factory('MyThing', function() {
    return {id: 1, thing: 'stuff'};
});
```

And you inject it, you will be injected with the object `{id: 1, thing: 'stuff'}`. 

`service` is almost identical, except that it expects you to provide it with a *constructor function*. It instantiates a new object using that function and *that* is what is injected:

```javascript
angular.module('app').service('MyThing', function() {
    this.id = 1;
    this.thing = 'stuff';
});

angular.module('app').controller('MyCtrl', function(MyThing) {
    // Here MyThing is {id: 1, thing: 'stuff'}
});
```

**Note:** Every place that `MyThing` would be injected it would be same instance. In other words Angular will instantiate a single instance and reuse it across your app.

Which should you pick? In general, since the two are almost equivalent I like sticking to just one of these in a project, usually **`factory`**. It can do anything you can do with `service` and I personally don't see a need to go through creating a constructor that's just called once. I just return that instance and that's it.

#### Value vs. Constant

Angular lets us quite easily add simple injections of plain values. For example, say you want to declare a constant like your REST URLs base path. You can do it with either `module.value('restBase', '/api/v2')` or `module.constant('restBase', '/api/v2')`. *Really?*

The difference is that while `constant`s can be injected to module configuration functions (i.e. `module.config()`) `value`s cannot. Also, you can intercept `value`s with `$provide` and decorate them. These are two usages are pretty uncommon and are for more advanced cases, so don't worry right now if you don't know them.

Since they're so similar I'd just stick with constants unless your are using it to store something that is not actually constant (i.e. an object that you change later on). But that's basically a global variable, so you probably should never do that. So *constants* it is!

#### Directive vs. Nested Controllers

For some uses, directives and controllers can be used interchangeably. We all know that directives should be used for DOM access and controllers are usually used for top-level elements like pages and routing targets. What about all the rest?

I'll just cut to the chase: Almost always the right choice, in my opinion, is to use a *directive*. Directives allow you to write code that is more decoupled and self-contained. Directives let you to explicitly state what they depend on, opposed to controllers that just inherit their parents' scopes as-is. More on this next.

#### Same scope, new scope, isolated scope

Now that you've realized that you should almost always use directives comes the decision of scope. Should you just use the parent scope? Inherit it? Isolate completely?

Well, my heuristic is: Will creating an isolated scope mess things up? For example, if your directive might be used along other directives/controllers that would not expect the scope to be swapped. If so: prefer to inherit the scope if possible, use the parent scope only if you must.

In pretty much any other case I just use an *isolated scope*. They are the best thing since sliced bread. Isolated scopes are explicit (it is easy to see what they depend on), durable (they are less likely to break because of code changes somewhere else) and plainly the way to go. I've described their advantages in [“Writing More Maintainable Directives”](/2014/03/30/writing-more-maintainable-angular-dot-js-directives/).

{% render_partial _posts/_partials/book_cta.markdown %}
