---
layout: post
title: "AngularJS: Dynamically loading directives"
date: 2015-05-19 22:46:52 +0300
comments: true
categories: 
- Programming
- angularjs
- angular
---

It’s hard to write a webapp today without some sort of dynamic feed/list: Facebook’s news feed has photos, text statuses, ads, Twitter’s feed has promoted tweets, image tweets, retweets, and maybe you have a chat/messaging feed in your app with text, videos, photos and stickers.

While this is relatively common, it might not be straightforward to do so in Angular, or what is the Right Way™ for doing this.

## The problem

Say that we get from a REST API a list of feed items, that look somewhat like this:

```javascript
[
    {
        "type": "text",
        "body": "hello"
    },
    {
        "type": "image",
        "url": "http://..."
    }
]
```

Naively, we might say what we really want is to create 2 directives, one for rendering text items (`text-feed-item`) and one for images (`image-feed-item`), and write something that looks like this:

```html
{% raw %}<div {{item.type}}-feed-item item=“item”></div>{% endraw %}
```

Of course, this isn’t valid Angular code. So what should you do?

## Keep it simple, stupid!

One of my main rules of thumb is to keep away from complexity as much as I can and be explicit. This means that if I have only a handful of different item directives to choose from, I’ll write something very explicit, like this:

```html
<div ng-switch=“item.type”>
    <div ng-switch-when="text" text-feed-item item="item"></div>
    <div ng-switch-when="image" image-feed-item item="item"></div>
</div>
```

This has the several advantages:

* Simple as can be
* Explicit
* Easily searchable (say, if you want to find who uses the `image-feed-item` directive you can use plain search and find this)

But, in case you have more than a handful of different feed item types this might get out of hand or just plain get annoying.

## $compile

Angular's way of dynamically adding directives to the DOM is *compiling* them. I know the word "compile" feels quite odd in our little corner of web development, but for some reason that's the word they chose for the process of having Angular parse a DOM node and executing all the Angular goodness it requires.

Making a dynamic directive that does basically what our first naive attempt looked like isn't that hard, once you know about Angular's `$compile` service:

```html
<div item-generator item="item"></div>
```

```javascript
angular.module('myApp').directive('itemGenerator', function($compile) {
    return {
        scope: {
            item: '='
        },
        link: function(scope, element) {
            var generatedTemplate = '<div ' + scope.item.type
                + '-feed-item item="item"></div>';
            element.append($compile(generatedTemplate)(scope));
        }
    };
});
```

This will result in something that looks like this if you inspect the DOM:
```html
<div item-generator item="item">
    <div image-feed-item item=“item”>
        <img ...>
    </div>
</div>
```
As you can see, `$compile` has two steps. First, we call it with the HTML we want to generate, which returns a function. We then call that function with the specific scope we want the generated element to have and then we actually get the new element that we can add to the DOM.

Yes, this is more complicated, requires being more comfortable with how Angular works and doesn't have the benefits I listed above for the simpler solution, but sometimes this approach is necessary.


<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Don't miss more Angular and frontend tips, subscribe! (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline"><!--
    --><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
