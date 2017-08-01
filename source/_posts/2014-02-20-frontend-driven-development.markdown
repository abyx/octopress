---
layout: post
title: "Frontend Driven Development"
date: 2014-02-20 21:51
comments: true
---

For years, whenever I worked on a new feature I would first figure out the backend and get a rough implementation of the server side solution. Only then would I move on to the other parts.

I think this was because the backend is the part that does the heavy lifting. When you don’t start from the backend, it is easy to find yourself planning features that require way too much from the server. Therefore starting with the backend made sense.

For the past year or so I've been doing it backwards - getting the frontend roughly working first: Frontend Driven Development (I kinda hate myself for naming it this way, but I believe it gets the point across).

## The Joy

This change brings about many interesting improvements to our feature development:

First, it means we start from a point that's backend implementation agnostic. This way we focus on the right UX and flow before giving in to how technical difficulties and limitations. Some changes might be needed later, but I find it better to start design, pretending we have an “ideal world”.

Also, no matter how much design work has gone into a feature, a lot of changes and criticism would only appear once you have the UI almost done. When the team sees the feature it shoots off iterations that delay the deployment of the feature. With FDD the feature's basic version is there to play with and tweak very early, and while the backend part is being implemented the iterations take place.

I saw designers and product people loving having a bit more time to play with the feature with less stress, since they got started with iterations earlier and didn’t hold up the feature from deployment.

Another advantage is that, usually, the frontend is the most flexible part of the system. Now you allow for more short & easy experiments, even those that are never fully implemented, without wasting time developing a backend that'll never be used or that limits the experiments you make.

## Why didn't I do this earlier?

I believe it's mainly because working on the frontend when the backend's not there yet can be a pain. You either stub a lot of code in the frontend, or hard code dummy endpoints on the server, both of which are ugly and a PITA to maintain.

Whatever your environment, be it web or mobile, I bet you can make sure working on the frontend disconnected from the backend is easier, and let your team get stuff done faster!

Happy coding!

{% render_partial _posts/_partials/book_cta.markdown %}
