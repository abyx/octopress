---
date: '2011-08-09 22:18:07'
layout: post
slug: guest-post-lookup-tables-with-ruby-on-rails
status: publish
title: 'Guest Post: Lookup Tables with Ruby-on-Rails'
comments: true
wordpress_id: '427'
categories:
- Programming
- guestposts
- rails
---

_This is a guest-post by Nimrod Priell ([@nimrodpriell](http://twitter.com/nimrodpriell)) about the kind of time-saving tricks that I'm amazed are so easy to pull off in Rails_

If you want to have an ActiveRecord macro to define memory-cached, dynamically growing, normalized lookup tables for entity 'type'-like objects, read along. Or in plain English - if you want to have a table containing, say, ProductTypes which can grow with new types simply when you refer to them, and not keep the Product table containing a thousand repeating 'type="book"' entries - and gain some insight into ruby metaprogramming techniques - sit down and try to follow through.

A [normalized DB](http://en.wikipedia.org/wiki/Database_normalization) means that you want to keep types as separate tables, with foreign keys pointing from your main entity to its type. For instance, instead of:



    ID  car_name        car_type
    1   Chevrolet Aveo  Compact
    2   Ford Fiesta     Compact
    3   BMW Z-5         Sports

You want to have two tables:

    ID  car_name        car_type_id
    1   Chevrolet Aveo  1
    2   Ford Fiesta     1
    3   BMW Z-5         2

And

    car_type_id car_type_name
    1           Compact
    2           Sports

The pros/cons of a normalized DB can be discussed elsewhere. I'd just point out a denormalized solution is most useful in settings like [column oriented DBMSes](http://en.wikipedia.org/wiki/Column-oriented_DBMS). For the rest of us folks using standard databases, we usually want to use lookups.

The usual way to do this with ruby on rails is:

  * Generate a CarType model using rails generate model CarType name:string
  * Link between CarType and Car tables using belongs_to and has_many

Then to work with this you can transparently read the car type:

{% codeblock lang:ruby %}
car = Car.first
car.car_type.name # returns "Compact"
{% endcodeblock %}

Ruby does an awesome job of caching the results for you, so that you'll probably not hit the DB every time you get the same car type from different car objects.

You can even make this shorter, by defining a delegate to car_type_name from CarType:

{% codeblock lang:ruby %}
# car_type_name.rb
delegate :name, :to => :car, :prefix => true`
{% endcodeblock %}

And now you can access this as

{% codeblock lang:ruby %}
# car_type.rb
car.car_type_name
{% endcodeblock %}

However, it's less pleasant to insert with this technique:

{% codeblock lang:ruby %}
car.car_type.car_type_name = "Sports"
car.car_type.save!
#Now let's see what happened to the OTHER compact car
Car.all.second.car_type_name #Oops, returns "Sports"
{% endcodeblock %}

Right, what are we doing? We should've used

{% codeblock lang:ruby %}
car.update_attributes(car_type: CarType.find_or_create_by_name(name: "Sports"))
{% endcodeblock %}

Okay. Probably want to shove that into its own method rather than have this repeated in the code several times. But you also need a helper method for creating cars that way…

Furthermore, ruby is good about caching, but it caches by the exact query used, and the cache expires after the controller action ends. You can configure more advanced caches, perhaps.

The thing is all this can get tedious if you use a normalized structure where you have 15 entities and each has at least one 'type-like' field. That's a whole lot of dangling Type objects. What you really want is an interface like this:

{% codeblock lang:ruby %}
car = Car.first
car.car_type #returns "Compact"
car.car_type = "Sports" #No effect on Car.all.second, just automatically use the second constant
car.car_type = "Sedan" #Magically create a new type
{% endcodeblock %}

Oh, and it'll be nice if all of this is cached and you can define car types as constants (or symbols). You obviously still want to be able to run:

{% codeblock lang:ruby %}
CarType.where(:id > 3) #Just an example of supposed "arbitrary" SQL involving a real live CarType class
{% endcodeblock %}

But you wanna minimize generating these numerous type classes. If you're like me, you don't even want to see them lying around in app/model. Who cares about them?
I've looked thoroughly for a nice rails solution to this, but after failing to find one, I created my own rails metaprogramming hook.
The result of this hook is that you get the exact syntax described above, with only two lines of code (no extra classes or anything):

In your ActiveRecord object simply add

{% codeblock lang:ruby %}
# car.rb
require 'active_record/lookup'
class Car < ActiveRecord::Base
  #...
  include ActiveRecord::Lookup
  lookup :car_type, :as => :type
  #…
end
{% endcodeblock %}

That's it. the generated CarType class (which you won't see as a car_type.rb file, obviously, as it is generated in real-time), contains some nice methods to look into the cache as well: So you can call

{% codeblock lang:ruby %}
CarType.id_for "Sports" #Returns 2
CarType.name_for 1 #Returns "Compact"
{% endcodeblock %}

and you can still hack at the underlying ID for an object, if you need to:

{% codeblock lang:ruby %}
car = Car.first
car.car_type = "Sports"
car.car_type_id #Returns 2
car.car_type_id = 1
car.car_type #Returns "Compact"
car.find_car_by_type_and_color("Compact", :blue) #Works, the underlying search is done by the ID
{% endcodeblock %}

The full source code and gem can be found in [https://github.com/Nimster/RailsLookup](https://github.com/Nimster/RailsLookup). The gem is named rails_lookup so you can just `gem install rails_lookup` to get the functionality required.

Note you do need to create tables for the new Type classes. The table format is very simple:

{% codeblock lang:ruby %}
create_table :car_types do |t|
t.string :name
end
add_column :cars, :type, :integer
{% endcodeblock %}

In this post, however, I would like to elucidate how this is achieved, hopefully teaching some ruby meta-programming and rails considerations on the way.

So how do we achieve that? Well, we start with creating our own Lookup module which can be included into active record classes:

{% gist 1129084 %}

This is the basic setup for inserting a new "macro" like belongs_to (which is actually a simple class method). When the Lookup module is included in a class, the ruby interpreter will call the hook method "self.included" with the class this was included into. We ask to also extend this class, thereby adding any class methods defined in ClassMethods into it.

We can now call "lookup :car_type, :as => :type" in our Car class, only that it doesn't do anything. Let's make it do something. We need to achieve the following things:



	
  1. Create the `CarType` ActiveRecord
  2. Link the `CarType` and `Car` ActiveRecords (with the standard has_many, belongs_to link)
  3. Make the `Car#car_type=`, `Car#car_type` methods behave in the way we described above.
  4. (Optional) code-fill the caches when the class loads from the data in the DB


We will now present the code for each - when you read through, remember this all runs in the host class context (e.g. Car) so that self is the Car class, and any actions we take are equivalent to having explicitly written them in the Car class itself.

{% gist 1129091 %}

The important parts to note here are:

  * How we define a new class and then bind it to the constant "CarType" so that after a class containing the lookup (like Car) is referred to (just calling Car.to_s is enough), the CarType is not accessible as if it were inside of a car_type.rb file in our app/models directory.
  * How we use Rails' built-in Inflections module which it mixes in to string, to move from so-called "table_notation" to CamelNotation and vice versa.
  * How we use class_variable_get and class_variable_set to access the class variables of the newly created CarType class - because confusingly enough @@var will refer to the class we're in now and not the one being defined inside the block, when the code is executed. We discuss initialization of these two variables later on, during part (4).

{% blockquote %}
Side note: This is not the complete class definition - I shortened it a bit to remove details which are handled in the gem version, like supporting Rails' where() methods, support anonymous classes that have lookups and supporting multiple classes using the same lookup. If you're interested in these, I urge you to check out the gem.
{% endblockquote %}

Note also that we have already included the has_many link inside of CarType. In the same way, we will include the belongs_to in the other direction. We do this and also define the special accessors for getting and setting the CarType as a String:

{% gist 1129101 %}

The important thing to note here is how we employ ActiveRecord's read_attribute and write_attribute. The data in your ActiveRecord is maintained in a hash called attributes where the names of fields (in the DB) are saved along with their values. A classic setter method like `car.car_type = "Compact"` would set an attribute entry in the hash with :car_type => "Compact", which will later cause SELECT or INSERT statements to try and access the in existing column car_type. Our approach is to intercept every time the 'type' attribute is being written (with a String), and replace that String with a numerical ID (meanwhile creating the corresponding CarType entry if necessary).

Finally, prefill the caches from the DB when this class loads. This is optional but as the list of types is likely to be rather small, a real-time expanding cache is just wasting some user time and could be better done ahead.

{% gist 1129105 %}

That's it. If you don't like the caching this becomes even easier - remove all of the references to @@rcaches and @@caches and you simply saved yourself the trouble of manually maintaining CarType objects.

The only remaining thing is to define your migrations for creating the actual database tables. After all, that's something you only want to do once and not every time this class loads, so this isn't the place for it. However, it's easy enough to create your own scaffolds so that a command like

    rails generate migration create_car_type_lookup_for_car

will automatically create the migration. This is the required migration

{% gist 1129113 %}

I'll let you work out the details for actually migrating the data yourself - this post has already ran long enough. I urge you to read more in the gem's source code [here](https://github.com/Nimster/RailsLookup/). There are some tricks I've omitted to make rails be able to support calls like Car.find_by_car_type_and_color "Compact", :blue (when the actual SQL query should be asking about car_type_id = 1), and some more options for setting the lookup itself, handling Car.where(type: "Compact") or multiple classes using a single lookup.

I hope this helped you and saved a lot of time and frustration. I'd like to thank Aviv for hosting me here. If you don't already, read the rest of his blog, you're sure to learn something useful! Follow me on twitter: [@nimrodpriell](http://twitter.com/nimrodpriell)
