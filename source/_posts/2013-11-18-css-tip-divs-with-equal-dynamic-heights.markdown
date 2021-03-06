---
layout: post
title: "CSS Tip: DIVs with Equal Dynamic Heights"
date: 2013-11-18 18:19
comments: true
---

Continuing my series of short CSS tips I'd like to share a trick I was taught by [a friend](http://twitter.com/davidbrai) a few years ago when we were working on some new layout for our web app.

One of the most annoying problems with CSS is that the height property is pretty limited in strength when it comes to setting it dynamically. I'd like to talk about a relatively *simple problem*: a 2 column layout where we don't know how high each colum will be and we want both columns to have the same maximal height.

Since we don't know the columns' heights, we can't set a fixed height on their parent. Also setting `height: 100%` or something like that on the columns won't work: we are counting on them to spread to the maximum height and thus make their parent taller.

### Cutting to the chase

Though there are [more ways](http://alistapart.com/article/multicolumnlayouts) of doing this my favorite is relying on the magic properties of tables, or, more specifically, table-like elements.

The whole trick is making the two columns have the properties of two neighboring table cells, which always have the same height. Our HTML would look like this:

{% codeblock lang:html %}
<div class="layout">
    <div class="columns-container">
        <div class="column"></div>
        <div class="column"></div>
    </div>
</div>
{% endcodeblock %}

And the needed CSS is this:

{% codeblock lang:css %}
.layout {
    display: table;
}

.layout .columns-container {
    display: table-row;
}

.layout .columns-container .column {
    display: table-cell;
}
{% endcodeblock %}

That's about it! And the nice part is that it's actually not limited to 2 columns, you can have as many as you want ;)

A word of warning: some of you might try and see that it seems like this works withjust setting `display: table-cell` on the columns and without the rest of the styles. While that works on some browsers, from my personal experience that's not compatible on all browsers and in general `table-cell` display is not supposed to be used outside the scope of a full "table simulating" structure.

I hope you learned something new. Happy coding!

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
