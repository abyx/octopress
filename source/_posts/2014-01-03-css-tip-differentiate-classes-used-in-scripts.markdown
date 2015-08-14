---
layout: post
title: "CSS Tip: Differentiate Classes Used in Scripts"
date: 2014-01-03 17:23
comments: true
---

This one is short but so good that I find myself having to reintroduce it in every project I work on and to most developers I work with.

We all know that though CSS is for styling, sometimes we have to use a class to get to an element from JavaScript, e.g. `$('.save-button')`.

The Right Way&trade; to do this is by prefixing those classes with `js-` to differentiate them from "real" classes. Note that this does mean I sometimes will have an element with 2 classes, e.g. `save-button` and `js-save-button`.

#### Why?

  * Never fear removing a CSS classes because it might break some script that's using it
  * Never fear renaming or moving a class when you change scripts because it might break the styles

Happy coding!

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Liked this? Be the first to get more web development tips (2-3 mails a month, no spam!)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline">
    <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
</form>
</div>
<!--End mc_embed_signup-->
