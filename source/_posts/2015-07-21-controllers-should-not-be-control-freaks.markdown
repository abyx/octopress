---
layout: post
title: "Controllers Should Not Be Control Freaks"
date: 2015-07-21 23:23:01 +0300
comments: true
facebook:
    image: /images/posts_images/angular-thin.png
---

It's super easy to get baffled about what *should* you put inside your controllers. Especially if your background is with frameworks touting MVC, you might think that the name "controller" in Angular indicates some kind of *control*.

The idiom in Angular is to keep your controllers extremely thin. That is the common paradigm, and also the general direction things are going as you can see in this [great and common style guide](https://github.com/johnpapa/angular-styleguide), the introduction of ["controller as" syntax](http://toddmotto.com/digging-into-angulars-controller-as-syntax/) and with [Angular 2's upcoming removal of controllers](http://boyan.in/angular-2-no-controllers/).

Let's try to make sense of the controllers' valid responsibilities.

# Why keep controllers thin?

First and foremost, writing your code this way results in more *maintainable code*. When you don't watch out, controllers tend to become tangled beasts that take on too much responsibility. This makes it extremely hard to test them properly, reuse stuff and is just bad programming as agreed by everyone who's heared of the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle).

Also, I already mentioned that *Angular 2.0 is dumping controllers*. No, you should not [start working in 2.0](http://www.codelord.net/2015/06/27/should-you-use-angular-2-dot-0-or-1-dot-x/) now or worry about it too much, but it does make sense to be aware of where things are headed and to start accepting the lessons the Angular community has learned and accepted.

# What should not be in controllers?

Getting technical, let's start with all the things that you should probably not put in your controllers.

- **HTTP stuff**: Probably the easiest way to get scolded on an Angular forum these days is to share code that's performing `$http` calls directly from your controllers. It has become common practice to hide this inside services as well, even if some Angular documentation has examples doing otherwise. Having a specific service for handling the requests of a certain aspect (e.g. a REST resource) means that you can easily find everyone that's using it and can make changes in a single place in case the server's representation of the object changes. Software engineering, who would've thought.
- **DOM manipulation**: There's a reason that controllers don't have access to their element easily. That's because DOM access is reserved to directives in Angular. You probably know this already, but still.
- **Complex view logic**: While controllers are bound to views and end up managing them, if you notice that your logic is become complex you should consider pushing it outside to a specific directive or maybe put some of the logic in a specific service.
- **Model logic**: Most controllers are responsible for manipulating/displaying a specific model and tend to take on the responsibility for managing that model. You should take that logic outside of the controller, preferably into a Model object that is a good old object. Yes, even though Angular doesn't have an `angular.model()` function it doesn't mean you can't still have them. Just create plain JavaScript classes or even use a service to declare the class of your models.
- **Business logic**: Business logic is important, changes a lot, and usually will be reused across multiple controllers as your app grows. Because of this it makes a lot of sense to create specific services for the different aspects of your business logic and use them from your controllers. This makes the logic easily testable and reusable.

# What *should* be in controllers?

Controllers with Angular-zen spirit should essentially map actions from the view to the different models and services, with as little logic as possible. Most of your controllers should be basic delegation once they've set up the view model on initialization.

In a way, good controllers *let go of control!*

# An example

```javascript
angular.module('tasks').controller('TasksCtrl', function($scope, $http) {
    var vm = this;
    
    function activate() {
        // Bad controller! Don't access $http!
        $http.get('/tasks').then(function(response) {
            $scope.tasks = response.data;
        });
        
        // Much better - use a service:
        TasksStore.getAll().then(function(tasks) {
            vm.tasks = tasks;
        });
    }
        
    activate();
    
    $scope.showDueSoonTasks = function() {
        // Bad controller! This is business logic!
        $scope.tasks = _.filter($scope.tasks, taskDueDateIsIn(2, 'DAYS'));
        
        // Much better - put the business logic somewhere else
        vm.tasks = TasksPrioritizer.getDueSoon(vm.tasks);
    };
    
    $scope.snoozeTask = function(task) {
        // Bad controller! Stop reaching into your models!
        if (task.dueDate < now()) {
            task.dueDate = addDate(task.dueDate, 2, 'DAYS');
        }
        
        // Better - use real models with responsibility:
        task.snooze();
    };
});
```

Keep (cont)rolling!

{% render_partial _posts/_partials/book_cta.markdown %}
