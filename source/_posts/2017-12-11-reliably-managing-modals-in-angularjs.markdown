---
layout: post
title: "Reliably Managing Modals in AngularJS"
date: 2017-12-11 21:37:47 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_form: 309485
---

The devil’s in the details, and you know what’s full of details?
Managing modals, popups and dialogs in a single page app.
You want to reliably display them, yet it’s _super_ easy to have bugs turning up with them, such as a modal staying stuck on top of your UI even though the underlying state has changed.


For example, Twitter’s current UI whenever you click a tweet’s timestamp, that tweet is displayed as a modal on top of the current page you’re on:

{% img /images/posts_images/modal-screenshot.png %}

And from that screen you can stack up even more modals, e.g. by clicking to view who liked or retweeted that tweet.

Managing all those modals can be a _PITA_.
You have to make sure clicking a link that goes someplace else dismisses all the modals that should be dismissed.
And on the other hand, you have to make sure that dismissing the modal, e.g. by clicking that X button, results in the state changing together.

I’ve often seen this result in lots of copy-pasted code for handling dismissals and listening for state changes to clear things up.
(Actually, while playing around with Twitter to get the screenshot for this post I noticed that simply clicking through some modals breaks things in twitter such as history in some of the cases…)

But, it doesn’t have to be this hairy and buggy.
You don’t have to keep adding more and more checks for removing your modals everywhere in the hopes of it actually sticking.
With the right design decisions, modals can work almost as seamlessly as regular bindings in AngularJS.

# Reliable Modals
A reliable pattern that I’ve seen successfully implemented at several clients is to _bind modals to a matching router state_.  
There are different ways this can be done, but the important issue is accepting the idiom that modals shouldn’t ever cross state changes - if a state is left, the modals it introduced should be cleared.
Let the new state start fresh and clean of the previous thing.


## The simple way - auto dismissals
This is by far the simplest way to make sure modals never stick around, and it works for apps with simple modal use.
I’ve seen this working for years at several places and reliably.
Essentially, you register a state change listener in your router and whenever there’s a state change you make sure to dismiss all open modals, whatever those might be.
Again, this might seem harsh, but in some apps this works like a charm, and is better than nothing.

A simple example, using UI Router’s `$transition` service and Angular UI Bootstrap’s `$uibModalStack`, this can be as simple as:

```javascript
$transitions.onFinish({}, function(transition) {
  $uibModalStack.dismissAll();
});
```

And of course, if needed, you can only perform this for transitions that match a specific criteria.

## Hard binding modals and states

The hard binding solution is also the harder way, but it provides more flexibility and control.
In this pattern, we configure the different states so that whenever a state is opened, a specific modal is initialized.
Whenever that state is transitioned from, that same specific modal is dismissed.
And, lastly, we make sure that if the modal is dismissed (e.g. by clicking a little ‘X’) the state itself is transition out from, usually by going to its parent state.

For example, the tweet details modals from the screenshot above might be defined like this state:

```javascript
$stateProvider.state('profile.tweet', {
  url: '/tweet/:tweetId',
  onEnter: function($uibModal) { // 1
    $uibModal.open(...).finally(function() { // 3
      $state.go('^');
    });
  },
  onExit: function() { // 2
    // dismiss modal
  }
});
```

Breaking this down, first look at the line marked with `1`.
`onEnter` is called as the state is initialized, and then we immediately open up the modal that is bound to this state.

Similarly, on line `2`, we make sure to use `onExit` to be notified of when the state is transitioned from and dismiss the modal in case it’s still there.

Finally, on line `3`, we make absolutely sure that any dismissal of the modal, for any reason, will also result in a transition to a proper state.
We do that by adding a `finally` callback to the modal’s dismissal promise.

This boils down to manually wiring two-way binding between the state and the modal, and it achieves air-tight confidence in your modals playing along nicely.


{% render_partial _posts/_partials/book_cta.markdown %}
