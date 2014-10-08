---
layout: post
title: "Don't Use Yeoman's Default Angular File Structure"
date: 2014-10-08 10:07:00 +0300
comments: true
categories: 
- Programming
- angularjs
---

Yeoman is a very handy tool, and I've used its angular-generator to generate a basic structure for several new projects before. You should use it if you'd like to have it worry about all of your project's build process (minification, uglifying, compiling SASS, etc.).

But, in my opinion the default file structure is almost *negligent*. If you go along with it to create your different controllers and directive you end up with something that looks like this:

    app/
        scripts/
            controllers/
                main.js
                foo.js
                bar.js
            directives/
                baz.js
                lolz.js
            services/
                haha.js

*Can you say "big ball of mud"?*

This is bad, since when creating new entities in your project and arranging them, you shouldn't put them together based on what Angular component they happen to be implemented with. No, we know this already. File structures should be a tool for grouping components logically. After all, when you need to make a change in the login module, do you want to go hunting for the right files under each directory, or open the "login" directory?

I believe you should strive to a structure that looks more like this:

    app/
        scripts/
            login/
                login-page.js
                password-validator.js
            dashboard/
                cool-charts.js
                timeline.js

### Do I have to stop using the generators for controllers, directives, etc.?

Yes.

I know, it's not fun. But as far as I can tell, the generators (e.g. `yo angular:controller login`) don't support a different file structure at the moment. It it something that's planned according to the project's site. 

But it just boils down to a relatively simple template (in case you don't want to type the boilerplate yourself when creating a new file) and adding a line to `index.html`, really not that big of a deal if it means I get proper file structure.

Happy coding!

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
