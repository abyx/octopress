---
layout: post
title: "CSS Tip: Overflowing with Text"
date: 2013-08-23 13:14
comments: true
categories: 
- programming
- css
- css3
---

Simply making sure some text that might be long doesn't break our layout is trivial, but I've seen several CSS newbies have trouble with this or simply miss it altogether just to have QA (or worse, a user) file a bug about it.

The naive approach is usually just adding a `width` to the element and assume the problem is solved. But that is not so, my friends:

<div style="width: 10em; border: 1px solid #ccc; padding: 1em;"> 
Some longer than expected text
</div>
<br/>

{% codeblock lang:html %}
<div style="width: 10em;"> 
    Some longer than expected text
</div>
{% endcodeblock %}


As we can see, the text is causing the element's height to increase. Assuming that's going to work with our layout, you might assume we're all ready to go. But are we, really?

<div style="width: 10em; border: 1px solid #ccc; padding: 1em;"> 
Some longer than expected text with antidisestablishmentarianism
</div>
<br/>

{% codeblock lang:html %}
<div style="width: 10em;"> 
    Some longer than expected text with antidisestablishmentarianism
</div>
{% endcodeblock %}


Ah, it's leaking there. We can of course add `overflow-x: hidden` but what if we want all the content to be displayed? That's, my friends, a job for `word-wrap: break-word`:

<div style="width: 10em; border: 1px solid #ccc; padding: 1em; word-wrap: break-word;"> 
Some longer than expected text with antidisestablishmentarianism
</div>
<br/>

{% codeblock lang:html %}
<div style="width: 10em; word-wrap: break-word;"> 
    Some longer than expected text with antidisestablishmentarianism
</div>
{% endcodeblock %}


OK, that seems to work (note: you can make the text [hyphenated](http://caniuse.com/#feat=css-hyphens) on some browsers). Now, stepping back a bit, what if we can't have it take multiple lines?
We can limit that too by adding a `height` to the element:

<div style="width: 10em; height: 1.2em; border: 1px solid #ccc; padding: 1em; margin-bottom: 2em"> 
Some longer than expected text
</div>
<br/>

{% codeblock lang:html %}
<div style="width: 10em; height: 1.2em;"> 
    Some longer than expected text
</div>
{% endcodeblock %}

Bummer. Oh, I know! Let's add `overflow-y: hidden`:

<div style="width: 10em; height: 1.2em; border: 1px solid #ccc; padding: 1em; overflow-y: hidden"> 
Some longer than expected text
</div>

OK, this seems to do the trick. Or does it?

<div style="width: 10em; height: 1.2em; border: 1px solid #ccc; padding: 1em; overflow-y: hidden"> 
Now a long woooooooooooooooooooooooooooooooord
</div>
<br/>

{% codeblock lang:html %}
<div style="width: 10em; height: 1.2em; overflow-y: hidden;"> 
    Now a long woooooooooooooooooooooooooooooooord
</div>
{% endcodeblock %}

Humph. A horizontal scroller even though the displayed contents aren't that long. Guess we'll have to go with `overflow: hidden` altogether then:

<div style="width: 10em; height: 1.2em; border: 1px solid #ccc; padding: 1em; overflow: hidden"> 
Now a long woooooooooooooooooooooooooooooooord
</div>
<br/>
{% codeblock lang:html %}
<div style="width: 10em; height: 1.2em; overflow: hidden;"> 
    Now a long woooooooooooooooooooooooooooooooord
</div>
{% endcodeblock %}

OK, I think I'll stop pulling your leg. I'll just add that I like adding an ellipsis for making it clear that some text was trimmed with `text-overflow: ellipsis`. Problem is that `text-overflow` only works on single-line content, so we have to make sure our element's text doesn't wrap by also adding `white-space: nowrap`:

<div style="width: 10em; height: 1.2em; border: 1px solid #ccc; padding: 1em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"> 
Now a long woooooooooooooooooooooooooooooooord
</div>
<br>

{% codeblock lang:html %}
<div style="width: 10em; height: 1.2em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"> 
Now a long woooooooooooooooooooooooooooooooord
</div>
{% endcodeblock %}

Overflow away :)

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
