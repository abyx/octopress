---
layout: post
title: "Simple pagination and URL params with ui-router"
date: 2015-06-20 19:10:14 +0300
comments: true
---

ui-router *rocks*. There's a reason it's become the de facto router in Angular. Its power is in its versatility, but it takes time to master all the different knobs it has to offer.

This shortie post is about something we face quite often: adding simple query parameters to our SPA for stuff like pagination and sorting.

## Problem definition

The use-case is straightforward: say you have a long list of information that you'd like to present with pages and different sorting options.

The ideal case would be that our controller, let's call it `ListCtrl`, has 2 optional parameters - `page` and `sort`- with default values (obviously `0` for pages and we'll use `upvotes` for sorting).

Basically we'd like to have the following URLs be associated with the following parameters passed to `ListCtrl`:

- `/list` with `{page: 0, sort: 'upvotes'}`
- `/list?page=1` with `{page: 1, sort: 'upvotes'}`
- `/list?page=2&sort=date` with `{page: 2, sort: 'date'}`

This is really easy as pie:

## State configuration

```javascript
$stateProvider.state('list', {
    url: '/list?page&sort',
    controller: 'ListCtrl',
    controllerAs: 'list',
    templateUrl: 'list.html',
    params: {
        page: {
            value: '0',
            squash: true
        },
        sort: {
            value: 'upvotes',
            squash: true
        }
    }
});
```

You can see this looks like an ordinary state with a few details: we specify the names of our parameters in the `url` and provide those parameters' default values and set them to `squash`, which means ui-router won't put them in the URL if their current value is the default value (read all about this configuration in the docs of [`$stateProvider`](http://angular-ui.github.io/ui-router/site/#/api/ui.router.state.$stateProvider).

That's about it!

## Simple Controller

Our controller might look something like this:

```javascript
function ListCtrl($stateParams, $state) {
    var self = this;
    self.page = parseInt($stateParams.page, 10);
    self.sort = $stateParams.sort;

    function sortList() {}
    function updatePage() {}
    
    sortList();
    updatePage();
    
    self.nextPage = function() {
        $state.go('.', {page: self.page + 1});
    };
    self.prevPage = function() {
        if (self.page > 0) {
            $state.go('.', {page: self.page - 1});
        }
    };
    self.sortChanged = function() {
        $state.go('.', {sort: self.sort});
    };
}
```

Note that ui-router's parameters' default values must be strings and are passed to us from `$stateParams` as strings, so we take care to use `parseInt`.

You can see that updating the URL parameters is quite straightforward - you just call `$state.go` with the current state (`'.'`) and the parameters you want to update - the rest remain as-is!

## Updating parameters with reloading the controller

The example above worked because `$state.go()` would reload our controller with updated `$stateParams`. While this might be all you need sometimes, other times you won't want to reload the whole controller.

In those situations you can use `$state.go()` with the special `{notify: false}` configuration which effectively prevents your controller from being reloaded (see the [documentation](http://angular-ui.github.io/ui-router/site/#/api/ui.router.state.$state) for full details). What it does mean, though, is that we'll need to update sorting/paging ourselves in the controller:

```javascript
self.nextPage = function() {
    self.page++;
    updatePage();
    $state.go('.', {page: self.page}, {notify: false});
};
```

That's about it! You can download a really simple skeleton that shows how this works [here](https://gist.github.com/abyx/f5ef04d807dc15617331).

Happy routing!

{% render_partial _posts/_partials/book_cta.markdown %}
