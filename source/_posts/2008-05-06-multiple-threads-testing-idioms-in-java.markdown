---
date: '2008-05-06 22:26:18'
layout: post
slug: multiple-threads-testing-idioms-in-java
status: publish
title: Multiple Threads Testing Idioms In Java
comments: true
wordpress_id: '4'
categories:
- Programming
---

Today I needed to make a few modification to one of our older Java applications. So, first thing's first - I checked out the latest copy and ran the test suite. Surprisingly enough all the tests passed. But, something wasn't right. I caught the glimpse of a stack trace flipping by in Eclipse's console window. Scrolling up to it I found out an AssertionError was thrown. How come the tests passed?

A little digging revealed this (simplified) test case:

    
        <span style="font-weight:bold;color:#7f0055;">public</span> void buggieTest() <span style="font-weight:bold;color:#7f0055;">throws</span> Exception {
            <span style="color:#3f7f59;">// Do some setup</span>
            <span style="color:#3f7f59;">// ...</span>
    
            <span style="font-weight:bold;color:#7f0055;">new</span> Thread() {
                @Override
                <span style="font-weight:bold;color:#7f0055;">public</span> <span style="font-weight:bold;color:#7f0055;">void</span> run() {
                    <span style="font-weight:bold;color:#7f0055;">int</span> x = 0;
                    <span style="color:#3f7f59;">// Check a few things that change x</span>
                    <span style="color:#3f7f59;">// ...</span>
                    assertTrue(<span style="color:#2a00ff;">"An error"</span>, x > 3); <span style="color:#3f7f59;">// This fails!</span>
                }
            }.start();
    
            <span style="color:#3f7f59;">// Wait for other thread</span>
            <span style="font-weight:bold;color:#7f0055;">Thread</span>.sleep(2000);
        }


Can you spot the bug? The assertion fails, but in another thread. The test is testing an asynchronous module's response. JUnit's test executer isn't aware of threads other than its own, so it thinks everything is OK. For the sake of the original developers I'll mention the fact that they were using a home-built test runner that set ThreadGroups in order to catch those exceptions, but nowadays everyone use Eclipse's JUnit plugin in my work place and that logic is no more.

So, what can we do? I first considered passing a boolean between the two threads so that the test's thread would fail() if the other thread indicated failure. The problem is that the original error is either lost or hard to show.

After some thinking (and because I'm currently reading the great [Concurrent Programming in Java](http://www.amazon.com/gp/product/0201310090?ie=UTF8&tag=thcodu02-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0201310090)![](http://www.assoc-amazon.com/e/ir?t=thcodu02-20&l=as2&o=1&a=0201310090) book) I came up with this simple solution using the JDK Exchanger class:

    
    <span style="font-weight:bold;color:#7f0055;">public</span> void betterTest() <span style="font-weight:bold;color:#7f0055;">throws</span> Exception {
        <span style="color:#3f7f59;">// Do some setup</span>
        <span style="color:#3f7f59;">// ...</span>
    
        <span style="font-weight:bold;color:#7f0055;">final</span> Exchanger<<span style="font-weight:bold;color:#7f0055;">Exception</span>> exchanger = <span style="font-weight:bold;color:#7f0055;">new</span> Exchanger<<span style="font-weight:bold;color:#7f0055;">Exception</span>>();
    
        <span style="font-weight:bold;color:#7f0055;">new</span> Thread() {
            @Override
            <span style="font-weight:bold;color:#7f0055;">public</span> <span style="font-weight:bold;color:#7f0055;">void</span> run() {
                <span style="font-weight:bold;color:#7f0055;">Exception</span> thrown = <span style="font-weight:bold;color:#7f0055;">null</span>;
                <span style="font-weight:bold;color:#7f0055;">try</span> {
                    <span style="font-weight:bold;color:#7f0055;">int</span> x = 0;
                    <span style="color:#3f7f59;">// Check a few things that change x</span>
                    <span style="color:#3f7f59;">// ...</span>
                    assertTrue(<span style="color:#2a00ff;">"An error"</span>, x > 3); <span style="color:#3f7f59;">// This fails!</span>
                } <span style="font-weight:bold;color:#7f0055;">catch</span> (<span style="font-weight:bold;color:#7f0055;">Exception</span> e) {
                    thrown = e;
                }
                <span style="font-weight:bold;color:#7f0055;">try</span> {
                    exchanger.exchange(thrown);
                } <span style="font-weight:bold;color:#7f0055;">catch</span> (<span style="font-weight:bold;color:#7f0055;">InterruptedException</span> ignored) {}
            }
        }.start();
    
        <span style="color:#3f7f59;">// Wait for other thread</span>
        <span style="font-weight:bold;color:#7f0055;">Exception</span> exception = exchanger.exchange(<span style="font-weight:bold;color:#7f0055;">null</span>);
        <span style="font-weight:bold;color:#7f0055;">if</span> (exception != <span style="font-weight:bold;color:#7f0055;">null</span>) {
            <span style="font-weight:bold;color:#7f0055;">throw</span> exception;
        }
    }


So, what's so better about this more complicated version? Well, first of all, it works. We use the exchanger to pass the exception to the testing thread. Another nice benefit is the fact we're throwing the original exception - meaning that Eclipse's plugin shows the right stack trace and clicking it gets you to the actual line that failed and not a simple fail() as opposed to the option I mentioned before.

Do you know of a better way to do this? I'm trying to think whether something can be added to JUnit for this purpose. Anyway, this results in a cool test that works great with the different plugins.

Happy testing!
