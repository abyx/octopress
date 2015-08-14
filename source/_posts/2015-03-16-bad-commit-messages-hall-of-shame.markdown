---
layout: post
title: "Bad Commit Messages Hall of Shame"
date: 2015-03-16 21:11:12 +0200
comments: true
---

Too many of us just go through the motions with Git and other version control systems without dedicating enough thought to *why* we do the things we do. This kind of cargo cult programming is so common I don’t think I’ve seen a single team where this wasn’t the case for some of the members in it.

# The Hall of Shame

* **“bug fix”, “more work”, “minor changes”, “oopsie”, “wtf”** - These mean *nothing*. You may as well supply no commit message. Why did you even bother to write it?
* **“Work on feature blah blah”** x 20 commits in a row - This is unfortunately aided by different IDEs and tools that suggest your previous commit message automatically. It creates a bunch of commits that are not discernible from one another. Yeah, I get a general topic of what they’re about, but we lost the ability to talk about them without using specific hashes and if you see that these changes for feature “blah blah” introduced a bug you have no easy way to guess which commit did it. You have to start going through the diffs.
* **“Fix BUG-9284”** - Bug trackers can be awesome, and if your workplace uses them then it makes a lot of sense to write the ticket number in the commit message. The problem is that writing *just* that now means that if I’m looking at a commit and trying to understand why a change was done I now have to go to a different system and search that number in it. This is a hassle. I usually copy and paste some part of the description of the bug to the commit message to make it easier for anyone in the future to understand what this change does.
* **“Change X constant to be 10”** - These commit messages are a lot like useless comments in code. When the description is just which changes were made it’s just duplicating the code - we can see the diff and see that X was changed from 5 to 10. What we can’t see is **why** this change was needed.
* **“super long commit message goes here, something like 100 words and lots of characters woohoo!”** - Tools care about your commit messages. There’s a convention used by most git tools that prefers the length of the first line in your commit message to be 50 characters or less. Stick to it. It makes it easier to look at the history and means you intentionally put the really important bits in the top line.

## Why are you even writing a commit message?
A lot of us got bad habits for commit messages when we first started using a VCS and didn’t understand all the benefits it has. Maybe you originally only worked alone or with a small enough team so that changes were trivial to all of you. But some day you’re going to add another developer that won’t be able to easily look at your cryptic commits and understand what was done. Or your memory will fail 2 years later when you stare at something and have no clue why you did it.

## Commits are our aid in times of great need
When do we even look at the commit history?

I use git constantly when I’m in the mud and need help. Did I just notice that someone broke a feature? I’d rather be able to whip up the commit history and spot from the messages which one might be the bad one, instead of having to start searching every damn “BUG-4239” in the issue tracker and open the diff for each “minor changes” commit.

Also, if I’m lost about when something became borked I reach for my favorite tool - [git bisect](/2012/04/10/using-binary-search-for-debugging/). But how can I easily know what range of commits to use if the last 50 commits were all called “Feature blah blah work”?

Lastly, I constantly rely on the history when making changes to code. I see a line I’m not sure about and I immediately fire up git blame in order to see in what commit it was added, what else was done along this line and, most important of all when done properly, read the commit message that hopefully tells me what I was trying to understand. If all I see is “move call to foo to be before call to bar” I’m hopeless - can I move it back? Was it moved because it broke something? Should all calls to foo everywhere be in this order? I now have to hope whoever committed this remembers why he did the change (pro-tip: or hope you have good tests, *wink wink nudge nudge*).

## Write commit message with a purpose

Good commit messages follow these criterions:

 * They say *why* you did these changes.
 * They shortly describe what was done so we can effectively glance through the history and find what we need.
 * They are self-contained - It’s great that you have a bug tracker, but don’t make me have to open it to understand why a commit was made.
 * They are in present tense - no more “*Fixing* buy button disappearance on Mondays” or “*Fixed* buy button disappearance on Mondays”. [The convention](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) is “*Fix* buy button disappearance on Mondays”.

## Repent now

No, you don’t need to delete your repository and start from scratch. Decide that from now on you’ll write commit messages with the attention they deserve. Talk with your team, agree on the guidelines for messages and publicly shame whoever disrespects you with bad commits - hey, it [worked for continuous integration](http://youbrokethebuild.com)!

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Liked this? Sign up to my newsletter to get more content (~2 mails a month)</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
    <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
