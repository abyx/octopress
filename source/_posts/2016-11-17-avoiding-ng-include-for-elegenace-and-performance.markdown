---
layout: post
title: "Avoiding ng-include for Elegance and Performance"
date: 2016-11-17 15:23:52 +0200
comments: true
facebook:
    image: /images/posts_images/ng-include-no.png
cta_message: "Learn how to make your Angular 1 app modern, step by step!"
cta_form: 126749
---

`ng-include` might seem like an innocent, helpful directive.
After all, it allows us to break down a big template into simpler chunks, which makes code more readable, right?

{% img center_img /images/posts_images/ng-include-no.png %}

Personally, I never liked `ng-include` or used it, but I didn’t care much if I saw code that made use of it.
But years ago I found out that in addition to being a kind of code smell, `ng-include` also has a pretty significant *performance hit*.
Since then I’ve religiously made sure my clients stay clear of it.

And yet, whenever I start working on another Angular codebase it’s always there like clockwork - another whole slew of `ng-include`s.

So, today, we will see why you shouldn’t be using it, for elegance and for performance!

# ng-include is a code smell

I know most people use `ng-include` because it “makes code clearer” or “makes templates easier to maintain”.
But come on, does it, really?

Look at this:

```html
<div>
  <div ng-include="'header.html'"><div>
  <div>Some things go here</div>
  <div ng-include="'footer.html'"></div>
</div>
```

If you think that this will be easier to maintain, you’re wrong.
In fact, what we just did is break a single component to have its template spread across 3 different places.

Want to make a change in the component’s controller to refactor an object?
Make sure to track down all the sub-templates that use it to change it there, too.

The indirectness between the component and its newly-split template makes for a very common pitfall.
I’ve seen these break and cause bugs in production so many times, because it’s the easiest thing to miss when you quickly scan a template file and do a search for the name of a variable you just changed.
You simply don’t expect it to be used elsewhere.

Also, if what you’re saying is that your component’s template is so big you need to break it down, why not create a new component to make it smaller?

Most of the times, it’s not just the template that’s getting bigger, since things aren’t static.
You may be making the template files shorter, but in the background we’ll have a controller that’s growing bigger and bigger, with way more responsibility than it aught to have.

My rule of thumb is that if I feel like something is getting too big, I’ll break it down to smaller components, not just try to sweep parts of the template under the rug.

# But even you don’t agree, performance will kill you

I was actually very surprised when I first saw this while debugging performance issues in a big app a few years ago.
And this has yet to change.

`ng-include` is just way slower than using a directive/component instead.
Yeah, even though components create new scopes and actually introduce more watches, they are faster.

Benchmarks shows that if you have a lot of `ng-include`s on a screen, initial loading time of these sub-templates will be about *50%-60% longer* than if you’d use plain sub-components.

And it doesn’t stop at initial loading.
Once everything is one the screen, even though using a subcomponent easily doubles the amounts of watches, the impact of using `ng-include` on the digest cycle can be a whopping *100% increase*.
Yes, your average digest cycle can take twice as long, simply because of that, making everything in your app feel slower and laggy.

It’s even as simple as replacing:

```html
<div ng-repeat="todo in $ctrl.todos">
  <div ng-include="'todo.html'"></div>
</div>
```

With:

```html
<div ng-repeat="todo in $ctrl.todos">
  <todo todo="todo"></todo>
</div>
```

This alone, with a big enough `todos` list, will show you initial loading taking seconds longer, and digest cycles twice as slow.
You can see it for yourself, compare this [ng-include option](http://plnkr.co/edit/KHjfKjp6jC5TF1YKTbdd?p=preview) with this [sub-components option](http://plnkr.co/edit/xEK2tbpwazC4ezbxSnIg?p=preview).
On the upper left corner you will see ng-stats running and displaying the digest cycle time.
At least on my machine this shows ng-include as 27ms components 14ms on Chrome (93% more), and 4.3ms vs 1.6ms in Safari (169% more!).

So please, stay away from `ng-include`.
Not using it is a simple win-win – code that’s more resilient to breaking, easier to maintain, and more performant.

<hr>

You want to do Angular *the right way*.  
You hate spending time working on a project, only to find it's completely wrong a month later.  
But, as you try to get things right, you end up staring at the blinking cursor in your IDE, not sure what to type.  
Every line of code you write means making decisions, and it's paralyzing.  

You look at blog posts, tutorials, videos, but each is a bit different.  
Now you need to *reverse engineer every advice* to see what version of Angular it was written for, how updated it is, and whether it fits the current way of doing things.

What if you knew the *Angular Way* of doing things?  
Imagine knocking down your tasks and spending your brain cycles on your product's core.  
Wouldn't it be nice to know Angular like a second language?

You can write modern, clean and future-ready Angular right now.  
Sign up below and get more of these helpful posts, free!  
Always up to date and I've already done all the research for you.

And be the first the hear about my Modern Angular 1.x book - writing future proof Angular right now.

{% render_partial _posts/_partials/cta.markdown %}
