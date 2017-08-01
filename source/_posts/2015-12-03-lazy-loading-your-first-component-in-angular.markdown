---
layout: post
title: "Lazy Loading Your First Component in Angular"
date: 2015-12-03 17:18:53 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
---

A lot of web developers that come to Angular from other MVC frameworks are surprised to learn that there’s no official support for lazy loading.

Lazy loading is the common practice of not loading all of your source files on initial load.
This can speed up your load times significantly in certain cases.

While some frameworks support this out of the box, with solutions like RequireJS, Angular doesn’t play that easy.

Angular 1.x has no support for lazy loading.
In fact every solution is kind of a workaround for the way Angular expects to work.

*Why doesn’t Angular support this?*
Well, to be frank I’ve seen relatively large applications get great load times by [minifying](http://www.codelord.net/2015/11/18/the-deal-with-angular-and-minification/) all code to a single file.
A lot of the times lazy loading is just premature optimization.

But say that you’ve measured, checked and finally decided you really need lazy loading.

# Introducing ocLazyLoad

The [ocLazyLoad](https://oclazyload.readme.io) library is a popular open source project for adding lazy loading capabilities to Angular.

I like it because it’s simple and doesn’t require a lot of fussing around to get your first component lazy-loaded.
You don’t need to start extracting extra modules and make big changes to the way you structure your app.

It is really the simplest lazy loading solution I know for Angular.

# Example: A lazy loaded ui-router state

Say that you have a ui-router state that’s seldom used and uses some big file you’d rather not load until needed.

Once you include the ocLazyLoad source (e.g. using bower) the job is pretty easy.

First, make sure you’re not loading the lazy loaded files on initialization.
For example, you might need to remove the `<script>` tag from your `index.html` file.

Now, let’s configure our state appropriately:

```javascript
$stateProvider.state('lazy', {
  url: '/lazy',
  template: '<lazy></lazy>',
  resolve: {
    lazyLoad: function($ocLazyLoad) {
      return $ocLazyLoad.load('lazy.directive.js');
    }
  }
});
```

This little snippet uses `resolve` to load the needed files before loading our state.
I [don’t usually use](http://www.codelord.net/2015/06/02/angularjs-pitfalls-using-ui-routers-resolve/) `resolve`, but this is a nice use case.

You can load multiple files here.
For example, load your directive along some external and big JavaScript plugin.

**And that’s it**.
We actually didn’t need to write our `lazy` directive differently than any other directive.

That was easy, wasn’t it?

{% render_partial _posts/_partials/book_cta.markdown %}
