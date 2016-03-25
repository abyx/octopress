---
layout: post
title: "Using Angular 1.5's Multiple Transclusion Slots"
date: 2016-03-04 17:59:39 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Learn how to upgrade your Angular 1 app easily, step by step!"
cta_form: 29610
---

Most (well maintained) Angular projects eventually reach the point where they would benefit from having a few generic components that use transclusion.

Maybe you have a timeline feed screen with multiple types of feed items.  
Or some tabs widget.  
Or a generic modal you use across the app.

Transclusion allows us to create very customizable components since you can inject them with other components, and not just pass rigid inputs (e.g. specific bindings).
That’s pretty much how things like ng-repeat work: you provide those directives with inner HTML that they then use.

Prior to Angular 1.5 a component could only transclude a single entry: whatever you gave it was had to be used as a whole.

But, among other goodies introduced in 1.5 we also got *multiple slot transclusion*, which comes in handy at times.

# Example

Say you want to create a generic modal, that can have both the title and body customized.

Here’s an example of someone using the `modal` component we’ll create:

```html
<modal>
  <modal-title>Are you sure {{ $ctrl.name }}?</modal-title>
  <modal-body>
    You can only do this {{ $ctrl.times }} times
  </modal-body>
</modal>
```

Those `modal-title` and `modal-body` elements are the transclusion slots we will now define and use in our `modal` component:

```javascript
app.component('modal', {
  template: [
      '<div ng-transclude="title"></div>',
      '<div ng-transclude="body"></div>'
  ].join(''),
  transclude: {
    title: 'modalTitle',
    body: 'modalBody'
  },
  controller: function() {
    // Stuff to make this component render as a modal
  }
});
```

As you can see above, we define the component’s `transclude` property to have 2 slots, named `title` and `body`.

Each slot also has the name of the element it expects to see its content inside.

Then in the component’s template we can decide where to insert the transcluded elements by using the `ng-transclude` directive and supplying it with the slot’s name.

As you can see transclusion automatically takes care of things like passing the scopes correctly so that even though the templates we passed reference the original component’s scope (`$ctrl`), it’s still properly visible inside.

<hr>

Do you have a big *Angular 1.x app* that you're scared will *rot and become legacy code*? Because 2.0 and TypeScript will soon be *the new shiny* yet you have *all this JS code* sitting there? Where will your team find the time, and *management approval*, to learn and move things to 2.0?

But what if you could *migrate your project*, incrementally, while keeping your time's pace and shipping awesome code? What if your team could learn a bit more Angular 2 with each task? Imagine you could get to be *working in 2.0 land without ever stopping your development*!

I'm cooking up a self-served course that will get you there. It will allow you, *on your own pace*, learn Angular 2 and TypeScript bit by bit. With those steps your team will migrate your project and soon you'll write all your new code with Angular 2, TypeScript, and *won't have to stay behind*.

Sign up to be notified when the course is ready (and get more of these pragmatic Angular posts in the meantime).

{% render_partial _posts/_partials/cta.markdown %}
