---
layout: post
title: "CSS Tip: Stop Your Buttons from Flickering"
date: 2013-11-12 16:05
comments: true
---

With the rise of flat design and it taking over the whole web, I've got this pet peeve with buttons that "wiggle" on hover. It's becoming more and more common to have buttons where in one state they are flat and just have a nice background color, and in the hover state the background color changes and a border is added. Let's have a look:

<div>
<style>
    .wiggle-button {
        height: 3em;
        width: 20em;
        background: #007aff;
        border-radius: 5px;
        border: none;
        color: white;
        box-sizing: content-box;
        -webkit-box-sizing: content-box;
        -moz-box-sizing: content-box;
    }

    .wiggle-button:hover {
        background: white;
        color: #007aff;
        border: 1px solid #007aff;
    }

    .wiggle-button.fixed-button {
        box-sizing: border-box;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
    }
</style>
</div>
<button class="wiggle-button">Hover to see me wiggle!</button>

The CSS looks like this:

{% codeblock lang:css %}
.wiggle-button {
    height: 3em;
    width: 20em;
    background: #007aff;
    border-radius: 5px;
    color: white;
}

.wiggle-button:hover {
    background: white;
    color: #007aff;
    border: 1px solid #007aff;
}
{% endcodeblock %}

As you can see, hovering over the button causes it to wiggle, and the rest of the content below it to move. [Not good enough](https://www.youtube.com/watch?v=-0lzyUOjvFw).

The problem is caused because the button has no border on the regular state and a border is added on hover. The new border adds to the actual height and width of the button, making it wiggle and push all elements after it.[^1]

[^1]: See [here](http://www.rainbodesign.com/pub/css/css-element-size.html) for calculating a CSS element's size

I've seen CSS newbies solve this by adding a border with the same color to the normal state, which would work, but isn't to my taste.

Whenever you want to have an element's size not change due to inner changes such as borders, paddings, etc. you're actually thinking about `box-sizing: border-box`.

[^2]: Some browsers need a vendor prefix, see full information [here](http://www.paulirish.com/2012/box-sizing-border-box-ftw/)

So, just adding `box-sizing: border-box` to our `.wiggle-button` class gives us this new sexy button:

<button class="wiggle-button fixed-button">Hover to see me be awesome!</button>

This is a cleaner solution, in my opinion, since it makes sure the border doesn't cause size changes to the button. This magical attribute solves our problems in this case just like that, and is supported on all latest browsers[^2].

I hope you learned something new. Happy coding!

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Liked this? Be the first to get more web development tips (2-3 mails a month, no spam!)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline">
    <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
</form>
</div>
<!--End mc_embed_signup-->
