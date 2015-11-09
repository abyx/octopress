---
layout: post
title: "Resourceful Angular: $http, $resource and Restangular head to head"
date: 2015-07-17 00:19:06 +0300
comments: true
---

Probably the most common task you do in your Angular app is making REST requests. You'd think something like this, which is at the core of any SPA, would have a consensus in the community about the Right Way™ to do it.

But actually if you've looked around you probably came across multiple camps: those who use `$http`, those who use `$resource` and those who use bigger guns like Restangular (there are others, but in this post I'll focus on it as the most popular one by far).

You probably wondered what are the differences and which should you use. This is a quick summary trying to make sense of those options.  

# Overview

## `$http`

This is the easy and straightforward route. `$http` is pretty much what you'd expect it to be and since it's so raw it means that you'll probably write more code than you will with the alternatives but have the most flexibility and control. There's no limitation on what you can do.

It's also built in with Angular and doesn't require adding another dependency.

## `$resource`

`$resource` (also known as `ngResource`) is Angular's attempt at supplying a higher level of abstraction over `$http`. It used to be built in and has been separated to an external dependency. It basically supplies you with a relatively easy way to create objects that perform the different CRUD requests transparently.

I think this example pretty much shows the use case they had in mind, in which we define the User model and show how to update one:

```javascript
var User = $resource('/user/:userId', {userId:'@id'});
User.get({userId:123}, function(user) {
  user.abc = true;
  user.$save();
});
```

`$resource`'s history has been wonky, as it had a lot of limitations and bugs in earlier versions of Angular and still has documentation and API that are a bit cryptic to master. Usually, if your object model is complicated enough to warrant wrapping `$http` I'd jump straight to Restangular.

## Restangular

Restangular has [several differences](https://github.com/mgonto/restangular/blob/master/README.md#differences-with-resource) from `$resource`, but 2 main ones are that it has a saner API and embraces objects and nested models whole heartedly.

If you have an object model that's complicated Restangular can be a big help and save you writing a lot of boiler plate code. It also has pretty much every feature you can dream up and great documentation.

# Which should you use?

First, I'll say that IMHO (which seems to be shared by many) `$resource` isn't a real player here. You'd either use `$http` or Restangular.

Now, if you really prefer keeping boiler plate code to a minimum or like the extra abstraction Restangular is quite nice.

I, though, usually prefer reducing dependencies to a minimum and like to have ultimate control. There are a few little issues with Restangular that together boil up to make me rather just go with `$http` most of the time:

- It's an extra dependency. That means more time to load my app, more stuff to learn and more stuff to manage.
- I don't like the idea of having "special objects" floating around. It means that if you have services that handle models they can't necessarily treat all objects the same - if the object was fetched over the network it's "restangularized" and has extra stuff, if you just created it in the client and haven't saved it yet it behaves a bit differently.
- It makes it harder to spot where a certain endpoint is being used. If you use `$http` to create a service responsible for operating on a specific model you can easily find all the calls for a specific endpoint easily. For example, say your app has Projects, which have users, and Tasks, which have users. If at some point we want to rename task's "users" to "assignees" you'll have a hard time going over every `getList('users')` in the code to see if it's a project or a task. With services I'd probably just change the `TasksStore.getUsers()` function.
- Restangular's nested objects that return more and more objects make testing cumbersome. It's harder to mock out a certain dependency since you end up having to create mocks that return more mocks. This is a matter of taste, but I usually look at this as a code smell (a-la the [Gary Bernhardt school of thought](https://www.destroyallsoftware.com/blog/2014/test-isolation-is-about-avoiding-mocks)).

So, yes, I prefer `$http`, but for some people Restangular "clicks", and that's awesome. Just stay away from `$resource`.

Happy ajaxing!

{% render_partial _posts/_partials/cta.markdown %}
