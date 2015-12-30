---
layout: post
title: "Automatically find links in text using Angular"
date: 2015-12-31 00:07:25 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Always be in the loop for new updates to Angular and get guides for painless upgrading!"
---

There comes in every web developer’s life a day where he needs to take some block of text and automatically find URLs inside it and transform them into links, inline.

Almost any text that a user inputted would be nicer if it did this automatically.

I don’t know about you, but I’ve accomplished this task in Angular in several ways like jQuery plugins or writing my own regular expressions.
It’s not fun adding extra dependencies to accomplish this minor tasks. And it’s always a bit nontrivial to add link support without opening yourself up to some vulnerabilities.

I was quite surprised to hear that there’s a solution to this that comes builtin in Angular and since 1.0: the **linky** filter.

# Setting it up

The `linky` filter does what you’d expect it to do.
Let’s see an example.

First, as [the docs](https://docs.angularjs.org/api/ngSanitize/filter/linky) say, you need to make sure that you include  ngSanitize module file (angular-sanitize.js) and add it as a dependency to your module:

```javascript
angular.module('myApp', ['ngSanitize']);
```

The basic usage goes like this:

```html
<div ng-bind-html="blog.post | linky"></div>
```

This will take `blog.post` and display it regularly, except that URLs inside it, such as `www.google.com` would become links.
Angular does this safely and sanitizes all the text.

You can quite easily make links open in a new tab or add specific attributes, such as `rel=nofollow` which is usually recommended when putting up links to user generated content:

```html
<div ng-bind-html=
    "blog.post | linky:'_blank':{rel: 'nofollow'}">
</div>
```

And that’s it. Link away!

{% render_partial _posts/_partials/cta.markdown %}
