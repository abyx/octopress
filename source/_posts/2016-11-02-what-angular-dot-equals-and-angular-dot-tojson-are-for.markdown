---
layout: post
title: "What Angular's .equals and .toJson are for"
date: 2016-11-02 19:44:00 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 120064
---

Why did Angular implement its own `angular.toJson()` if  we already have `JSON.stringify()`?  
Why isn’t `angular.eqauls()` always the same as other equality utilities, like lodash’s `_.isEqual()`?

I faced these questions when I first started doing Angular.
Taking care to note the difference has helped me avoid some pitfalls along the way and understand Angular a little bit better.

# The unique behavior of angular.equals

Once you use Angular enough you eventually notice that Angular tends to prefix its own properties and functions with `$`.
For example, if you use ng-resource (though I think you [shouldn’t](http://www.codelord.net/2015/07/17/resourceful-angular-%24http-%24resource-restangular-head-to-head/)) you will see methods such as `$save()`.
Another case is scopes’ `$apply`, `$watch`, etc. and `ngModelController`’s `$error` and similar.

Because of that, the Angular team implemented `.equals()` so that it ignores properties that start with `$`.
This means you can compare objects without fear of Angular’s properties getting in the way (like equality of two ng-resource instances):

```javascript
angular.equals({a: 1}, {a: 1}) === true
angular.equals({a: 1}, {a: 1, $a: 2}) === true
```

`.equals()` also differs from other utilities in that it completely ignores functions:

```javascript
angular.equals({a: 1}, {a: 1, b: function() {}}) === true
```

This allows us to compare objects considering only their data, not their functions or Angular-added properties.

# The curious case of angular.toJson

One of the first functions any developer doing JavaScript comes across is `JSON.stringify()`.
At first, I didn’t realize why Angular would need to add its own way of doing that.

Well, it turns out that the Angular team didn’t do it because they just happen to like rewriting everything.
`toJson` is different in that it *ignores properties starting with `$$`*.
Yes, that’s two `$` signs, unlike `equals()`.

While Angular uses the `$` prefix to denote its own properties, `$$` means *private Angular stuff*, or “don’t touch this.”

The fact `toJson` ignores these means you won’t get unexpected attributes on your data.
The most common use case is the fact Angular adds a `$$hashKey` property to elements in `ngRepeat` (when you don’t use [`track by`](http://www.codelord.net/2014/04/15/improving-ng-repeat-performance-with-track-by/)).

Say you use `ng-repeat` to display some list of objects you got from the server, and then after the user changes them you send them back to update the server.
The silently-added `$$hashKey` might end up in your database, or trip up server-side validations about unexpected fields.

That’s why Angular provides `toJson` and uses that by default for serialization (e.g. in `$http`).

The companion `fromJson()` is plainly a wrapper around `JSON.parse()`, probably to provide the symmetry.

Now you know!

{% render_partial _posts/_partials/book_cta.markdown %}
