---
layout: post
title: "Improving ng-repeat Performance with “track by”"
date: 2014-04-15 20:31
comments: true
---

Probably one of the very first things you learned doing with Angular was how to use `ngRepeat`. It's so easy and simple, you gotta love it. Here's an example:

{% codeblock lang:html %}
<ul class="tasks">
    <li ng-repeat="task in tasks" ng-class="{done: task.done}">
        {% raw %}{{task.id}}: {{task.title}}{% endraw %}
    </li>
</ul>
{% endcodeblock %}

### The problem

Now say you have a button above that list to refresh it.

The obvious implementation for this refresh would be something along these lines in your controller:

{% codeblock lang:javascript %}
$scope.tasks = newTasksFromTheServer;
{% endcodeblock %}

This is a trivial piece of code, but it would cause `ngRepeat` to remove all `li` elements of existing tasks and create them again, which might be expensive (e.g. we have a lot of them or each `li`'s template is complex). That means a lot of DOM operations. That would make us sad pandas.

In something of a more real-world use case, where instead of our simple example template each task is its own directive, this might be very costly. A task directive that calculates a view model with even relatively simple operations like formatting dates is enough to make the refresh feel laggy. There's a link to a fiddle with an example at the bottom of the post.

Why would Angular do this? Behind the scenes `ngRepeat` adds a `$$hashKey` property to each task to keep track of it. If you replace the original tasks with new tasks objects from the server, even if those are in fact *totally identical* to your original tasks, they won't have the `$$hashKey` property and so `ngRepeat` won't know they represent the same elements.

### The annoying solution

The first solution that comes to mind to most developers is to not replace the whole `$scope.tasks` list, but update **in place** all the existing tasks objects with the data you received from the server. That would work because it means `$$hashKey` property would be left intact in the original objects.

But that's not fun, is it? I hate surgically tinkering with objects, as it is error prone, less readable and a pain to maintain.

{% img /images/posts_images/not_good_enough.gif Not good enough! %}


### `track by` to the rescue

In Angular 1.2 a new addition was made to the syntax of `ngRepeat`: the amazingly awesome `track by` clause. It allows you to specify your own key for `ngRepeat` to identify objects by, instead of just generating unique IDs.

This means that you can change the above to be `ng-repeat="task in tasks track by task.id"` and since the ID would be the same in both your original tasks and the updated ones from the server - `ngRepeat` will know not to recreate the DOM elements and reuse them. **Boom**.

To get a better feel of the difference this makes, see [this fiddle](http://jsfiddle.net/SeKk7/). By default it doesn't use `track by` and the date formatting it does is enough to make clicking "Refresh" feel noticeably slow on my computer. Try adding the `track by` and see how it magically becomes instant, because the `task` directive's link function is no longer called on each refresh.

It's really that easy to get a quick little boost in performance that also saves you writing annoying code.

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
