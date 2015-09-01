---
layout: post
title: "Generic HTTP Error Handling in AngularJS"
date: 2014-06-25 06:39:30 +0300
comments: true
---

Lately during development at one of our clients, [Ravello Systems](http://www.ravellosystems.com), we decided we wanted better HTTP error handling.

Basically, our perfect solution would have generic handlers for errors, and most calls in the code will not have to do any special work for handling errors. This means that things like authentication problems, server unavailability issues, etc. will be handled in one place — like adding a generic “something went wrong” modal.

But, we also wanted to be able to easily override these default handlers so that specific places can do things like silently ignore errors of unimportant calls (e.g. background requests that aren't user-facing), or display a special “try again later” context—aware message. 

This is a case study of how we currently implemented this. I'm sharing this for others that might need it and in hopes to hear of alternative ways to accomplish it.

## Our requirements

* The generic error handling should happen automatically, and can't be something a developer can forget to enable. That means things like adding a '.catch(genericHandler)' to every call is out of the question. 
* When the less common case happens, meaning someone isn't using the generic handler, it should be explicit. 
* It should work seamlessly with angular's $http service so that no matter if we aren't the ones making the calls ourselves, everything should still be handled. 
* It should allow us to easily handle grouped requests (i.e. requests that are handled by the caller in a single `$q.all()` call).

## How the end result looks

If you're making a call that just wants to use the generic handling code, it looks like this:

```javascript
$http.get('some/url').then(
    function(response) {
        // Stuff here
    }
);
```

Seems familiar? That's right, in most cases you don't need to change your code at all.

And in cases you do want to handle errors yourself:

```javascript
RequestsErrorHandler.specificallyHandled(
    function() {
        $q.all({foo: FooService.fetch(), bar: BarService.fetch()}).then(
            function() { /* Handle success */ },
            function() { /* Handle specific errors */ }
        );
    }
);
```

As you can see, it's pretty straightforward. And the use of a function (which we would essentially consider a block in languages like Ruby) allows us to group multiple requests in the same error handler.

## The implementation

Basically we tag every request that needs to be generically handled by adding a HTTP header to it. Then when requests fail due to errors an interceptor handles those that are tagged.

There are 3 parts:

**A decorator for $http** - This is the only way we came up with to tag requests inside our `specificallyHandled` function. Interceptors are run asynchronously and so can't tell whether the request was made inside our `specificallyHandled` block or not. This decorator simply wraps all the `$http` functions to add a specific header in cases they should be generically handled.

**Response interceptor** - This intercepts all the failed responses and handles them in a generic way - but only if they have the magical HTTP header we add in the `$http` decorator.

**RequestsErrorHandler** - A service that turns on or off the generic handling according to when it is called.

## The Code

Also available [here](https://gist.github.com/abyx/acd46b6513e2c58ed1d3).

{% gist acd46b6513e2c58ed1d3 angular-error-handling.js %}

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
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
    <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
