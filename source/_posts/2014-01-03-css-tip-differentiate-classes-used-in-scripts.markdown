---
layout: post
title: "CSS Tip: Differentiate Classes Used in Scripts"
date: 2014-01-03 17:23
comments: true
---

This one is short but so good that I find myself having to reintroduce it in every project I work on and to most developers I work with.

We all know that though CSS is for styling, sometimes we have to use a class to get to an element from JavaScript, e.g. `$('.save-button')`.

The Right Way&trade; to do this is by prefixing those classes with `js-` to differentiate them from "real" classes. Note that this does mean I sometimes will have an element with 2 classes, e.g. `save-button` and `js-save-button`.

#### Why?

  * Never fear removing a CSS classes because it might break some script that's using it
  * Never fear renaming or moving a class when you change scripts because it might break the styles

Happy coding!

{% render_partial _posts/_partials/cta.markdown %}
