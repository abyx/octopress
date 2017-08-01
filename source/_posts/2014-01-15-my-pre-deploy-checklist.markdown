---
layout: post
title: "My Pre-Deploy Checklist"
date: 2014-01-15 21:58
comments: true
---

I’m not particularly fond of checklists in my work process, but there’s one that I find very valuable whenever I use it, and usually regret it later when I haven’t.  
It’s a simple list of stuff that I make sure I took care of whenever I deploy some new graphical component, add a new Ajax call, etc. Do keep in mind I usually work alone or with my partner, and we have no QA except our own diligence. Here it is:

### Handle long values
There will always be someone with a freakishly long email address or unusual name, or someone that really pushed it with his “!!!!!!!!!!1oneone” comment. Leaving these unhandled usually causes layout breaks (elements fall off to different locations on screen) or text covers up another element’s space.

**Tip:** It’s easy to take care of these (see [my post](http://www.codelord.net/2013/08/23/css-tip-overflowing-with-text/)).

### Treat empty sections
Displaying various empty states correctly can make all the difference in the world, from a UX perspective, e.g. between understanding I have no new messages to making me stare at the screen wondering what’s wrong.

**Tip:** If you element has a “blank slate” state do even as little as adding little label explaining what this means, e.g. “No photos. Add friends to see some!”

### Make progress explicit
I personally despise the feeling of clicking on a button and then thinking “did it work? should I click it again?”

**Tip:** Add the loaders and appropriate messages that will let people know that something is happening.

### Disable buttons after a click
Relating to the previous item, this helps indicate that the click “took” and also is important since some people tend to double click on stuff, which can cause things like double-posting a status or booking tickets twice, etc.

**Tip:** Just disable the button while the operation is happening. I like to also change the button caption as well, e.g. “Save” becomes “Saving…”.

### Verify proper keyboard control
Power users would love you to death if you make sure that pressing tab takes them to the right place and that hitting return would submit the data, etc. These are little details that can change the whole way someone treats a UI.

**Tip:** Try to edit data with the keyboard only and see what it feels like.Also, making sure your fields have the right types so that mobile browsers display the appropriate keyboards is golden (it’s 2014 – `type=“email”` is a thing).

### Add validations
Junior developers often miss checking that a submitted form actually has all fields filled.

**Tip:** A simple check to make sure values are there (and, if you’re into it, making sure the comment isn’t just `“ ”`) will help your users and also your database.



Happy coding!
