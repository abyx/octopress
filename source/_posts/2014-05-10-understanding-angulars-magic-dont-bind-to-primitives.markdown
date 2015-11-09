---
layout: post
title: "Understanding Angular's Magic: Don't Bind to Primitives"
date: 2014-05-10 18:29:03 +0300
comments: true
---

If you do Angular, chances are you've seen the rule “Don't bind to primitives” quite a few times. In this post I'll dig into one such example where using primitives causes problems:  a list of `<input>` elements, each bound to a string.

## Our example

Let's say you're working on an app with books, and each book has a list of tags. A naive way of letting the user edit them would be:

{% codeblock lang:html %}
<div ng-controller="bookCtrl">
    <div ng-repeat="tag in book.tags">
        <input type="text" ng-model="tag">
    </div>
</div>
{% endcodeblock %}
    
(You will probably want to add another input for adding new tags and buttons for removing existing ones, but we're ignoring that for simplicity's sake.)

A live demo of the example is available [here](http://jsfiddle.net/avivby/yPFL6/). Go ahead and edit one of the inputs. It might *seem* like everything is fine. But it's not. Taking a closer look would show that the changes you make aren't being synced back to the `book.tags` array.

That is because `ng-repeat` creates a child scope for each tag, and so the scopes in play might look like this:

`bookCtrl` scope = `{ tags: [ 'foo', 'bar', 'baz' ] }`

`ng-repeat` child scopes: `{ tag: 'foo' }`, `{ tag: 'bar' }`, `{ tag: 'baz' }`

In these child scopes, `ng-repeat` does not create a 2-way binding for the `tag` value. That means that when you change the first input, `ng-model` simply changes the first child scope to be `{ tag: 'something' }` and none of that is reflected up to the book object.

You can see here where primitives bite you. Had we used objects for each tag instead of a plain string, everything would have worked since the `tag` in the child scopes would be the same instance as in `book.tags` and so changing a value inside it (e.g. `tag.name`) would just work, even without 2-way binding.

But, let's say we don't *want* to have objects here. What can you do?

## A failed attempt

"I know!" you might be thinking, "I'll make `ng-repeat` wire directly to the parent's `tags` list!" Let's try that:

{% codeblock lang:html %}
<div ng-controller="bookCtrl">
    <div ng-repeat="tag in book.tags">
        <input type="text" ng-model="book.tags[$index]">
    </div>
</div>
{% endcodeblock %}
    
This way, by binding the `ng-model` directly to the right element in the `tags` list and not using some child-scope reference, it will work. Well, kinda. It *will* change the values inside the list as you type. But now something else is going wrong. Here, [have a look yourself](http://jsfiddle.net/avivby/htdKM/). Do it, I'll wait.

As you can see, whenever you type a character, the input loses focus. WTF?

The blame for this is on `ng-repeat`. To be performant, `ng-repeat` keeps track of all the values in the list and re-renders the specific elements that change.

But primitive values (e.g. numbers, strings) are immutable in JavaScript. So whenever a change is made to them it means we are actually throwing away the previous instance and using a different one. And so any change in value to a primitive tells `ng-repeat` it has to be re-rendered. In our case that means removing the old `<input>` and adding a new one, losing focus along the way.

## The solution

What we need to do is find a way for `ng-repeat` to to identify the elements in the list without depending on their primitive value. A good choice would be their index in the list. But how do we tell `ng-repeat` ***how*** to keep track of items?

Lucky for us Angular 1.2 introduced the `track by` clause:

{% codeblock lang:html %}
<div ng-controller="bookCtrl">
    <div ng-repeat="tag in book.tags track by $index">
        <input type="text" ng-model="book.tags[$index]">
    </div>
</div>
{% endcodeblock %}

This does the trick since `ng-repeat` now uses the index of the primitive in the list instead of the actual primitive, which means it no longer re-renders whenever you change the value of a tag, since its index remains the same. See for yourself [here](http://jsfiddle.net/avivby/ZXmuR/).

`track by` is actually way more useful for [improving performance in real apps](http://www.codelord.net/2014/04/15/improving-ng-repeat-performance-with-track-by/), but this workaround is nice to know as well. And I find that it helps in understanding the magic in Angular a bit better.

{% render_partial _posts/_partials/cta.markdown %}
