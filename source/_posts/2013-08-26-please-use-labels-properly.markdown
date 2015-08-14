---
layout: post
title: "Please Use Labels Properly"
date: 2013-08-26 23:08
comments: true
---

Another issue that I frequently see junior web developers have trouble with is proper use of the `<label>` element.

First, let's have a look at a lousy, label-less control:

{% codeblock lang:html %}
<input type="checkbox"> This is my sucky control
{% endcodeblock %}

<input type="checkbox"> This is my sucky control

To check that box one has to carefully aim her cursor to a tiny square with ninja-like precision. Doable, but no fun.

Many think that labels are just a semantic element for writing text next to controls and so just don't use them. After all, if we wrap the above text so it becomes `<label>This is my sucky control</label>` nothing changes, so why bother?

## Enter: labels

Labels are a magic way of getting the browser to do work for you. Connecting a label with an input field has some magic effects:

{% codeblock lang:html %}
<input type="checkbox" id="check">
<label for="check">This is my better control</label>
{% endcodeblock %}

<input type="checkbox" id="check"><label for="check">This is my better control</label>

All of a sudden we can also click on the text and the checkbox will change value! Life have just become that easier. Labels are also used for different [accessibility measures](http://webdesign.about.com/od/forms/a/aa052206.htm).

## Awesomer labeling

There's another syntax for associating labels with inputs which I prefer. The problem with the above syntax is that it requires us to have a specific ID for each input element to then put in the label's `for` attribute. This is usually messy and even requires extra coding if, for example, you're generating forms on the fly.

Lucky for us, if a label contains a single input element it is automatically associated with it, meaning we can now write:

{% codeblock lang:html %}
<label>
    <input type="checkbox"> This is my awesome control
</label>
{% endcodeblock %}

<label><input type="checkbox"> This is my awesome control</label>

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
