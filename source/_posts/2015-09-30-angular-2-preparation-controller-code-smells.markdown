---
layout: post
title: "Angular 2 Preparation: Controller Code Smells"
date: 2015-09-30 00:22:58 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
---

Controllers are a big part of Angular 1 that is going away in Angular 2. As I mentioned [previously](http://www.codelord.net/2015/09/10/angular-2-migration-path-what-we-know/), the Angular team isn’t really talking about a migration path for controllers because they’re just *dead*. In Angular 2 you will probably rewrite all your controllers as components - basically directives with templates.

But what should you do about your current code? You already have controllers. Should you rewrite them? Can you keep using them for the time being? Should you stop creating new ones?

I’m *extremely* against investing time in Angular 2 APIs/code. It’s just [not there yet](http://www.codelord.net/2015/06/27/should-you-use-angular-2-dot-0-or-1-dot-x/). But, that doesn’t mean you can’t start writing your Angular 1 code in a different mindset today.

Yes, it would be better if you’d kill all your controllers today and never write a controller again. That’s a possible way to go with - I’ve heard of several people who’ve been doing this for a while now. But if your project is large, migrating all controllers would be a pain.

That’s why I think the first major focus should be writing your controllers today so that killing them later would be easier.

To help you spot controllers that would be hard to kill, here’s a list of controller code smells for Angular 2 preppers:

## Not using `controller-as` syntax

Using [controller-as syntax](http://toddmotto.com/digging-into-angulars-controller-as-syntax/) has been part of our community’s guidelines for a while now. Using it makes for more maintainable controllers and less [scope soup](http://www.technofattie.com/2014/03/21/five-guidelines-for-avoiding-scope-soup-in-angular.html). 

In the Angular 2 perspective, it also means that you are taking the first step towards creating clear boundaries. In your templates it should always be clear what scope/controller. Using this form will make it easier to tell exactly where a controller is being used. It will make a future migration more of a simple task and not feel like an explorer fighting unknown references.

## Injecting `$http` to a controller

This is actually just a very common indicator of a *controller doing too much work*. Controllers should be thin when it comes to logic. You should push essentially anything that doesn’t relate directly to manipulating the view model to a factory.

## Putting lots of stuff on `$scope`

Exposing a lot of logic to the template (even not using `$scope`, but the controller itself, in the case of controller-as) is another smell of a controller biting off too much.

Thin your controllers so that they are small and do one thing well. If necessary extract out sub-directives and sub-controllers. Just don’t let a single file have hundreds of lines. That’s a recipe for a file you’ll have a hard time converting. Also, these files tend to just grow larger - once you’ve passed critical mass there’s no stopping them - so coder beware.

## Accessing `$scope.$parent`

One of my best tricks for maintainable code is having clear boundaries and decoupling. That’s why I almost always prefer writing my directives with isolated scope.

Seeing a controller peeking into its parent’s scope makes me cringe. That’s a definite recipe for bugs and a migration nightmare.s

## Using `$rootScope`

Similar to the previous point, `$rootScope` is another way of entangling pieces of code, making them harder to change later.

Sometimes it’s the right tool, but you should always be wary of introducing more globally shared state.

## Injecting a lot of things

Again, your controllers should be *as thin as possible*. If said controller is injecting 10 services, I find it hard to believe that it’s thin enough. Dumb it down, extract logic to other parts and make sure your controllers are in small bite-sized chunks that you can easily reason about and test later on when you might want to get rid of them.

---- 

The road to Angular 2 is still a way ahead, but simple steps like these will make it easier once we get there. In a future post we’ll see how you can stop writing controllers (or, at least, less of them).

{% render_partial _posts/_partials/book_cta.markdown %}
