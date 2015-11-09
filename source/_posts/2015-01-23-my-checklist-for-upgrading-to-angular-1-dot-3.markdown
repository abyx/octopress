---
layout: post
title: "My checklist for upgrading to Angular 1.3"
date: 2015-01-23 11:06:16 +0200
comments: true
---

Angular’s 1.3 version was released a few months ago. Of course that the moment it was out I tried it with one of the bigger projects we’ve been working on. And of course I saw that so many things were broken (due to dependencies that haven’t caught all the related bugs yet) and just reverted and decided to wait a bit for things to ripen.

A couple of weeks ago I upgraded our app to 1.3 without much trouble. Here are the steps I took to minimize risks of breaking things:

## 1 - Read Angular’s changelog and search for breaking changes

I opened Angular’s [official migration guide](https://docs.angularjs.org/guide/migration#migrating-from-1-2-to-1-3) and started going over the changes to look for things that we’d have to change in our code. Fortunately, we had very little changes to make in this step. 

The only issue was with some change in the semantics of directives with `replace: true` which broke some of those for us and I had to essentially remove that flag from them. We don’t have a lot of these and for that I’m thankful - especially as they were just deprecated in this release.

## 2 - Research our dependencies

I went over the dependencies in our `bower.json` file and checked each:

1. Check that there’s a new release that mentions Angular 1.3 compatibility
1. Search the GitHub issues of the project for issues that mention 1.3
1. Read the package’s changelog to see what breaking changes may have been made recently and update our code accordingly

## 3 - Update everything

This essentially means updating the values in our bower configuration and installing the new dependencies. 

## 4 - Exploratory testing

I went over the different screens in our app and paid extra attention to making sure our dependencies still worked. For example, that the modals are displayed correctly and that the dropdown menus didn’t break.

In this step I discovered about 3 things that broke that I had to fix. The fixes were relatively straightforward - I opened up the project’s site and found out what was changed or that someone else already tackled these changes (a *big* advantage to waiting out a couple of months before upgrading).

## 5 - Run the tests

We have a nice suite of unit tests and some end-to-end tests. I ran them to make sure that everything is in order. To my surprise, these passed without a hitch, except for one small test that had to be fixed (it broke because of changes in `ngModelController` that affected the API we used for testing, but the feature itself didn’t break).

## That’s it!

This was really less exciting and problematic than I feared it might be. I’m happy this went pretty smoothly and allowed us to get on with work and start enjoying the new improvements in Angular without having to waste too much time on the move itself.

*Happy coding!*

{% render_partial _posts/_partials/cta.markdown %}
