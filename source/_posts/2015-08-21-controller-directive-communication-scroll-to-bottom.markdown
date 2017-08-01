---
layout: post
title: "Controller-Directive Communication: Scroll to Bottom"
date: 2015-08-21 14:36:15 +0300
comments: true
facebook:
    image: /images/posts_images/chat-ctrl-ui.png
---

A common question in Angular is *how should two components talk to each other*. The flexibility of Angular means you have a lot of choices to make, and there’s little guidance.

The way you’d have two sibling controllers communicate is different from how a controller will talk to its parent controller, how a directive will talk to its parent directive and how controllers and directives talk with one another.

In this part we’ll go over a common use-case, *scroll to bottom*, in order to show the straightforward way of communicating between controllers and directives: **Set and forget**.

The next 2 parts will be more in-depth about the communication itself in the scenarios of **directive to controller communication** and **controller to directive communication**.

# Set and Forget + Scroll to Bottom Example

Say we have a simple chat client controller that is made of a list of messages and at the bottom an input to enter new messages (basically any text/messaging app you’ve used).

We’d like the message list to scroll to the bottom whenever a new message is added, either by the user or when a new message is received from the server.

Of course DOM manipulation shouldn’t happen in the controller, so we’ll whip up a nice little directive for it. Our screen should look roughly like this:

{% img /images/posts_images/chat-ctrl-ui.png %}

And our simple controller code:

```javascript
angular.module('chat').controller('ChatCtrl', function(ChatService) {
  var chat = this;
  chat.addMessage = addMessage;
  activate();

  function activate() {
    ChatService.getMessages().then(function(messages) {
      chat.messages = messages;
    });
  }

  function addMessage(message) {
    chat.messages.push({text: message});
    ChatService.addMessage({text: message});
  }
});
```
    
```html
<div ng-controller="ChatCtrl as chat">
  <div chat-message-list="chat.messages"></div>
  <form ng-submit="chat.addMessage(chat.newMessage)">
    <input ng-model="chat.newMessage">
    <button type="submit">Send</button>
  </form>
</div>
```

We have a very basic `ChatCtrl` that uses a chat list directive. That directive is being passed our list of messages, and it is responsible for displaying that list on screen.

Here’s how we’d implement that directive:

```javascript
angular.module('chat').directive('chatMessageList', function() {
  return {
    scope: {
      list: '=chatMessageList'
    },

    template: '<div class="js-chat-list">' +
                '<div ng-repeat="message in list">' + 
                  '{% raw %}{{message.text}}{% endraw %}' + 
                '</div>' +
              '</div>',

    link: function(scope, element) {
      scope.$watchCollection('list', function() {
        var $list = $(element).find('.js-chat-list');
        var scrollHeight = $list.prop('scrollHeight');
        $list.animate({scrollTop: scrollHeight}, 500);    
      });
    }
  };
});
```

[Full Plunker Example](http://plnkr.co/edit/uOF1YCv52wjqfDnrpxro)

## The Actual Communication

As you can see our directive has an isolated scope: in the directive definition we provide a value for `scope` and define the different attributes of the scope and how they should be bound.

Using an isolated scope makes it really easy to pass specific “arguments” to our scope and having those arguments be easily bound between the controller and the directive.

Also, isolation makes for more readable and maintainable directives - you immediately see what they expect to receive as inputs in their scope definitions.

This basic use of scopes is a major building block in big Angular apps. It allows us to use directives a bit like functions where we set their input and just have it go off and do some work (e.g. “set and forget”, see what I did there?)

## Scroll to Bottom Logic

This is a great use case for using `$watchCollection` instead of `$watch`.

Our directive wants to scroll to the bottom whenever a new message is added to the list of messages.

A simple `$watch('list', func)` would not work, because it’s a shallow watch and our list *instance* doesn’t change - we only add elements to it.

We could use a deep watch (i.e. `$watch('list', func, true)` - notice that last `true`) but that would be wasteful since our messages objects don’t really change - we just add things to the list. That means there’s no real reason to have Angular scan each element for changes - messages themselves are immutable.

`$watchCollection` is the perfect tool since it just watches the list for additions and removals and doesn’t have a deep watch for every element in it. This, as Goldilocks would say, is **“just right”**.

### The Way Forward

The next parts will be more interesting in my opinion - how should your controller notify your directive of changes? How should the directive notify the controller? Sign up to my newsletter below to get the updates (no spam guarantee or I will spend the rest of my career only doing web in Dojo).

{% render_partial _posts/_partials/book_cta.markdown %}
