---
layout: post
title: "Adapting Scroll Views to iOS 7"
date: 2013-10-18 18:27
comments: true
---

In order to get to know some of the differences in iOS 7 and practice transitioning from iOS 6, I decided to transition a little toy app that consisted of a screen similar to the Messages.app: a navigation bar, most of the screen taken by a scroll view with content and on the bottom a text view and a button for adding more content to the scroll view. The app is extremely basic, but resizes properly when the keyboard is shown and, as in Messages.app, scrolls to the bottom of the content when the text view is focused and when a new message has been added.

I put together some of the things that weren't obvious at first. It might be just me, but I'm hoping other developers will find this useful.

## Handling navigation bar on top of our scroll view

The iOS 7 view of course comes with the new look where scroll views go under the navigation bar for a nice effect. One can change the scroll view's `contentInset` manually to cover for the portion of it that is being overlapped at the top, but doing so manually is tedious and not fun. I was very thrilled to discover handling it should come at no cost if my ViewController has `automaticallyAdjustsScrollViewInsets` set to `YES`.

This didn't work for me out of the box since it turns out for the magic to happen the scroll view has to be the *first* subview of your ViewController's UIView. I had to reorder my subviews and then the magic started rolling.

## Resizing when keyboard shows up

In my iOS 6 version, my app responded to the keyboard appearing with autolayout: I'd adjust the constraint holding the bottom view to go up by whatever the height of the keyboard is, which would cause the scroll view to shrink as well automatically. I liked this solution since it repositioned everything on the screen pretty easily.

The idiom for iOS 7 though is to place the scroll view across the *whole* screen, and placing the text view above it. Then, resizing for the keyboard should not actually change the height of the scroll view, but instead change its content insets. This is preferable since it means that scroll view's content is still below the keyboard which is now semitransparent and so everything looks cool and shiny.

Layout of the scroll view, before and after:
{% img /images/posts_images/combined.png %}

So after I dragged things in Interface Builder to their new locations I changed the autolayout constraints: the text view is pulled up when a keyboard appears using a constraint as before, but that does not cause the scroll view to shrink. Unfortunately, content insets can't be controlled with constraints and so I was forced to add more code the the keyboard handling that changes the insets manually. Apple's [Text Progamming Guide](https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html#//apple_ref/doc/uid/TP40009542-CH5-SW1) instructs to do this:

{% codeblock lang:objc %}
UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
scrollView.contentInset = contentInsets;
scrollView.scrollIndicatorInsets = contentInsets;
{% endcodeblock %}

This is actually a bit problematic since it overrides the top inset and thus screws up the inset put there by `automaticallyAdjustsScrollViewInsets`, so I changed the code to:

{% codeblock lang:objc %}
UIEdgeInsets contentInsets = UIEdgeInsetsMake(
    scrollView.contentInset.top, 0.0, kbSize.height, 0.0);
scrollView.contentInset = contentInsets;
scrollView.scrollIndicatorInsets = contentInsets;
{% endcodeblock %}

## Animating resizing and scrolls

This is actually pretty basic stuff, except for the fact that in iOS 7 the keyboard's appearance animation is using a new undocumented curve function. This means that it's no longer enough to grab the animation duration from the keyboard notification, but one must also grab the animation curve from it:


{% codeblock lang:objc %}
[UIView beginAnimations:nil context:NULL];
[UIView setAnimationDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
[UIView setAnimationCurve:[info[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
[UIView setAnimationBeginsFromCurrentState:YES];

self.textViewKeyboardConstraint.constant = height;
UIEdgeInsets insets = UIEdgeInsetsMake(
    scrollView.contentInset.top, 0, textView.bounds.size.height + height, 0);
scrollView.contentInset = insets;
scrollView.scrollIndicatorInsets = insets;
[view layoutIfNeeded];

[scrollView setContentOffset:CGPointMake(0, newOffset) animated:NO];

[UIView commitAnimations];
{% endcodeblock %}

## Summary

The steps needed to make the transition are not complicated, but not trivial at first sight (well, at least they weren't for me). I'd love to hear and see how other people have made these transitions, or even be shown that I did some stupid stuff here :)
