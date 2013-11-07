---
layout: post
title: "Stop Using Key Up Events When You Don't Need To"
date: 2013-11-07 19:49
comments: true
categories: 
- css
- javascript
- html
- angular
- angularjs
---

A common task for web developers is capturing the case where the user presses the enter/return key on his keyboard when filling out a form, instead of clicking the "submit" button. 

I've seen many, many developers reach for the key press events and check whether enter was pressed (oh, char code 13, how I hate you). That of course works, but is nasty. Here's is an example using Angular.js (which I'm sure you can translate easily to your favorite way of doing this, such as jQuery's `.keyup()`):

{% codeblock lang:html %}
<div class="sign-up-section">
    <input type="email" ng-model="email" ng-keyup="signUpIfEnterPressed($event)">
    <button ng-click="signUp()">Sign up</button>
</div>
{% endcodeblock %}

{% codeblock lang:javascript %}
function signUpIfEnterPressed(event) {
    if (event.keyCode == 13) {
        signUp();
        return false;
    }
    return true;
}
{% endcodeblock %}

And of course, as you can see, `signUpIfEnterPressed()` is a function that has to check the event's keyCode and compare it to the value of enter (13) and then, and only then, call the `signUp()` function. Bleh. [Not good enough](https://www.youtube.com/watch?v=-0lzyUOjvFw)!

Turns out the people who wrote browsers already did most of the work related for us, we just have to reach out and use their work.

The trick is basically that the `<form>` element already is listening for these enter presses on all the inputs inside it. Pressing enter in an input in a form triggers the form's submit event to be fired.

That means that we can now cleanly remove `signUpIfEnterPressed()` and replace the code with:

{% codeblock lang:html %}
<form class="sign-up-section" ng-submit="signUp()">
    <input type="email" ng-model="email">
    <button type="submit">Sign up</button>
</form>
{% endcodeblock %}

And of course the solution is pretty much the same regardless of what JS libraries you're using (e.g. in jQuery you can do `$('.sign-up-section').submit(signUp)`), since this is purely done by the browsers.

Happy coding!

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Liked this? Be the first to get more (2-3 mails a month, no spam!)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline">
    <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
</form>
</div>
<!--End mc_embed_signup-->
