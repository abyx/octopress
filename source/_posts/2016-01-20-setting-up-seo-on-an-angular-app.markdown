---
layout: post
title: "Setting up SEO in an Angular app"
date: 2016-01-20 11:42:26 +0200
facebook:
    image: /images/ng-codelord.png
cta_message: "Let me know when that Stairway to Angular 2.0 Heaven course is ready!"
cta_form: 19301
---

Angular and SEO don’t really go well together without some nudging.

As you probably know, the whole client-side MVC thing has its perks.
But, it comes with a price: search engines usually won’t be able to scrape your site.

Angular 2 should enable us to render pages on the server as well, which will help solve this.
In the meantime, let us see what you can do with your production app today.

I’ll talk about setting this up using the awesome [Prerender.io](http://prerender.io) service, which I’ve had great experience with.
It’s also open source, so you can host it yourself if that floats your boat.

We basically set up our site so that requests from search engines get redirected to a Prerender.io server, which then serves cached content to the search engine.
Magic!

Note: SEO is not a client-side only deal.
You will have to make changes to whatever server you’re using to serve your app.
Also, Google has officially deprecated this sort of solution on the grounds that their bots can crawl JS sites.
It might be good for you, but if you look around you'll see plenty of developers complain that it's not perfect, not working or that they care about more than just Google's bots.

# Site preparation

While it doesn’t take a lot of changes usually, there are still some things you need to make sure you’re doing correctly before SEO will work for you.

## Push-state

HTML5 push state makes your app use URLs that look “regular”, e.g. `example.com/foo/bar` instead of the default `example.com#/foo/bar`.
When doing SEO, my opinion is that using push-state makes things simpler all-around.

If you’re not already using it, you can see [my post](http://www.codelord.net/2015/05/12/angularjs-how-to-setup-pushstate-with-html5mode/) about getting started with push state in Angular.

Then make sure to add this meta tag (see [here](http://stackoverflow.com/a/23404467/573) why):

`<meta name="fragment" content="!">`

## title, description, and metadata

A lot of the time when writing a simple SPA we tend to neglect the good old `<title>` tag (and similar tags, like meta description).

We want search engine results to show properly the content the user will find on the page, and so you should make sure to keep these updated.

For example, if you’re writing a forum, make sure to update the title tag to the current thread’s title whenever routing to a new thread.

It’s not really complicated.
You should put a directive on the `<title>` tag that updates it according to the current page.

*Pitfall*: make sure you have your `ng-app` on the `<html>` tag and not the `<body>`, so you will be able to have directives in the `<head>` element as well.

## ng-click pitfalls, e.g. paging

With SPAs it’s easy to get used to doing most of everything with `ng-click`s on elements.

That’s not how plain sites work, right?
You should use `<a href=“..”>` tags to move between states.

Keep in mind that search engine crawlers crawl your site by looking for links.
That means that if, for example, you have several pages you’d like it to crawl, you need to use *real* links.

Instead of having something like `<button ng-click="paging.next()">Next</button>` that changes the current route to `/pages/2` or whatever, change it to something along these lines:

`<a ng-href="paging.urlForNextPage()">Next</a>`

# Setting up Prerender.io

This is actually quite straightforward.
Follow [these instructions](https://prerender.io/documentation) and you should have something running locally in 10 minutes.

## Tweaking: Optional API

Prerender.io does a pretty good job of knowing when your site has finished loading before caching it.

But, you might want to tweak it if you’re doing something complicated on page load.
They have a little trick you can use to hint them, see [here](https://prerender.io/documentation/best-practices).

You can also look at that link to see how you can return proper HTTP status codes, like 404, in case the crawler tries scraping something it shouldn’t.

## You’re good to go!

Go over the prerendered site and make sure all your links work so that the crawlers can get to all the pages you want them to.
If all looks good you can go live.

<hr>

Do you have a big *Angular 1.x app* that you're scared will *rot and become legacy code*? Because 2.0 and TypeScript will soon be *the new shiny* yet you have *all this JS code* sitting there? Where will your team find the time, and *management approval*, to learn and move things to 2.0?

But what if you could *migrate your project*, incrementally, while keeping your time's pace and shipping awesome code? What if your team could learn a bit more Angular 2 with each task? Imagine you could get to be *working in 2.0 land without ever stopping your development*!

I'm cooking up a self-served course that will get you there. It will allow you, *on your own pace*, learn Angular 2 and TypeScript bit by bit. With those steps your team will migrate your project and soon you'll write all your new code with Angular 2, TypeScript, and *won't have to stay behind*.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
