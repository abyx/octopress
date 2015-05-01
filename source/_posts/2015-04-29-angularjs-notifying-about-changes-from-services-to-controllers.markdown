---
layout: post
title: "AngularJS: Notifying about changes from services to controllers"
date: 2015-04-29 18:00:51 +0300
comments: true
categories: 
- programming
- angularjs
---

Once you write enough Angular code you (hopefully) start pushing off as much logic as you can from your controllers to services (note: I'm saying "services" as in the general concept, but technically these are [usually factories](/2015/04/28/angularjs-whats-the-difference-between-factory-and-service/)).

Eventually you'll stumble upon the need to have your services notify controllers about changes. You have a lot of options: passing callbacks from controllers to services, using `$watch` on shared data, promises, events, etc. A lot of us end up wondering **what's the best practice in this case?**

In my opinion there's one way that's almost always better.

## Pub-Sub using "hidden" events

Angular's events mechanism (`$on`, `$emit`, `$broadcast`) is useful, but if you don't use it *just right* it can quickly spiral out of hand. Also, causing memory leaks is remarkably easy. *But*, with right incantation we can use it to our advantage in quite a robust way:

```javascript
angular.module('app').controller('TheCtrl', function($scope, NotifyingService) {
    // ... stuff ...
    NotifyingService.subscribe($scope, function somethingChanged() {
        // Handle notification
    });
});

angular.module('app').factory('NotifyingService', function($rootScope) {
    return {
        subscribe: function(scope, callback) {
            var handler = $rootScope.$on('notifying-service-event', callback);
            $scope.$on('$destroy', handler);
        },

        notify: function() {
            $rootScope.$emit('notifying-service-event');
        }
    };
});
```

## Win!

You can use this little snippet whenever you need to. It comes with these already bundled in:

* It takes care of cleaning up after itself properly by listening for the `$destroy` event on the controller's scope 
* It uses events only on the `$rootScope` using `$emit` which is more performant than using `$broadcast` ([further reading](http://toddmotto.com/all-about-angulars-emit-broadcast-on-publish-subscribing/) if you're interested)
* It encapsulates the actual use of the events mechanism inside the service, which, IMO, makes for cleaner interfaces

[Here's](http://jsfiddle.net/avivby/msjkv72r/) a little jsfiddle that shows this in action.

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Don't miss more Angular and frontend tips, subscribe! (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline"><!--
    --><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
