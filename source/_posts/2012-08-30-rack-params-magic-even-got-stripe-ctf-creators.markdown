---
layout: post
title: "Rack Params Magic Even Got Stripe CTF Creators"
date: 2012-08-30 08:42
comments: true
categories: 
- Programming
- Hacking
- rack
- rails
- ruby
- stripe
---

I've recently had a lot of fun taking part in the [Stripe Capture The Flag](https://stripe-ctf.com) (CTF) game. It's basically a game where one has to go through several levels, finding different vulnerabilities in order to advance. This time the vulnerabilities were web-related, such as XSS, SQL injections, etc.  
It's great of the Stripe team to go through this effort to educate us all (as a bonus to providing an excellent service).

I wanted to share a little tidbit about solving one of the levels. In level 6 you needed to do an XSS attack that consisted of posting some content with some javascript in it and then posting the user's password back. Both posting the script and the user's password were supposed to be extra tricky, since the server made sure no one can write quotes to the DB. The intention the Stripe guys had, I understand, was to make one learn about different kinds of javascript code that can be written to wiggle through different kinds of defenses.

Let's take a look at the method that did this protection:

{% codeblock lang:ruby %}
def self.safe_insert(table, key_values)
  key_values.each do |key, value|
    # Just in case people try to exfiltrate
    # level07-password-holder's password
    if value.kind_of?(String) &&
        (value.include?('"') || value.include?("'"))
      raise "Value has unsafe characters"
    end
  end

  conn[table].insert(key_values)
end
{% endcodeblock %}

When something is posted, the body is usually provided inside the `key_values` as a simple string e.g. `{ "body" => "my body" }`. In that case, anyone can easily see that the protection will work.

## Enter Rack params

Rack, which is used by Sinatra and Rails, helpfully performs some magic in order to allow its `params` to be more than simple hashes of strings to strings. It does some nice parsing to allow passing nested hashes and arrays. For example, if the POST query looks like `?body[]=w00t` instead of `?body=w00t` the `params` hash will contain `{"body" => ["w00t"]}` instead of just `{"body" => "w00t"}`.

Can you see where this is going? I just changed my code to pass the body with the extra `[]` suffix and now the `safe_insert` method got a hash containing something like `{"body" => ["my evil XSS with ' and \""]}`. Since the `value` is now an `Array` and not a string, the validation is not run. Luckily for us, passing an array of length one to Sequel for saving to the DB translates to SQL roughly as `INSERT ... VALUES(('my body')) ...`. Since just wrapping an expression in parenthesis in SQL doesn't make it treat it as a list/array, the insert is performed smoothly and we have our invalid post in the DB.

I talked with the nice Stripe folks that admitted that this way of getting past the validation was not something they had in mind.

## It can happen to you too

The easiest way to prevent from stuff such as these to show up in your code is to make sure that params you get are of the types you expect them to be. It's not fun, but I'm currently not aware of a gem or something like that to handle these cases. Please enlighten me if you think of better ways!


You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [twitter](http://twitter.com/avivby)!
