---
layout: post
title: "My Favorite Ways for Horizontally Centering DIVs"
date: 2013-11-20 12:20
comments: true
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

{% render_partial _posts/_partials/cta.markdown %}
