---
layout: post
title: "Using ng-change instead of $watch in Angular"
date: 2015-06-11 18:15:13 +0300
comments: true
---

In the olden days, before you used MVC frameworks such as Angular, you were probably used to doing stuff like this in jQuery:

```javascript
function showNameChanged() {
    // stuff...
}

$('input.show-name').change(showNameChanged);
```

This achieves the simple task of performing an operation whenever the user typed something inside an input, using JS change events.

In Angular, though, most people would consider this code the equivalent:

```html
<input type=text ng-model=show.name>
```

```javascript
$scope.$watch('show.name', showNameChanged);
```

Now, you might think I'm being nit picky here, but I'd usually rather write it like this:

```html
<input type=text ng-model=show.name ng-change="showNameChanged()">
```

## `ng-change`?

I'm always surprised that this directive is foreign for a lot of newcomers to Angular, and that `$watch` seems to be the tool everyone reach for first. `ng-change` is a simple directive that operates much like using jQuery to register a change event listener.

In my opinion, this is the "real" equivalent of the first code sample we saw.


## The differences

- Using `ng-change` would call our `showNameChanged()` function only on actual changes to the input *by the user*. Watches, as you might know, are called in other cases too: right when they're being defined the first time and on changes made to the value not by the user, e.g. programmatically.
- I'm a big believer in **expressing intent** when writing code (you do know [The 4 Rules of Simple Design](http://www.jbrains.ca/permalink/the-four-elements-of-simple-design), right?). If my intent is to only listen to changes by the user, and I don't expect the input to be changed programmatically, I would rather explicitly show that. Using `$watch` means whenever you read this code in the future you'll have to consider whether it's being triggered by something else, too.
- Another *plus for intent* for `ng-change` is that you can see from the template that this input is bound to something and how. Otherwise you'd need to start looking for the value in `ng-model` in the controller for usages. This way you can see right away who's listening for these changes.
- **Less code**. And less code == less things to debug. As you can see above we didn't need to add another line to the controller to listen for input changes.
- Using `ng-change` is a tiny bit more performant, since it uses one less watch expression. Since Angular knows it should only call the expression on change events it doesn't need to keep evaluating it on every digest cycle, as opposed to, well, *a watch*. Yes, just this one doesn't matter a lot, but across a big app these things stack up.

Of course, sometimes `$watch` is what you want. But sometimes - it ain't!

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
