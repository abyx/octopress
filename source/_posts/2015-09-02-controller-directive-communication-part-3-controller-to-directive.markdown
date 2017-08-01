---
layout: post
title: "Controller-Directive Communication Part 3: Controller to Directive"
date: 2015-09-02 17:34:18 +0300
comments: true
facebook:
    image: /images/posts_images/chat-ctrl-ui.png
---

This is the last part of my controller and directive communication series. In the [first part](http://www.codelord.net/2015/08/21/controller-directive-communication-scroll-to-bottom/) we looked at setting up simple bindings. [The second](http://www.codelord.net/2015/08/27/controller-directive-communication-part-2/) part showed the use of bound functions to let the directive send messages up to the controller. 

This part focuses on the remaining combination: having the controller send messages down to the directive.

# Controller to Directive Communication

Continuing with the chat app example from the previous parts, let’s now assume that our controller sometimes wants to tell the chat list to scroll to the bottom (e.g. because the user marked the chat as read from another device).

This means that now our controller needs to somehow *tell the directive* to do something. We want the directive to expose something to us. Directives can receive functions via bindings, but there’s no straightforward way for them to create new bound functions and expose them up the chain.

## The Suboptimal Options

There are a few possible techniques that are somewhat popular/recommended at some places. I’m listing them here mainly to say why I *dislike* them - scroll down to my preferred solution if you’re in a hurry.

### Events? I’d Rather Not

A lot of developers would just shrug and use events (Using `$scope.$broadcast`, `$scope.$on` and `$scope.$emit`). 

While this will work, I find events to be catalysts for code quality deterioration.

Using events means you have to *dig* through a component’s code to find which events it is firing or watching for. There’s no easy-to-find API to understand the dependencies between components.

### Services? Not really

Services are the go-to for communication between entities in many Angular scenarios, and they rightly are. But this scenario feels different.

This isn’t a a concern that’s relevant across the whole app. It’s internal communication between two instances on screen, that would feel wrong for me to put in a service.

I prefer to use services for things that are global - cross cutting concerns that are synced across the app, and not a component and its inner component trying to nudge a pixel.

### Scope Mangling

I don’t really have a name for this one, but I’ve seen it in the wild. It’s an abuse of binding to slap on things on objects willy-nilly.

Basically, our controller creates some object, e.g. `directiveApi = {}`. That object is then passed with binding to our directive. During its initialization the directive would add functions to this object (`scope.directiveApi.onRealAll = function() {}`).

That way the controller now has a reference to a function that was created by the directive, and can call it at will.

This feels like one big hack to me. My aesthetics always prefer the explicit solution, the one that’s least likely to shoot me in the foot.

It also introduces *implicit coupling* and just feels scary when you read the controller’s code - all of a sudden it makes a call to a function you’ve never seen before.

Also, it introduces a timing issue - you have to make sure not to attempt to call these functions before the directive finished its initialization. *Scary*.

## My preferred solution - The Observer Pattern

In this case I’d rather implement my own observer pattern, even though it would require some boilerplate code, in order to avoid using events or external services.

Here’s how it goes. Our controller now manages observers:

```javascript
angular.module('chat').controller('ChatCtrl', function(ChatService) {
  var chat = this;
  var handlers = [];
  chat.markAsRead = markAsRead;
  chat.onAllRead = onAllRead;
  activate();

  function activate() { /* Setup */ }

  function markAsRead() {
    ChatService.markAsRead();
    angular.forEach(handlers, function(handler) {
      handler();
    });
  }

  function onAllRead(handler) {
    handlers.push(handler);
  }
});
```

And the directive looks like this:

```javascript
angular.module('chat').directive('chatMessageList', function() {
  return {
    scope: {
      list: '=chatMessageList',
      onAllRead: '&' // The registration hook
    },
    template: 'something', // See full plunker
    link: function(scope, element) {
      var $list = $(element).find('.js-chat-list');
      scope.onAllRead({
        handler: function() { scrollToBottom($list); }
      });
    }
  };
});
```

[Full Plunker Example](http://plnkr.co/edit/MP9Tb1sOuWaud6vrm54z)

We’re using the isolated scope in order to pass the directive a function, `onAllRead`, but this time that function is used by the directive to register for change notifications on the controller.

`ChatCtrl` saves the directive’s handler and will make sure to call it whenever it needs to notify someone about this.

This requires more typing, but I prefer it since our code is now *very clear*. It’s really easy to understand the flow even if you are unfamiliar with the codebase and stumbled upon any one of our source files by its own. 

It is also more *robust*. If we ever move things around and forget to update all the sources it would break at a useful point - when the directive would try to register to a function that is no longer there. In other scenarios, like scope mangling, it would break when the controller would try to send the notification to no one.

As a *rule of thumb*, this is the way I’d go with most of the time unless I have a pretty good reason to use something else.

**Note**: When passing functions by yourself to other places in Angular, like we do in this case, you should make sure those functions are no longer kept anywhere once the scope they’re bound to is destroyed. Failing to do that would mean memory leaks and undefined behavior. Check out the full plunker example to see how exactly this is done.

That's it. I'm more than interested in feedback about this, feel free to contact me. The important takeaway is that Angular is not trivial for communication between parts, but that doesn't mean you shouldn't be breaking your system to small, maintainable chunks.

{% render_partial _posts/_partials/book_cta.markdown %}
