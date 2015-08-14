---
layout: post
title: "AngularJS: How to setup pushState with html5Mode"
date: 2015-05-12 22:44:40 +0300
comments: true
---

One of the nice features of Angular is the built-in support it has to use "real" looking URLs such as `/stuff/` instead of URLs with hashes/fragments, e.g. `#/stuff` (which we've gotten used to in the SPA world).

A lot of developers mess settings this up the first time. It is frustrating that it seems to work except in certain situations when set up bad (refreshing doesn't work, or links are broken, etc.). But if you know what buttons to push: it actually just requires a little work on your Angular app and some configuration on your server side.

## Client set up

First, you need to add a `config()` block to enable [`html5Mode`](https://docs.angularjs.org/guide/$location#html5-mode) like so:

```javascript
angular.module('app').config(function($locationProvider) {
    $locationProvider.html5Mode(true);
});
```

This enables HTML5 mode in Angular. This mode means Angular will use the [`pushState`](https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Manipulating_the_browser_history?redirectlocale=en-US&redirectslug=Web%2FGuide%2FDOM%2FManipulating_the_browser_history) API to change the browser's URL without causing a reload when possible (if you're using a legacy browser that doesn't support it, Angular will automatically fallover to using hashes as always).

The second change on the client is to not have the hashes in your links. For example change `<a href="#/stuff">Stuff</a>` to `<a href="/stuff">Stuff</a>`.

And the last client change is to add to your index.html file, under the `<head>` section a `<base>` tag, e.g. `<base href="/">`. This tells Angular what is the base path of your app so it would know how to change the browser URL correctly. For example, if your Angular app's root is under `http://www.example.com/app`, you should probably have a base tag set to `<base href="/app/">`.

## Server set up

Essentially this depends on what server solution you have for serving Angular's assets. You need to make it so that when the browser tries to access some "fake" URL, like `/users/123`, it would serve your Angular app. A lot of people first skip this step and then don't understand why they get 404 errors when refreshing their apps.

Of course I can't go over all the different server side technologies here, but as an example, here's the basic nginx configuration:

```
location / {
    root /path/to/app;
    try_files $uri index.html;
}
```

This tells nginx to try and fetch the file at the URL. If it really exists (e.g. it's a javascript file, an image, etc.) it would be served to the client. If it doesn't exist we assume it's a URL that Angular should manage and just return the index.html file to serve the Angular app and have it take over from there.

Happy state pushing!

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Don't miss more Angular and frontend tips, subscribe! (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline"><!--
    --><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
