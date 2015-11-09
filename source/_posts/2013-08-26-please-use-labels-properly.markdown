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

{% render_partial _posts/_partials/cta.markdown %}
