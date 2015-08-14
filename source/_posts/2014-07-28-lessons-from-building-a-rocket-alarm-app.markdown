---
layout: post
title: "Lessons from Building a Rocket Alarm App"
date: 2014-07-28 15:42:36 +0300
comments: false
---

3 weeks ago Hamas started firing more than a hundred rockets a day at Israel. After almost sleeping through the sirens one time, I decided that enough is enough and went looking for a way to write an app for it. The iPhone had a single app that would constantly alert with a delay (of usually several minutes) - we couldn’t fly with that.

#### Air raid sirens 101

If you’ve never had to live in rocket range and duck for shelter (like most of the western world) here’s how it basically works: all of a sudden you hear [this lovely sound](https://www.youtube.com/watch?v=w-3_D9b_z8Y) booming across the city and now you have to run for shelter within 15-90 seconds (depending on your distance from Gaza strip).

A lot of apartments in Israel have a safe room that you can run to, but older buildings don’t which means you usually go to the stairs, since they are considered safer than the rest of the building. You then spend 10 minutes with your neighbors (or strangers that ran inside from the street), waiting for the rockets to fall or be [intercepted by the Iron Dome](https://www.youtube.com/watch?v=m1WSjuidJVw).

Problem is that these sirens are easy to miss if you’re taking a shower, a deep sleeper, in a place where there’s some noise or happen to be in a place where the sirens don’t reach that well.

With the help of a [few](http://twitter.com/arikfr) [talented](http://twitter.com/yonbergman) [friends](http://twitter.com/theyonibomber), we had a working [iPhone app](https://itunes.apple.com/il/app/zmn-mt-htr-wt-zb-dwm/id899269450?mt=8) in about 20ish work hours over the weekend. Since then the app has topped the Israeli App Store’s free chart and delivered tens of millions of notifications. Here’s a random collection of things I’ve learned along the way:

* **Not that hard to top the Israeli store:** On its first day, the app had about ~4k installs (mostly in the Israeli store) and those were enough to get it to #10 on the free chart. 2.5 days later it had ~24k installs and ~100 5 star reviews, which brought it to be #1 on the Israeli store.

* **Going viral in bomb shelters:** This is a bit stupid but I was utterly surprised to see the amount of installs keep going up. I posted once on Facebook. It seems like from there the app was shared across the Israeli tech people which got a nice amount of first installs. But the real masses of installs happened after every barrage on big cities. I’ve seen this and heard from other people: as we stand in the bomb shelters for minutes, usually with neighbors and total strangers, people see you get alerts on time and lament the crappy app they’ve been using.

* **Testing is weird:** We had scenarios of “well, I’ll just wait for Hamas to bomb us again to make sure it works.” That’s kind of a weird scenario to be in. But hey, you could always count on Hamas to deliver, even during ceasefires!

* **An accessible mail form will be triggered *a lot*:** The app has a “contact us” button that just opens up the native iOS mail compose view with my email address. The amount of empty emails I’ve received (due to people just pressing “send”, without writing anything, instead of “cancel”) is nearing a 1000 (and we currently have about 70k installs). Be prepared.

* **People mostly want to stay updated:** In times like this it seems Israelis really want to stay updated about rocket launches. It’s a small country and you know someone at every city - you want to know when your friends are attacked. Even though you can point the app to only alert for your own city, over half of the users have set the app to alert them for “every alarm” (over a hundred a day). That also means that the app was not just used for “I have to run for cover” but also as a news source, which is why I got hundreds of emails asking to add other notification sounds, “less alarming alarms” if you will.

* **People actually read the P.S. of emails:** I’ve handled hundreds of support emails and in most added something like this: “P.S. If you’re satisfied with the app it would really make us happy if you click here and rate us well”. A lot of people replied with “already did” or “of course, you deserve it” and we actually have about 0.5% of installs that rate us (with a 5 star rating). I don’t know what’s the average here, but it seems to me the P.S. works.

* **Push permission is a bit of a pain:** A lot of people did not allow push notifications when the app prompted them and then complained about not getting alerts. It was very hard to instruct them via email how to get to the appropriate settings screen and what to set in it. There should be an easy way to prompt the user again even if it hasn’t been that long since the last time he said no. Also, do yourselves a favor and put in your email form a user identifier that’ll help you see if the user has allowed push and other things. It’s otherwise almost impossible to identify a single user out of tens of thousands.

* **Parse is pretty awesome:** We’re sending out millions of push notifications a day for free and the integration was a breeze. We once noticed a delay in delivering notifications and the Parse team were quick to reply and sort out the problem. Really amazed me!

Here's to hoping the app goes idle soon!

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Liked this? Sign up to my newsletter to get more coding content (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
    <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
