---
layout: post
title: "Preferred AngularJS Communication Patterns"
date: 2017-09-29 00:04:58 +0300
comments: true
facebook:
    image: /images/posts_images/possibly-unhandled-error.png
cta_form: 272683
---

A very common head-scratch moment with AngularJS is whenever one needs to decide on how to communicate and pass information between a couple of components.
As you learn more about AngularJS it actually gets more confusing, since there seem to be so many ways, which is the right one for your scenario?

I compiled here the common patterns and anti-patterns, sorted and listed from you-should-probably-use-this all the way to please-god-no.

# Always use when possible

## Bindings
Bindings essentially mean passing a callback function a child component so it can call back on the parent.
Use this whenever a child needs to pass information to its direct parent, e.g. a button was clicked or an error occurred.

## $onChanges
The `$onChanges` lifecycle hook, which I covered [here](http://www.codelord.net/2016/04/14/angular-1-dot-5-new-component-lifecycle-hooks/), coupled with one-way data flow, can be used as the opposite of callback bindings.
By supplying a one-way binding (`<`) to a child component, the parent can essentially trigger behavior in the child by overriding the binding value with a new one, causing the child’s `$onChanges` to be called.
Then, the child component can see which binding has changed and to which value, and act accordingly.

# Use with care
Having to use these might mean that you’re doing something a bit too complicated, but not always.

## Require
The `require` mechanism is strong and provides a lot of power, as described [here](http://www.codelord.net/2016/11/30/advanced-angular-1-dot-x-component-communication-with-require/) and [here](http://www.codelord.net/2016/12/06/video-walkthrough-refactoring-angular-components-to-use-require-mechanism/).
It can really simplify complex component families.
And yet, don’t be trigger-happy about using it, since it also adds complexity.

## Add a service with extra state
This actually has been the go-to solution for most non-obvious communication patterns in the AngularJS of old.
People would just create these services which essentially were just global state, and inject them everywhere that needed access to something.
Frankly, these are just a tiny bit better than putting lots of crap on your `$rootScope` and I don’t think it should be used in most codebases more than handful of times, and kept to a minimum.

# Try to never use unless absolutely necessary
## $watch
Well, `$watch` is still useful, of course, when you have to deeply watch some object, or when integrating with external libraries that don’t expose proper events or promises.
And yet, these are rare scenarios.
If all you need to do is know when a binding you got is changed, push that code to `$onChanges` and be done with it.

# Never use
(Well, 99.9999% of the cases)

## Events

AngularJS’s scopes have broadcasting capabilities, e.g. `$broadcast` and `$emit`.
These allow passing messages between parent and child components across multiple layers.
Having worked on dozens of AngularJS projects, I frankly don’t believe I cam across a codebase that incorporated these as a standard pattern and didn’t come to regret it later.
Events, when used freely, usually end up causing code to be come a big spaghetti mess.

Do note though, that there are cases these events are useful, e.g. for implementing some sort of subscription mechanism for listening to changes in external data, like in your `Store` services.
You can see an example of such a service [here](http://www.codelord.net/2015/05/04/angularjs-notifying-about-changes-from-services-to-controllers/).

Did I miss any important patterns?
Let me know!

{% render_partial _posts/_partials/book_cta.markdown %}
