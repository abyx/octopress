---
layout: post
title: "Quick Tip: Firing Up Rubinius to Dig into Ruby Source"
date: 2012-05-06 22:51
comments: true
---

The other day I came across another great use-case for [Rubinius](http://rubini.us) that might be useful for a lot of developers.

I use [pry](http://github.com/pry/pry) as my ruby REPL regularly. Often I feel the need to dig deeper into some part of the ruby stdlib. For example, just this week I wanted to find out what `String.replace()` does. Reading the documentation I still felt the need to dig deeper and see what's going on.

Using CRuby (the ruby version you're probably using) one can see the source code in pry by installing the proper gem (`gem install pry-doc`). Here's the source code we got:

``` ruby
pry(main)> show-method String#replace

VALUE
rb_str_replace(VALUE str, VALUE str2)
{
    str_modifiable(str);
    if (str == str2) return str;

    StringValue(str2);
    str_discard(str);
    return str_replace(str, str2);
}
```

As you can see there isn't a lot we can understand about the internal behavior of this function without digging deeper into `str_replace`, which isn't really possible from pry.

### Enter Rubinius

After you install rubinius (`rvm install rbx --1.9`) and switch to it (`rvm use rbx`) you can get a more interesting result (you might have to `gem install pry` after switching to rubinius for the first time):

``` ruby
pry(main)> show-method String#replace

def replace(other)
  Rubinius.check_frozen

  # If we're replacing with ourselves, then we have nothing to do
  return self if equal?(other)

  other = StringValue(other)

  @shared = true
  other.shared!
  @data = other.__data__
  self.num_bytes = other.num_bytes
  @hash_value = nil
  force_encoding(other.encoding)

  Rubinius::Type.infect(self, other)
end
```

Now, not only can we see that `String#replace` replaces the contents of the String object we have with the contents of the other one (basically, treating String as a pointer and changing what it points to), we are free to dig deeper with the joys of ruby. For example, if we want to understand what `StringValue` does we're just a short `show-source StringValue` away from it!

This simple ability is a valuable resource in getting intimate with ruby as a primary language. If you find more cool uses of this, please let me know.

You should [subscribe](http://feeds.feedburner.com/TheCodeDump) or [follow](http://twitter.com/avivby) me on twitter!
