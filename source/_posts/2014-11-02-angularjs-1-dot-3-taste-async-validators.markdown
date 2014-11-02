---
layout: post
title: "AngularJS 1.3 Taste: Async Validators"
date: 2014-11-02 16:51:45 +0200
comments: true
categories: 
- Programming
- angular
- angularjs
---

AngularJS 1.3 is finally released and brought a lot of [very cool features](http://angularjs.blogspot.com/2014/10/angularjs-130-superluminal-nudge.html). I decided to focus on one that, when you need it, will save you lots of time and hassle.

Prior to 1.3 custom validators were half-baked in Angular. There was no real concept of adding a validator to a field even though forms did have validity states etc. Add to that the case of having validators that take a while to run and you're in a real jam.

Let's look at an example. Every decent website sign up form that has a username field also has a validator that checks whether that username is available even before you try to submit the form. Here's how awesome it would be to do that with the new 1.3 API:

{% codeblock lang:html %}
<form name="myForm" ng-submit="submit()">
    <label>
        Username:
        <input type="text" ng-model="signup.username" required username-validator>
    </label>

    <label>
        Password:
        <input type="password" ng-model="signup.password" required>
    </label>

    <button type="submit" ng-disabled="myForm.$invalid">Sign Up</button>
</form>
{% endcodeblock %}

You'll notice that I added the `username-validator` directive to the username field. Now let's see how that's implemented:

{% codeblock lang:javascript %}
angular.module('myModule').directive('usernameValidator', function($http, $q) {
    return {
        require: 'ngModel',
        link: function(scope, element, attrs, ngModel) {
            ngModel.$asyncValidators.username = function(modelValue, viewValue) {
                return $http.post('/username-check', {username: viewValue}).then(
                    function(response) {
                        if (!response.data.validUsername) {
                            return $q.reject(response.data.errorMessage);
                        }
                        return true;
                    }
                );
            };
        }
    };
});
{% endcodeblock %}

Basically it's just a matter of adding an asynchronous validator on that field. That validator simply performs an HTTP request and according to the response sets the field as valid or not. The mechanism that enables this is plain promises: our validator returns a promise and the field's validity will remain in "pending" state until the promise is resolved. If it resolves with an error, the field will be marked invalid, otherwise Angular assumes all is well.

But, a caveat we have left in the example above is that it let's the user attempt to submit the form while we are still waiting for some pending validations to return. That's because the submit button is only disabled while the form is invalid (`myForm.$invalid`). While there are pending validations and no invalid fields the form isn't invalid (yet) and so the button isn't disabled. The solution is to disable the button also while the form is pending:

{% codeblock lang:html %}
<button type="submit" ng-disabled="myForm.$invalid || myForm.$pending">Sign Up</button>
{% endcodeblock %}

And that's all there's to it. You can see a live example (with `$timeout` in order to fake the async operation) on [this example here](http://plnkr.co/edit/s4jJAOqehBkFUC9osMsy?p=preview) (I actually added in there an example fo rusing the new [`ngMessages`](https://docs.angularjs.org/api/ngMessages) directive).

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
    <label for="mce-EMAIL">Liked this? Sign up to my newsletter to get more frontend content (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
    <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
