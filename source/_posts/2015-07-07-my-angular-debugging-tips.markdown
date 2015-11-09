---
layout: post
title: "My Angular Debugging Tips"
date: 2015-07-07 23:02:42 +0300
comments: true
facebook:
    image: /images/posts_images/angular-debug.png
---

Yeah, I know, your code is awesome and you never write any bugs. My code *does* have bugs every now and then. In those cases these tips come in handy.

{% img /images/posts_images/angular-debug.png %}

## ng-Inspect Element

Perhaps the most useful trick is to know that once you right click on an element on screen and pick 'inspect element' Angular makes it very easy for you to get things going.

In the browser's developer tools console write `angular.element($0)` and you now have access to all the good things:

* Scope: `angular.element($0).scope()` will return the scope for the element. This is golden.
* Controller: `angular.element($0).controller()` will give you the controller, doh.
* Injector: `angular.element($0).injector()` returns the app's injector, which you can then use to get access to other things (e.g. `injector.get('MyService')` or `injector.get('$http')`)

## Extensions

There's a growing number of handy extensions and snippets for Angular. Here are a few ones to try out:

* [Batarang](https://github.com/angular/angularjs-batarang) - An official extension from Angular itself that most people love just because it shortens the previous trick from `angular.element($0).scope()` to `$scope` and the likes.
* [ng-inspector](http://ng-inspector.org) - Has similar tools to Batarang's for looking at your app's hierarchy, walking the scopes, etc. but works on Safari and Firefox and not just Chrome.
* [ng-stats](https://github.com/kentcdodds/ng-stats) - A little utility to show your app's digest/watches situation, handy for spotting performance issues.

## Print debugging

[Print debugging](https://en.wikipedia.org/wiki/Debugging#Techniques) is always useful, but sometimes `console.log`s alone are not enough. For these cases Angular provides us with a very nice little filter that even [the docs](https://docs.angularjs.org/api/ng/filter/json) say is just for debugging - the `json` filter.

Have some model or scope you want to see easily? Just print it: `<pre>{% raw %}{{ someModel | json }}{% endraw %}</pre>` (Using `pre` means you'll see the json properly formatted).

## Bugs be gone

I hope this will help you out. If you have any other tricks I'd love to hear!

Happy debugging (well, you know, as much as possible).

{% render_partial _posts/_partials/cta.markdown %}
