---
layout: post
title: "My Angular Debugging Tips"
date: 2015-07-07 23:02:42 +0300
comments: true
categories: 
- Programming
- angular
- angularjs
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

Have some model or scope you want to see easily? Just print it: `<pre>{{ someModel | json }}</pre>` (Using `pre` means you'll see the json properly formatted).

## Bugs be gone

I hope this will help you out. If you have any other tricks I'd love to hear!

Happy debugging (well, you know, as much as possible).

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Don't miss the next Angular and frontend tip, subscribe! (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline"><!--
    --><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
