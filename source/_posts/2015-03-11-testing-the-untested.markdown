---
layout: post
title: "Testing the Untested"
date: 2015-03-11 20:33:36 +0200
comments: true
categories: 
- Programming
- testing
- tdd
---

I'm quite of a testing nut. TDD gave me a big leap forward in my career. I attribute to it a major part of my ability to tackle big tasks.

I won't go into it again, you can read some of my thoughts about it [here](/2012/01/06/looking-back-on-18-months-of-testing-and-tdd-at-a-startup/). As the years passed I must admit that I've become less of a zealot about this. Yes, I write some code without tests (*gasp!*). Especially when I crank out prototypes for clients to get fast feedback (after all, a good feedback loop is what TDD is all about).

But, even when I don't write tests I still do it responsibly. Once the code reaches some stability (and this usually happens after a week or two of development, not months) I add tests as I go along.

This is *incredibly* important. How many times did you let a spike turn into a big ball of mud that is super hard to test? Having the discipline to act on time is a big part of being a *professional*.

How should you go about doing this? First, start covering the parts of the code that break the most or that you find hard/scary to change. This means we first add the tests with the biggest bang for the buck.

I tend to add test cases almost as if I were writing the whole thing from scratch in TDD. I'll write many small test cases and they give me the confidence that everything is in order. I might delete some of these tests later, but this isn't waste! Once you're skilled in testing, writing a few more tests is cheap and worth it - even if you delete them two hours later.

An important thing here is to **see your damn tests fail**. The TDD cycle is [red-green-refactor](http://www.jamesshore.com/Blog/Red-Green-Refactor.html). If you haven't seen a test fail, how can you tell it's even working? You need to *test your tests*.

Yes, you already wrote the code, and so it makes sense that the test is passing. But the solution is stupidly simple: **break the code**. Find the conditional or whatever that this specific test is checking, change it so it's invalid and see the test fail with your own eyes. That's the only way to make sure that it works, checks what you meant it to check, and that the error it produces is decipherable.

Don't test hard, test well :)

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Liked this? Sign up to my newsletter to get more (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
    <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
