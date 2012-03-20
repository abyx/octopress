---
date: '2010-08-20 18:35:04'
layout: post
slug: unleashing-your-enthusiasm-grunts-making-a-change
status: publish
title: 'Unleashing Your Enthusiasm: Grunts Making a Change'
comments: true
wordpress_id: '207'
categories:
- Programming
tags:
- clean code
- Programming
- software craftsmanship
- tdd
---

I've been doing retrospection and navel-gazing lately, after deciding to join a [new adventure](http://crowdspot.com/) and leaving an awesome job. I had the chance to work in XIV-IBM for just over a year, and it being my first real job I was thinking of how satisfied I am with my work there.

As I've mentioned in previous posts, it's not easy taking the software craftsmanship road when joining a team with a large code base and practically zero tests. I joined in order to help introduce automated testing to the team's development process, but making these changes is never easy.

I recently read an amazing book called [Apprenticeship Patterns](http://www.amazon.com/gp/product/0596518382?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0596518382)![](http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0596518382), which collects the different patterns we share in our industry on our track to professionalism. Of those patterns, reading ["Unleash Your Enthusiasm"](http://bit.ly/bSaaTF) suddenly made me understand more clearly what I've been doing that year.

When I just joined the team, I naturally tried to get the vibes of the team and "go with the flow". The first small projects I did on my first few weeks to get my feet wet weren't a craftsman's best work, to say the least. I barely wrote any tests, and since Python doesn't have decent refactoring tools, that made me refactor less. After a couple of weeks I was already getting angry with myself, and once I noticed thinking of changes to the code made me twitch it was clear something was wrong (after all we're all for "embracing change", aren't we?).

I decided to return to the good path. Catching up on some best practices for unit testing in Python and adopting once more the Red-Green-Refactor cycle did the trick for me. I haven't stopped TDDing since and didn't look back. But here is where the story got more interesting.


[![](http://codelord.net/wp-content/uploads/2010/08/crowdsurfing1-300x225.jpg)](http://codelord.net/wp-content/uploads/2010/08/crowdsurfing1.jpg)


Working on a project mainly by myself meant I had it easy in making sure the code base is tested the way I liked it. My manager thought, as a good manager does, that as long as the outcome is good he shouldn't care if I do something no one else on the team does. This allowed me to have my fun, but still something was missing. I really found it hard seeing my teammates having troubles that could have been easily avoided with a good suite of tests. More than once I saw people in a debugging spiral or fighting a refactoring gone wrong.

Being the loud-mouth that I can be, I made sure to help people see how much fun I had writing code as code was meant to be written. Parading my Clean Code wristband, posting [certain](http://agilemanifesto.org/) [manifestos](http://manifesto.softwarecraftsmanship.org/) on the walls and sending the team links or snippets was a good start.

After a while, some people wanted to hear more. I gave a unit testing talk that pretty much got people hooked after I deleted random lines of code and showed them the tests captured it every time, and the knock out was Gary Bernhardt's [awesome kata](http://bit.ly/9QyUAj) that showed TDD won't slow you down.

Seeing that team's lack of testing slowly transforming to a suite of tests that kept getting closer and closer to the [FIRST principles](http://bit.ly/dgDfnr) made me understand how a young developer can really unleash his enthusiasm to make real changes happen. No one has made the jump to TDD yet, but I think the whole team can be proud for adding hundreds of tests to their code base in less than a year. Remember, if you work with excellent people, sometimes [all it takes is a little push](http://www.codelord.net/2009/04/04/sometimes-all-it-takes-is-a-little-push/) to get them on a better track.

This taught me yet again that being a craftsman is about sticking to your principles. Craftsmanship of Crap all the way.

You should subscribe to my [feed](http://feeds.feedburner.com/TheCodeDump) and follow me on [Twitter](http://twitter.com/avivby).
