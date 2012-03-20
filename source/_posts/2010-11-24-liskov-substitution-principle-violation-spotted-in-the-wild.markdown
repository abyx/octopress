---
date: '2010-11-24 22:35:30'
layout: post
slug: liskov-substitution-principle-violation-spotted-in-the-wild
status: publish
title: Liskov Substitution Principle Violation Spotted in the Wild
comments: true
wordpress_id: '272'
---

The [Liskov Substitution Principle](http://en.wikipedia.org/wiki/Liskov_substitution_principle) (LSP) states that "if S is a subtype of T, then objects of type T in a program may be replaced with objects of type S without altering any of the desirable properties of that program." This principle is actually so important it's part of [SOLID](http://en.wikipedia.org/wiki/Solid_(object-oriented_design)).

At my work we've just wasted quite some time chasing down a bug that was due to a violation of LSP, in the JDK! Everyone knows the Set collection, which simply makes sure the collection can't contain the same object twice ("same" as defined by Java's "equals"). Set itself is unordered, which can be bumming, but fortunately the JDK people were nice enough to add SortedSet.

Given LSP, one might assume that wherever you use a Set you can simply replace it with a SortedSet in order to get the same thing but with sorted output. Well, think again! _(Tam, tam, tammmm)_

Suppose you have this nice class:
This is all very fine and dandy, but somewhere in our code we wanted to replace a Set of Accounts with a SortedSet, so the accounts will be displayed sorted by their names (only their names). So, we whipped up this simple Comparator: 
This looked very cool and everything worked, until we attempted to add to the SortedSet 2 accounts with the same name but different IDs. We expected both to be inserted to it, since they are not "equal", but were surprised by the result of this:

The above test **fails**. After much digging and debugging, we realized that the TreeSet uses the Comparator to determine whether the account was in the set. Once it found an object in the set that had the same "comparison value" ("compareTo" returned zero), it decided the account was already in the set. This is stupidly stupid, since we felt the natural behavior is that returning zero means we don't really care about these objects' order, and that equals() will be used to determine which are actual duplicates. Switching the code to use a non-SortedSet (e.g. HashSet) makes the test pass.

This violation of LSP has caused us much frustration and wasted efforts. Making me feel even worse, we found out after the fact this is [documented behavior](http://bit.ly/g72jlQ):


> The behavior of a sorted set _is _well-defined even if its ordering is inconsistent with equals; it just fails to obey the general contract of the Set interface.


**Edit: **So, yeah, had we read this beforehand we would have known this. The problem is we shouldn't have to read it. Some commenters helped out and said we can simply make our Comparator look at "id". Indeed we can, but this is a simplified case. In cases the object's "equals" looks at all members, even private ones, how will you be able to provide just a comparator to sort them by a specific attribute that is public? The behavior of SortedSet means you simply can't, making the whole point of having pluggable Comparators a a bit misleading, since most of them will have to re-implement "equals". Indeed, the docs for Comparator#compare (as opposed to Comparable#compareTo) **recommend** an ordering that is consistent with equals(), but sometimes that's just not possible. In those cases, it turns out, one can't sort!

To that, all I've got to say is "shame on you!"

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
