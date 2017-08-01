---
layout: post
title: "AngularJS 1.3 Taste: Async Validators"
date: 2014-11-02 16:51:45 +0200
comments: true
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

{% render_partial _posts/_partials/book_cta.markdown %}
