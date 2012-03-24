---
date: '2010-12-11 19:46:14'
layout: post
slug: serializer-kata-practicing-dry
status: publish
title: 'Serializer Kata: Practicing DRY'
comments: true
wordpress_id: '279'
categories:
- Programming
- clean code
- SCIL
- software craftsmanship
---

This kata is intended to help one practice the DRY principle (Don't Repeat Yourself). You can read more about DRY [here](/category/dry/).

A few notes:

  * After completing a step in the Kata and before moving on to the next, take the time to make sure your code's duplication ≤ 0
  * For the sake of focus, you may ignore matters of character escaping, encoding, error handling, object graph cycles and the likes
  * Our focus is on **reducing duplication**, it is **not finishing** the kata


In this Kata, our goal is to implement 2 simple object serializers. One serializer is to [XML](http://en.wikipedia.org/wiki/XML), the other is to [JSON](http://en.wikipedia.org/wiki/JSON).

  1. Support serializing  a class without any members
    1. To XML: EmptyClass -> &lt;EmptyClass&gt;&lt;/EmptyClass&gt;
    2. To JSON: EmptyClass -> {}
  2. Add support for serializing a class' integer members
    1. To XML: IntClass(a=1, b=2) -> &lt;IntClass&gt;&lt;a&gt;1&lt;/a&gt;&lt;b&gt;2&lt;/b&gt;&lt;/IntClass&gt;
    2. To JSON: IntClass(a=1, b=2) -> { "a": 1, "b": 2 }
  3. Add support for serializing a class' string members
    1. To XML: StrClass(a="first", b="second") -> &lt;StrClass&gt;&lt;a&gt;first&lt;/a&gt;&lt;b&gt;second&lt;/b&gt;&lt;/StrClass&gt;
    2. To JSON: StrClass(a="first", b="second") -> { "a": "first", "b": "second" }
  4. Add support for serializing a class' other class members
    1. To XML: CompositeClass(inner=(a=1)) -> &lt;CompositeClass&gt;&lt;inner&gt;&lt;a&gt;1&lt;/a&gt;&lt;/inner&gt;&lt;/CompositeClass&gt;
    2. To JSON: CompositeClass(inner=(a=1)) -> { "inner": { "a": 1 } }

If you found this interesting subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
