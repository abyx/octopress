---
layout: post
title: "Query Parameters in ui-router Without Needless Reloading With Example Project"
date: 2015-11-25 21:28:02 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Don't waste time fighting the many Angular pitfalls. Learn how to do things the right & productive way"
---

You’re working on a new page in your app, one that should use query parameters. Query parameters give you support for deep links, bookmarks, browser history support, etc.

If you reach for doing this in ui-router without proper research, you’ll quickly stumble upon several traps. For example, you’ll notice that your state reloads on every parameter change. Or that some of the workarounds online completely break browser history.

Let’s see how we can do this the right way. In a [previous post](http://www.codelord.net/2015/06/20/simple-pagination-and-url-params-with-ui-router/) we saw how ui-router can be used for easily doing pagination and sorting in the URL.

Another popular use case is a text input whose value is synced as a query parameter, e.g. for search pages.

I’m pretty sure you don’t want your state to reload just because the user typed a character and the URL has updated from `/inbox?search=a` to `/inbox?search=ab`. 

# Serializing an input to a query parameter

First, our directive’s controller will have pretty much this logic:

```javascript
var vm = this;
vm.searchText = $state.params.search;

vm.searchTextChanged = function() {
  $state.go('.', {search: vm.searchText}, {notify: false});
};

$scope.$on('$locationChangeSuccess', function() {
  vm.searchText = $state.params.search;
});
```

With this template:

```html
<input type=text ng-model=inbox.searchText
  ng-change=inbox.searchTextChanged()>
<div ng-repeat="item in inbox.items
                | filter:{text: inbox.searchText}">
 {% raw %}{{ item.text }}{% endraw %}
</div>
```

And this state configuration:

```javascript
$stateProvider.state('inbox', {
  url: '/inbox?search',
  template: '<inbox></inbox>',
  params: {
    search: {
      value: '',
      squash: true
    }
  },
  reloadOnSearch: false
});
```

We define a state with an optional search parameter. Then we wire the directive to initialize the search input from the URL parameter, and make it update the URL parameter whenever the input changes.

We update the URL using `$state.go()` and are careful to pass `{notify: false}`. This prevents ui-router’s default behavior of reloading the state.

## Preventing reloads on back button clicks

If you check the code now, you’ll see that whenever the `search` parameter changes due to back/forward presses in the browser the state still reloads. This might actually be OK for you, depending on your scenario.

But sometimes that’s *unacceptable*.

You can use the `reloadOnSearch` option to disable the reloading:

```javascript
$stateProvider.state('list', {
  // Same as before, but add:
  reloadOnSearch: false
});
```

But this alone breaks browser history in this state. We need to watch for when the user changes the query parameters in the address bar, or presses the back button. You will need to listen for `$locationChangeSuccess` events:

```javascript
$scope.$on('$locationChangeSuccess', function() {
  // Use $state.params to update as needed
});
```

Note: This will be triggered for address bar/back button URL changes, but also for changes we initiate from our code. Keep this in mind. Also, it seems that you can’t trust `$stateParams` when using this approach, as it will not get updated. You’ll need to use only `$state.params`.

Voila! You can play around with a [live demo here](http://abyx.github.io/angular-ui-router-query-params-example/).

## Possible improvements

The current solution enters every character changes to the history. In case that’s not the right UX for you, you might want to look into minimizing history.

For example, we can only write some of the changes to the browser history, or even squash changes to the same parameter to a single item in the browser history.

If those scenarios interest you, leave a comment and sign up for my newsletter to get the post once it’s out!

{% render_partial _posts/_partials/cta.markdown %}
