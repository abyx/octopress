---
layout: post
title: "My First 5 Minutes Learning AngularJS"
date: 2013-03-23 10:52
comments: true
categories: 
- Programming
---

There's been [some](https://news.ycombinator.com/item?id=5406857) [debate](https://news.ycombinator.com/item?id=5424419) [online](https://twitter.com/wycats/status/315177556305408001) this week about how hard or easy it is to learn Ember. It just so happened that a couple of days ago I spent a couple of hours starting to learn about AngularJS and I thought I'd share how the first 5 minutes went.

I started learning with the nice screencasts on [Egghead.io](http://egghead.io). I then reached a screencast with the following code snippet:

{% codeblock lang:javascript %}
var myApp = angular.module('myApp', []);
myApp.factory('Data', function () {
    return {message:"I'm data from a service"};
});

function FirstCtrl($scope, Data) {
    $scope.data = Data;
}

function SecondCtrl($scope, Data) {
    $scope.data = Data;
}
{% endcodeblock %}

In that code, it's explained, we define what "Data" is and when AngularJS sees a controller that uses `Data`, such as our `FirstCtrl` and `SecondCtrl`, it will inject it. At this point my partner and I stopped in our tracks together and noticed some unknown magic is happening. After all, neither of us knew of a way in JavaScript to see how a function's arguments are named, and so how can AngularJS use that for injecting?

After googling a bit we came across a [StackOverflow answer](http://stackoverflow.com/a/9924463/573) that said a function's `toString` method can be used to parse out the argument names. Staring at each other puzzled, we didn't want to believe it, saying there's no way that's what's going on. Then he suggested I override `FirstCtrl.toString` and lo and behold, the injection broke.

Now that's some magic that I joked was "even too much for DHH", and I find it hard to believe anyone that knows a bit of JavaScript can start learning AngularJS without going through what we just did. But then, we realized something more.

Most sites, on production, minify js files in a way that mangles names. How is that supposed to work with this sorcery? Googling some more we found in the [AngularJS docs](http://docs.angularjs.org/tutorial/step_05) that there's simply a workaround, a different syntax that's used in a way that survives minification.

Now don't get me wrong, I'm just starting to get to know AngularJS, and it looks like it has some really nice features, but having to go through this whole ordeal the first 5 minutes I'm learning something new, only to realize that syntax is actually useless and that I'll never use it, is weird. It made me feel as if someone wanted to put in a "cool" feature, and when they noticed it actually won't work for most production uses they left it in for the coolness factor, instead of removing it.

The bottom line is, no project is perfect, and usually once you've already learned something, it looks so much simpler than the rest!

You should [follow me](http://twitter.com/avivby) on twitter!
