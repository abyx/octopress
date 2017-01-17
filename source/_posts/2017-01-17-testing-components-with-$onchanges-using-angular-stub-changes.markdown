---
layout: post
title: "Testing Components with $onChanges Using angular-stub-changes"
date: 2017-01-17 09:52:02 +0200
comments: true
facebook:
    image: /images/ng-codelord.png
cta_message: "Subscribe to get the latest about modern Angular 1.x"
cta_form: 153706
---

My [previous post](http://www.codelord.net/2017/01/09/unit-testing-angular-components-with-$componentcontroller/) showed how to set up a component’s controller for unit testing using the `$componentController` service.
We also learned that Angular doesn’t trigger the different [lifecycle hooks](http://www.codelord.net/2016/04/14/angular-1-dot-5-new-component-lifecycle-hooks/) by itself, meaning that you need to manually call `$onInit`, etc.

In this post I’ll show an example for testing a component that makes use of the `$onChanges` hook.

Take a look at this simple word-counting component’s `$onChanges` hook:

```javascript
app.component('wordCount', {
  template: `
    <div>
      <span ng-bind="$ctrl.words"></span> words
      <span ng-if="$ctrl.difference">
        <span ng-bind="$ctrl.difference"></span>
        since last save
      </span>
    </div>
  `,
  bindings: {
    text: '<'
  },
  controller: function() {
    this.$onChanges = (changes) => {
      if (changes.text) {
        this.words = countWords(this.text);
        if (changes.text.isFirstChange()) {
          this.difference = 0;
        } else {
          this.difference =
              this.words - countWords(changes.text.previousValue);
        }
      }
    };

    function countWords(text) {
      var trimmed = text.trim();
      if (trimmed.length === 0) return 0;
      return trimmed.split(/\s+/).length;
    }
  }
});
```

As you can see, the hook uses the `changes` object in order to know when the text has changes, detect the initial change, and also use the `previousValue` to calculate the word difference (yes, I know we could use the old `words` value, but this is just for the example).

You can see the component live [here](http://plnkr.co/edit/r8ndH3ZwfXkJCZ8ccwfe?p=preview).

Now, testing this component is relatively trivial.
We simply need to pass it some different values for `text`, trigger `$onChanges`, and that’s it.
But, the fact is that Angular, for some reason, doesn’t expose the changes object it uses internally.
That means that you’ll have to implement your own object that conforms to the `changes` object protocol–each changed property needs an `isFirstChange` method and 2 properties, `currentValue` and `previousValue`.

Since that’s a PITA, I’ve open sourced a tiny helper just for that, [angular-stub-changes](https://github.com/abyx/angular-stub-changes).

Using it, our tests now look like this:

```javascript
describe('wordCount component', function() {
  var ctrl;

  beforeEach(function() {
    angular.mock.module(app);
    angular.mock.inject(function($componentController) {
      ctrl = $componentController('wordCount', null,
                {text: '1 2 3'});
    });
  });

  it('counts words', function() {
    var changes = new StubChanges().addInitialChange(
        'text', '1 2 3').build();
    ctrl.$onChanges(changes);

    expect(ctrl.words).toBe(3);
  });

  it('does not show difference when initializing', function() {
    var changes = new StubChanges().addInitialChange(
        'text', '1 2 3').build();
    ctrl.$onChanges(changes);

    expect(ctrl.difference).toBe(0);
  });

  it('calculates difference when changing text', function() {
    var changes = new StubChanges().addInitialChange(
        'text', '1 2 3').build();
    ctrl.$onChanges(changes);

    ctrl.text = '1 2 3 4 5';

    changes = new StubChanges().addChange(
        'text', '1 2 3 4 5', '1 2 3').build();
    ctrl.$onChanges(changes);

    expect(ctrl.difference).toBe(2);
  });
});
```

Basically, note that we make sure to call `$onChanges` with a properly configured changes object.
Also, you still have to set the updated properties on your controller instance yourself, e.g. `ctrl.text = '...'`.

The creation of the stub changes object is, I hope, straightforward.
It’s a builder pattern, so you can keep on adding how many changes (`.addChange(..).addChange(..)`) as needed for your component 

That’s about it, happy testing!

<hr>

You want to do Angular *the right way*.  
You hate spending time working on a project, only to find it's completely wrong a month later.  
But, as you try to get things right, you end up staring at the blinking cursor in your IDE, not sure what to type.  
Every line of code you write means making decisions, and it's paralyzing.  

You look at blog posts, tutorials, videos, but each is a bit different.  
Now you need to *reverse engineer every advice* to see what version of Angular it was written for, how updated it is, and whether it fits the current way of doing things.

What if you knew the *Angular Way* of doing things?  
Imagine knocking down your tasks and spending your brain cycles on your product's core.  
Wouldn't it be nice to know Angular like a second language?

You can write modern, clean and future-ready Angular right now.  
Sign up below and get more of these helpful posts, free!  
Always up to date and I've already done all the research for you.

And be the first the hear about my Modern Angular 1.x book - writing future proof Angular right now.

{% render_partial _posts/_partials/cta.markdown %}
