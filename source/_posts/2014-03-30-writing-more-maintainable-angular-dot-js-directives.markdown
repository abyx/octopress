---
layout: post
title: "Writing More Maintainable Angular.js Directives"
date: 2014-03-30 18:55
comments: true
categories: 
- Programming
- angular
- angularjs
- web
- javascript
---

Directives are, essentially, the most powerful building blocks we have in Angular, yet for beginners they are incredibly easy to get messed up.

Here are some guidelines that I'm pleased with, and that can help new comers. I would love any feedback from fellow coders!

**My assumptions:** The main problems I have in maintaining "magical" code are lack of explicitness and traceability. Explicitness means I would rather write a bit more code in order for it to be clearer what my intention was and what exactly I'm trying to use. Traceability is making an effort that from any piece of code it would be clear what it depends on or what depends on it. Even with thoroughly unit-tested code I believe the following extra steps are necessary.

## Favor isolated-scope directives

I pretty quickly realized that what I should use about 90% of the time are isolated directives. These are directives that have a clean slate as a scope. Their scope is clear except for those bindings which are explicitly made in the directive's definition:

{% codeblock lang:javascript %}
app.directive('myDirective', function() {
    return {
        scope: {
            // The only properties visible in our scope from the parent scope:
            foo: '='
        },
        // ...
    };
});
{% endcodeblock %}

The major win here is that never again will I be stuck with opening a directive and sifting through the different properties referenced, trying to understand what, if any, the directive is using from its parent. This means I can more safely and quickly refactor, change and delete code.

## Explicitly passing dependencies with require

Let's start with an example. Here is the screen for editing mailboxes on the iPhone:

{% img /images/posts_images/mailboxes_edit.jpg %}

This might have been written in Angular like so:

{% codeblock lang:html %}
<div mailboxes>
  <div ng-repeat="mailbox in mailboxes" mailbox-line edit-context="editContext">
    <div mailbox-edit mailbox="mailbox" edit-context="editContext"></div>
    <div mailbox-description mailbox="mailbox"></div>
  </div>
</div>
{% endcodeblock %}

In the above example `editContext` is wired through the `mailboxLine` directive even though it doesn't care about it at all, just so it can pass it along to `mailboxEdit`. Once these extra wirings start getting popular in your app, sometimes across several levels deep just to pass some object, you won't like it. Take my word for it.

What are you to do?

### Requires to the rescue!

Angular's directives have an amazing ability, though not as widely spread as it should be. A directive can require that other directives will be present either on the element it is placed, or in one of its parents:

{% codeblock lang:javascript %}
app.directive('mailboxEdit', function() {
    return {
        scope: {
            mailbox: '='
        },
        // We make sure the "mailboxes" directive is somewhere above us
        require: '^mailboxes',
        // "mailboxesCtrl" is the "mailboxes" directive's controller
        link: function(scope, element, attrs, mailboxesCtrl) {
            // Now we can use mailboxesCtrl.editContext
        }
    };
});

app.directive('mailboxes', function() {
    return {
        // Create a directive controller and expose the edit context in it
        controller: function($scope) {
            // Note we assign this to "this" and not "$scope"
            this.editContext = new EditContext();
        }
    };
});
{% endcodeblock %}

As you can see above, using `require` means our directive can get a parent's controller and reference it (`mailboxesCtrl`), as specified in the Angular docs [here](http://docs.angularjs.org/guide/directive#creating-directives-that-communicate). The simpler HTML would now be:

{% codeblock lang:html %}
<div mailboxes>
  <div ng-repeat="mailbox in mailboxes" mailbox-line>
    <div mailbox-edit mailbox="mailbox"></div>
    <div mailbox-description mailbox="mailbox"></div>
  </div>
</div>
{% endcodeblock %}

### This is awesome in so many ways:

* No annoying wiring of things all the way down
* `require` will throw an exception if the requirement fails, making it impossible to wire wrong
* The nested directive explicitly tells us what it depends upon
* The parent directive explicitly defines an exposed API

I find this way makes maintaining a large system a lot easier and more straightforward.

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Liked this? Sign up to my newsletter to get more frontend content (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline">
    <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
</form>
</div>
<!--End mc_embed_signup-->
