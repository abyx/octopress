---
date: '2011-06-18 11:09:54'
layout: post
slug: statistics-of-62k-passwords
status: publish
title: Statistics of 62K Passwords
comments: true
wordpress_id: '383'
categories:
- Programming
tags:
- Programming
- security
---

A couple of days ago, [LulzSec](http://lulzsecurity.com/) published a batch of 62K random logins (emails and passwords). At first, I grabbed it in order to make sure that neither me nor anyone on my contacts had his passwords revealed. Later I decided to run a few stats on this rare dump of data. Following are a few interesting facts.


### Password length


The dump's average password length is 7.63. I was surprised, because I thought most users would use something like 4 characters, but then remembered a lot of sites nowadays enforce a a 6-8 character limit minimum, so this makes sense. As you should know, and as you can find in [Hacking: The Art of Exploitation](http://www.amazon.com/gp/product/1593271441/ref=as_li_qf_sp_asin_tl?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=217145&creative=399381&creativeASIN=1593271441)<img src="http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=1593271441&camp=217145&creative=399381" style="width: 0; height: 0; display: none; border: none !important;">, longer passwords are greatly harder to crack, so this is definitely a case where size does matter.

Here's a short graph depicting the distribution of password length (Note that edge groups have less than 10 passwords and so aren't really seen here):


### [![Passwords by length](http://codelord.net/wp-content/uploads/2011/06/passwords.png)](http://codelord.net/wp-content/uploads/2011/06/passwords.png)
Common Passwords


Not surprisingly, the most common password is 123456 with 569 occurrences, followed by its "more secure" cousin 123456789 with 184. The 3rd most common password is... "password" (132 occurrences)! The other top-10 passwords are interesting - some are plain words such as "romance", "mystery", "tigger" and "shadow", "102030" makes quite a few appearances.

The 10th most used password is quite intriguing actually - "ajcuivd289". Everyone on the internet seem baffled as to the source of this password. My guess would have to be it's some worm that resets the accounts it hacked into to it. _Edit_: As Marc comments below, the logins with these passwords seem "clustered", which makes it more likely that these are actually the result of some bot creating accounts. Thanks Marc!

A couple hundred passwords are just not-so-random keyboard taps ("123qwe", "asdf1234", etc.). 789 passwords are taken exactly from the username, and twice that many are part of the username followed by some digits (most seem like birth years).


### Inside Passwords


12179 of the passwords are all numeric, some are 14 digits long! That's just crazy. While 34717 (that's more than half) of the passwords contain any digits, only 1262 contain capital letters and 533 contain special characters!


### Some Common Words


418 passwords contain the word "love". "sex" is in 125, "jesus" in 67. More people prefer cats (414) to dogs (291). And the language battle - 6 javas, 2 pythons and 17 "ruby"s (guess which one is also a name).



I'd like to sum this up with urging you to never use the same password twice and use a password manager in order to generate secure passwords! Using a password manager ensures that even if a certain site is breached, it doesn't mean all of your passwords are revealed, and secure paswords are just harder to brute force.

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
