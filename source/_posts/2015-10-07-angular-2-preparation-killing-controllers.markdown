---
layout: post
title: "Angular 2 Preparation: Killing Controllers"
date: 2015-10-07 18:00:54 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
---

Controllers are *dying*. The [migration path](http://www.codelord.net/2015/09/10/angular-2-migration-path-what-we-know/) doesn’t even make a reference of them. Once controllers were a cornerstone of Angular. Now we’re all trying to sweep them under the carpet.

The question that bothers me is what can you do today to make your life easier once Angular 2 is out. Last time I discussed a [first step](http://www.codelord.net/2015/09/30/angular-2-preparation-controller-code-smells/) - making controllers smaller and cleaner.

But I’ve been toying with **not writinga controllers at all**. I’ve seen several people already do this and my experience so far is nice. We’re all still learning this together. I figured I’d share how I made it work for me.

This preparation step will, hopefully, make your transition to Angular 2 easier and smoother. Especially once `ng-upgrade` is out and you’ll be able to use all your code units.

# The mechanism: component directives

We achieve controller annihilation by using directives everywhere you’d use a controller. That means your app’s code is now either in a directive or in a factory (service).

It’s important to make a mind shift. Stop thinking about directives as a building block for reusable code. It’s a building block, *period*.

Isolated directives are self-contained components that I find easy to reason about and [maintain](http://www.codelord.net/2014/03/30/writing-more-maintainable-angular-dot-js-directives/).

I prefer to use directives with a `controller` function and not use `link`. That’s mostly because `controller` means I almost never need to inject `$scope`. Also, because using controllers means I can then `require` them in child directives.

# A basic example: controller turned directive

Here’s a *very basic* controller that we’ll turn into a directive ([plunk](http://plnkr.co/edit/7I0GhjSywmdcrBy9yHGU?p=preview)):

```javascript
module.controller('MessagesCtrl', function() {
  var self = this;
  self.list = [
    {text: 'Hello, World!'}
  ];
  self.clear = function() {
    self.list = [];
  };
});
```

And its template is:

{% codeblock lang:javascript %}
<div ng-controller="MessagesCtrl as messages">
  <ul>
    <li ng-repeat="message in messages.list">
      {% raw %}{{message.text}}{% endraw %}
    </li>
  </ul>
  <button ng-click="messages.clear()">Clear</button>
</div>
{% endcodeblock %}

(Did I mention it was basic?)

Here’s the *after* picture ([plunk](http://plnkr.co/edit/R8crwn8DHOZVkwB34bmZ?p=preview)):

```javascript
module.directive('messages', function() {
  function MessagesCtrl() {
    var self = this;
    self.list = [
      {text: 'Hello, World!'}
    ];
    self.clear = function() {
      self.list = [];
    };
  }
  return {
    templateUrl: '', // Same as for controller
    scope: {}, // Isolate == Awesome
    controller: MessagesCtrl,
    controllerAs: 'messages',
    bindToController: true
  };
});
```

What have we got here?

- Notice that the template didn’t need any changes.
- Same goes for the actual controller function itself.
- We made sure to define the directive with `controller:`, `controllerAs:`, `bindToController:` and isolated `scope:`. Just the right incantation.

This resulted in a little more boilerplate but we got rid of the controller. Along the way we also earned an isolated scope, win! And, we have a true component. You can take a look at this .js file and you see all you need to know - the inputs, the template, the controller.

# Interesting notes and caveats

**Do DOM manipulation in the directive controller**: This might feel wrong. You’ve heard the mantra “Don’t do DOM manipulation in controllers” a thousand times. But this *isn’t* a controller anymore. It’s a component. Angular even let’s you inject `$element` inside these directives. Take use of it!

**Sometimes you still need `link` functions**: The controller function executes before the element has rendered. If, for example, you want to register an event handler on some child element you’ll have to do it in the `link` function. Another is when you want to use `require` and get access to that controller.

**Defining routes**: You no longer need to supply a controller in your ui-router or ng-route configuration. Just pass a simple template such as `<messages></messages>`.

**ui-router resolves are harder**: I’ve long stopped using resolve because it has so many [pitfalls](http://www.codelord.net/2015/06/02/angularjs-pitfalls-using-ui-routers-resolve/). But, you can get access to `resolve`d stuff via `$state.$current.locals` in your directives. I’ll note that ng-route’s resolve works similarly with `$route.current.locals`.

**Some widgets love controllers**: If you’re using widgets such as ui-bootstrap’s modals you will see they love controllers. It’s still possible to use them without controllers. The above workaround works.

# The way forward

As I said, I’m still figuring this out along with you. But so far I’ve found this to be simpler. For a long time I’ve avoided creating controllers except for routing endpoints. Now I just don’t use that as well. Having everything be a directive means less mental overload and a simpler file structure.

If you’ve been toying with this too I’d love to hear your thoughts and techniques.

<!-- Begin MailChimp Signup Form -->
<div id="mc_embed_signup" class="cta">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Learn how to prepare for 2.0 and write maintainble Angular!</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline"><!--
    --><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
    <div class="promise">~3 mails a month, unsubscribe anytime, no spam, promise!</div>
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
