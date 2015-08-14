---
layout: post
title: "Angular: Watches, Watches Everywhere"
date: 2015-08-14 10:35:40 +0300
comments: true
facebook:
    image: /images/posts_images/watches_everywhere.png
---

You can only go so long in your Angular path before starting to learn about performance in Angular and some of its common problems.

You’ve probably heard about “lots of watches” being a problem. But what exactly is a “watch”? Is it just `$scope.$watch()`? *No!* Let’s dig in.

# What’s in a Watch

A “watch” is Angular’s mechanism for keeping track of a specific expression and acting when it changes. Every watch has the expression that it evaluates on every digest cycle to see if it has changed and also the handler function that gets called whenever the expression’s value has changed.

Not all watches were created equal, especially from a performance perspective. By defaults watches are shallow and so pretty quick. But if, for example, you use a deep watch on a huge list, don’t be surprised if it adds a lag to your app.

# The Common Types of Watches

{% img /images/posts_images/watches_everywhere.png %}

## The `$watch`

Yeah, the obvious case is the one I just mentioned. Whenever you explicitly use `$scope.$watch('expr', function() {})` you are adding a watch for the `expr` expression.

## Templates Binding with `{% raw %}{{ foo }}{% endraw %}`

Whenever you use double curly brackets in a template in order to display a value you’ve set in your scope you’re basically adding a watch. This watch will keep track of the value and update the template’s DOM whenever the value changes (after all there’s no magic here - the browser doesn’t know how to bind your expression and the DOM which means Angular has to update things, it’s just hiding those details from you).

While we’re at it, let me add on a side note that just adding things to your `$scope` doesn’t add a watch. It’s only *binding* to it in some way that adds it.

## Isolated Scope Bindings

When you pass to a directive with an isolated scope something on its scope, that too creates a watch.

For example, if you have a directive whose scope definition looks like this `scope: {foo: '='}` then Angular will make sure to keep it in sync - if the value changes in your parent scope it will also changed in the directive’s scope. This is achieved by creating a watch for `foo` that makes sure to update it inside the directive’s scope whenever the value changes in the parent scope.

## Attributes in Templates

When you have Angular expressions used inside attributes in your templates, those are usually creating watches too.

Take `ng-show` and `ng-hide` as an example you’re probably familiar with. These directives receive an expression and do something depending on whether it evaluates to true or false. This act of tracking the expression’s value is really *watching* stuff over.

## Filters

This is kind of a private case of the previous point, but it’s worth pointing out. Filters keep being evaluated and updated because on every digest, just like any other watch. But they are usually heavier than regular watches and do more complex things, so keep that in mind.

## And, Of Course, Code

Along these watches, which are relatively straightforward to find in your code, you should also keep in mind that more watches might be used by the code of other components you may  be using.

As an example, our beloved `ng-repeat` directive is using watches (specifically a `$watchCollection`) in order to update the list it received whenever changes happen. So even if you don’t *see* an explicit watch in your template, it doesn’t mean that it’s not there.

# Watch Out

So, to sum up this post, as you can see watches are pretty much everywhere in Angular land. Next time you’re looking at the number of watches using [ng-stats](https://github.com/kentcdodds/ng-stats) you should be more equipped to understand how that number came to be.

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Don't miss the next Angular and frontend tip, subscribe! (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline"><!--
    --><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
