---
layout: post
title: "CSS Tip: Elements with Height 100% - Fixed Amount"
date: 2014-09-08 18:14:10 +0300
comments: true
---

A quick tip that I just find myself smiling whenever I use it successfully and feel dumb for not using it earlier:

Nowadays, it is very often that we want to layout an element to fill all of its parent's height (or width) except for a fixed amount. For example, a view with a top header and body that should fill the rest.

Up until recently I used to solve this by using flexbox, where browser support allowed me. 

But a few weeks ago a friend showed me this really really really *really* neat trick. I've known about CSS's `calc()` for a while, but I didn't know it could be used for this, and didn't know it had such a [wide support base](http://caniuse.com/#feat=calc):

{% codeblock lang:html %}
<div class="container">
    <header>My awesome header</header>

    <article>My even more awesome content</article>
</div>
{% endcodeblock %}

{% codeblock lang:css %}
.container {
    height: 100vh;
}

.container header {
    height: 50px;
}

.container article {
    height: calc(100% - 50px);
}
{% endcodeblock %}

You can see a simple example [here](http://jsfiddle.net/qvtq0s76/).

Yup. That's it! Calc away!

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
