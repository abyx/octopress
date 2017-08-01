---
layout: post
title: "Please use hasOwnProperty: short story of a hack"
date: 2014-03-14 23:14
comments: true
---

I know a lot of developers, when writing JavaScript, tend to neglect `hasOwnProperty`. I can understand it, too. First, it takes a lot of writing: compare `if (foo.hasOwnProperty('bar'))` to `if (foo.bar)`. Also, some coders assume that if the object you're handling is a simple object you created yourself and that you know it has no prototype inheritance, then `hasOwnProperty` is useless.

The problem is that `hasOwnProperty` is almost always relevant. As in 99% of the cases. So, why not make a habit of always using it? When you don't, it can *really* bite you in the ass. Here's a short story:

## The story of a hack

I was helping a friend with his Node.js server. I happened to glance a little piece of code that was basically a cache of valid administration authentication keys. An approximation is:

{% codeblock lang:javascript %}
var adminCache = {};
fetchAdminKeysFromDatabase().forEach(function(key) {
    adminCache[key] = true;
});

// ...

if (adminCache[request.getParameter('key')]) {
    // Assume the request is authenticated
} else {
    // Return 403
}
{% endcodeblock %}

Seems legit, right? Well, maybe at first glance. But imagine what happens if an attacker passes in a key of `"toString"`? **BOOM!** Yes, it's that easy to get pwned.

That's because `adminCache`, like any other object, *has* a `toString` property. I can only imagine how many similar bugs are waiting out there because of this.

Of course, had the line been `if (adminCache.hasOwnProperty(request.getParameter('key')))` everything would have been just fine.

So, please, use `hasOwnProperty`.

{% render_partial _posts/_partials/book_cta.markdown %}
