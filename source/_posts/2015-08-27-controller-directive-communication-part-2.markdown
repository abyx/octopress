---
layout: post
title: "Controller-Directive Communication: Part 2"
date: 2015-08-27 17:50:44 +0300
comments: true
facebook:
    image: /images/posts_images/chat-ctrl-ui.png
---

In the [previous part](http://www.codelord.net/2015/08/21/controller-directive-communication-scroll-to-bottom/) we saw the simple case of a component, represented by a directive, that we use in our controllers in a  simple *set and forget* setup: the component just needs some input and can do its job using that alone.

In those cases, using the simple magic of data-binding is really all you need. But once you go around the block a couple of times you’ll eventually come upon the need to write a smarter component.

This part will focus on a **directive talking with its parent controller**. That means we have a directive that would like to tell its parent that something has happened. Note that in cases of directive-to-parent-directive communication the best practice might be [something else](http://www.codelord.net/2014/03/30/writing-more-maintainable-angular-dot-js-directives/).

# Directive to Controller Communication

Let’s say that we’re going to change the behavior of our chat app a bit. We don’t want the view to scroll to the newest message automatically now - we got plenty of users complaining about losing track of their place in conversations that way.

Instead, there’s no auto scrolling and we’ll want the chat list directive to let the controller know whenever the user scrolled to the bottom of the list, so the controller would know to *mark that chat as read* (e.g. in order to send a *read* receipt to the other party).

First, we add this function to our `ChatCtrl` (you can see the previous post's code [here](http://plnkr.co/edit/uOF1YCv52wjqfDnrpxro)):

```javascript
chat.readMessages = function(lastMessageRead) {
  ChatService.markAsRead(lastMessageRead);
};
```

We pass it to the directive by adding `read-messages="chat.readMessages(lastMessageRead)"` in our template.

And we change our directive like so:

```javascript
angular.module('chat').directive('chatMessageList', function() {
  return {
    scope: {
      list: '=chatMessageList',
      readMessages: '&' // <-- This is new!
    },
    template: '<div class="chat-list js-chat-list">' +
                '<div ng-repeat="message in list">' + 
                  '{% raw %}{{message.text}}{% endraw %}' + 
                '</div>' +
              '</div>',
    link: function(scope, element) {
      var $list = $(element).find('.js-chat-list');
      $list.on('scroll', function() {
        if (isScrolledToBottom($list)) {
          scope.$apply(function() {
            var lastMessage = scope.list[scope.list.length - 1];
            scope.readMessages({lastMessageRead: lastMessage); // <-- This too
          });
        }
      });
    }
  };
});
```

[Full Plunker Example](http://plnkr.co/edit/eU4KWbSnCUYJdt3Aq9Vc)

As you can see, in this scenario we needed the directive to *notify its parent controller* of something. That was pretty easy to achieve - we used the isolated scope to pass along a callback function `readMessages()` that the directive can call whenever it needs to.

There are a few alternatives, like using events, but I’m pretty certain this is the way most Angular developers would go with for a scenario like this. It’s easy, clear and readable.

## Passing Function Bindings

As you may have noticed, passing a function binding doesn’t look likely simply binding on some data. When we passed the chat list we specified it on the isolated scope as `list: '=chatMessageList'`. That equals sign means it’s a “simple” data binding - Angular keeps evaluating the expression that the parent controller passes the directive and if it notices a change it syncs it to the directive’s scope.

You can imagine that Angular just regularly checks the value of `chat.messages` in the parent controller and whenever the expression returns a different value (e.g. because we’ve put a different instance of a list there) it does something along the lines of `directiveScope.list = controllerScope.chat.messages` in order to bind them together.

**Functions are different**. With functions we don’t want Angular to regularly evaluate `readMessages(lastMessageRead)` - it doesn’t make sense. We want that function to run only on specific times, not on every digest cycle. Also, `lastMessageRead` doesn’t exist anywhere, it’s the name of an argument.

That’s why when we pass function bindings we have to use a different syntax when defining them in the scope, in this case `readMessages: '&'` - that ampersand is the way of saying this is a function binding.

Another detail is that we don’t call these functions like we define them. The original `readMessages()` function receives a single argument, so you might expect us to call it as `scope.readMessages(message)` - but that’s not how it’s done.

The syntax is a bit different, where we have to specify arguments to the functions inside a single object where the key names are the names of the arguments.

So `scope.readMessages(message)` turns into `scope.readMessages({lastMessageRead: message})`.

While you might find it odd the first couple of times, it’s really not that big of a deal and grows on you fast.

Function bindings are a very important building block in Angular in general and specifically in creating robust and reusable directives. Making it possible to create simple callbacks allows for a lot of flexibility.

### The Way Forward

In the next part we’ll see how function bindings can be used to allow the controller *to call* the directive and notify it of changes. Make sure to get it by subscribing to my mailing list below.

{% render_partial _posts/_partials/cta.markdown %}
