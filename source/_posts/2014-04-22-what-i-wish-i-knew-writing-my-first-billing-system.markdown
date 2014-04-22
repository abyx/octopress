---
layout: post
title: "What I Wish I Knew Writing My First Billing System"
date: 2014-04-22 16:44
comments: true
categories: 
- Programming
- billing
- stripe
- paypal
- api
---

Billing code is probably the scariest that most coders get to work with. After all, for most of us it's not everyday that we write code that *literally* moves money around.

I've gathered a list of a few things that you should keep in mind next time you set off to implement billing. Not all are a must have starting from day one, but you should have them in the back of your mind.

## Frontend & UX

**Don't leave me hanging** - There isn't a person using the internet that doesn't know the dread of having nothing visibly change after clicking a "Pay" button. *Always* show a clear indication that something's happening. Charging takes a couple of seconds - design for this waiting your users have to endure.

**Be clear about the “money time”** - I *love* it when there's a label near buttons saying whether that button is the one that's gonna charge me or if there's another screen after it.

**Prevent double-clicks** - This should go without saying, but you want to make sure the important buttons can't be clicked twice, neither because of fat fingers or because the user somehow missed the indication that the click "took". And none of that “don't refresh this page” nonsense. Users should be able to go back and forth without fearing for their money.

**Design for errors** - Charging errors happen. *A lot*. People have typos, some cards can't be billed for recurring charges and sometimes people just forget the billing address for a specific card. I've heard of people that put in bad data in the payment form just to see if the site seems "legit" and handles it correctly. You should pass along as much information as you have about the error that happened and display it to your user in a human-readable form. No general "error happened, try again" if you know the problem is the expiration date. No "CARD_EXPIRED" constants you got from the API. *Write god damn words*.


## Business

**Dunning** - Sometimes things get screwed and the monthly charge of a customer will fail. It can happen because the card expired, has no credit available, was canceled, etc. You should handle these correctly and notify your user about this, “nudging” them to update their payment method. This is called “Dunning”. You might also want to automatically attempt recharging once they update their card or just because a couple of days passed.

**Handle users in limbo** - The other aspect of dunning is that it means you have users that haven't paid yet for the current period, for whatever reason. You will need to decide how your product should behave for them (a grace period, changes in UI, hiding some features). I wouldn't delete data or prevent access to business critical stuff before at least a couple of weeks have passed though.

**Pre-Dunning** - It's basically better for everyone if instead of trying to charge an expired card and then mailing a "we couldn't charge" notification you check for it beforehand. Write a bit of code so that a week before the monthly charge you check which cards will be expired and email the users asking to update their payment method now.

**Plan for refunds** - Every business has to refund money sometimes. You don't have to create a super slick management backend system from day one, but you should know how refunds work and make sure your support staff has some way to issue refunds relatively fast and that your code will handle the situation appropriately. 

**Notify before first charge after trial ends** - This is just good etiquette. We all hate when we forget some trial and see the charge on our statement later. Do the right thing and notify your users before the trial ends and charging begins. Also, this can save you chargebacks from pissed users which cost you a lot of money and can totally screw your processing fees if there are too many of them.

## Backend

**Make debugging and support easier** - I'm very paranoid when it comes to handling money, and so I love having a kind of an "audit log" that tracks every billing related action that took place in the system. Someone tried signing up, upgrading, downgrading, charging failed, refunds. This is great for debugging.

**Plan for pricing changes** - When you start experimenting with different plans and pricing and need to grandfather users across plans you'll need to know exactly which plan users signed up for, when and for how much. This can save your bacon when it's time to move everyone around so make sure you have it all saved.

**VAT and taxes** - This can be a bitch, and I'm no accountant, so make sure you know if and when you should charge VAT and similar taxes. In the EU and other places it means you need to ask you users which country they're from and adjust the price appropriately. You will also need to make sure you add the right line-items to your invoices and keep track of how much money isn't really “yours”.

**Take special care of DB transactions** - You charge a user using some API, e.g. Stripe, then go ahead to save the user's status as “premium” to the DB. The next line causes some error and the database's transaction automatically rolls back. Essentially, you now have taken the money from the user but have no record of it in your database. Every billing-related operation should have some special logger that lets you know immediately when a rollback happens that affected the billing data.

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Liked this? Sign up to my newsletter to get more frontend content (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
    <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
