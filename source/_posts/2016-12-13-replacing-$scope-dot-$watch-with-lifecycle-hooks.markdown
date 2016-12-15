---
layout: post
title: "Replacing $scope.$watch with Lifecycle Hooks"
date: 2016-12-13 16:39:06 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Subscribe to get the latest about modern Angular 1.x"
cta_form: 138751
---

It is not uncommon to have an Angular directive or component that needs to perform some work when its bounded inputs are changed.

And we all know watches are bad for performance, and that you should only use them when you really need them.
But sometimes your code really needs them.
What to do?

With Angular 1.5’s introduction of components, and the back-porting of [lifecycle hooks](http://www.codelord.net/2016/04/14/angular-1-dot-5-new-component-lifecycle-hooks/) from Angular 2, we have cleaner ways of achieving this.

*Note:* This post will use components, but lifecycle hooks are available in Angular’s directive as well.
You can make use of this technique even if your team hasn’t moved to components  yet, as long as you’re using Angular 1.5 or later.

Let’s look at a an example component.
For brevity I’ll be using ES6’s [arrow functions](http://www.codelord.net/2016/05/05/using-es6-arrow-functions-in-angular-1-dot-x-plus-cheatsheet/), but of course you don’t have to:

```javascript
app.component('chart', {
  templateUrl: 'chart.html',
  bindings: {
    dataSeries: '='
  },
  controller: function($scope) {
    this.$onInit = () => {
      $scope.$watch(() => this.dataSeries, () => this._updateChart());
    };

    this._updateChart = () => {
      // Some D3 code to update the chart
    };
  }
});
```

As you can see, this is a very basic component that wraps around some native D3 code to render a chart.
Whenever its input binding, `dateSeries`, is changed the component re-renders the chart.
And it keeps track of those changes using `$scope.$watch`.

Now, let’s make use of the `$onChanges` lifecycle hook.
`$onChanges` is called automatically by Angular whenever an input binding is changed by the component’s parent.

A couple of important details to notice: `$onChanges` only works with one-way bindings (and `@` bindings), which is what you [should be using](http://www.codelord.net/2016/05/19/understanding-angulars-one-way-binding/) 99% of the time, and `$onChanges` is only triggered when the parent component reassigns the value.
It will not be triggered if you reassign it inside the component itself.

So let us update our component to use one way bindings and `$onChanges` instead of a watch:

```javascript
app.component('chart', {
  templateUrl: 'chart.html',
  bindings: {
    dataSeries: '<' // Changed to one way
  },
  controller: function() {
    this.$onChanges = (changes) => {
      if (changes.dataSeries) {
        this._updateChart();
      }
    };

    this._updateChart = () => {
      // Some D3 code to update the chart
    };
  }
});
```

That’s about it.
We no longer need to inject `$scope`, which is always a good thing.
And we also removed a watch: Angular has its own watch on the binding anyway in order to sync it between components, and we’re taking advantage of it.

## Detecting the Initialization Call

Sometimes when using `$watch` we would like to treat the first time it is called differently, since `$watch` triggers immediately after starting a watch.
The way we identify it would be to write code such as this:

```javascript
$scope.$watch(() => this.foo,
  (newValue, oldValue) => {
    if (newValue === oldValue) return;
    this.updateView();
});
```

As you can see, we’d check if `newValue` is the same as `oldValue`, which is Angular’s way of telling us it’s the initial run of the watcher.

With `$onChanges` we have a clearer way of achieving this:

```javascript
this.$onChanges = (changes) => {
  if (changes.foo && !changes.foo.isFirstChange()) {
    this.updateView();
  }
};
```

As you can see, the `changes` object comes with a handy `isFirstChange()` method.

## Keeping Track of the Previous Value

Another useful capability of `$watch` is that whenever it was triggered it would supply our listener with both the current value and the previous value.
This allows the code to compare them:

```javascript
$scope.$watch(() => this.foo,
  (newValue, oldValue) => {
    if (newValue.date !== oldValue.date) {
      this.updateView();
    }
});
```

Fear not, the `changes` object still got you covered:

```javascript
this.$onChanges = (changes) => {
  if (!changes.foo) return;
  if (changes.foo.currentValue.date === changes.foo.previousValue.date) {
    return;
  }

 this.updateView();
};
```

## Gotcha: `$onChanges` and `$onInit`

It just so happens that Angular triggers the initial `$onChanges` right before calling the `$onInit` hook.
You should be aware of that when you write your component’s lifecycle hooks and make sure that you don’t rely in `$onChanges` on anything that gets setup by `$onInit`, and if so, make sure to account for it on the first change call.

That’s it!
You just got rid of some needless `$scope.$watch` calls.
Better performance, and modern code - *win!*  
Pat yourself on the back for me.

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
