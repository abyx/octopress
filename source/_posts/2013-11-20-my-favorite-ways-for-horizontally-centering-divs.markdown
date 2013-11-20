---
layout: post
title: "My Favorite Ways for Horizontally Centering DIVs"
date: 2013-11-20 12:20
comments: true
categories: 
- programming
- css
- css3
- javascript
- html
- html5
---

Since there are so many ways of horizontally centering DIVs I thought I'd list my favorite ones and in which cases they're applicable.

### The obvious: text-align

In simple cases we all love this solution, setting `text-align: center` on the containing element. The problem is that `text-align` only works on `inline` elements, as in `span`s and `div`s that have their position set to `inline-block`. When you have this situation, this is the way to go.

### The margin

When the `div` you want to center has a fixed width set, you can use the magical that is automatic margins. Just set `margin: 0 auto` which tells the browser to set automatic margins horizontally on the element, thus centering it in its parent. 

### The when-push-comes-to-shove way

Then there's the case where the width is dynamic, and your elements are inline elements. In those cases I like the surefire way which I call "Dave Centering" (after [the friend](http://www.twitter.com/davidbrai) that taught me this).

This surefire solution works, but comes at a cost of adding some non-semantic elements. But being pragmatic, sometimes you gotta align those things.

Here's the final product, and below is the explanation of the details:

{% codeblock lang:html %}
<div class="parent">
    <div class="center-wrapper">
        <div class="center-content">This is centered in the parent</div>
    </div>
</div>
{% endcodeblock %}

{% codeblock lang:css %}
.parent {
    position: relative;
}

.parent .center-wrapper {
    position: absolute;
    left: 50%;
}

.parent .center-wrapper .center-content {
    position: relative;
    left: -50%;
}
{% endcodeblock %}

We first set the parent's position to `relative` so that positioning `center-wrapper` will be relative to it. `center-wrapper` is set to start right at the center of `parent`, which is close but no cigar. We want its center to be the same as the center of the `parent`, which is why for the final and inner element we set it to be offset relatively to the left by exactly half (50%) of its width.

### Center away!

I hope this saves you some time next time you're knee deep in the DOM. If you do a lot of frontend work you might be interested in my upcoming product: [Deflect.io](http://www.deflect.io).

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
