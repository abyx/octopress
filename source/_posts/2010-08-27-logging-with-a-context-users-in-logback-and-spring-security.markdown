---
date: '2010-08-27 19:14:17'
layout: post
slug: logging-with-a-context-users-in-logback-and-spring-security
status: publish
title: 'Logging with a Context: Users in Logback and Spring Security'
comments: true
wordpress_id: '214'
---

During this hectic time of starting an amazing adventure we find that along many of the big and important challenges we have there is an endless stream of small technical problems that solving poorly means a lot of time will go to waste.

One of these is proper logging in a way that will allow you see what your users are doing properly. Pretty quickly we came to the conclusion we want each log message to contain information about the user's context, so we could easily understand what went wrong when a user tells us about it, and be able to track usage patterns.

The simplest thing we thought of was creating our own logger wrapper to insert our special values, but didn't like the idea of having to write our own logging interface all over again. We're using Logback and Spring Security, and after some googling and stackoverflowing I've found this solution:

We create simple Converters to insert the username and session ID to the logs, if present:

{% gist 553724 SessionConverter.java %}
{% gist 553724 UserConverter.java %}

To make logback know where to find these converters, we add this little guy:

{% gist 553731 %}

And now all that's left are configuration changes. Make your pattern contain our cool new keys ("%user" and "%session"):

{% gist 553738 %}

And this last part is needed for the session context thingie to work (as I was instructed on [Stack Overflow](http://stackoverflow.com/questions/3542026/retrieving-session-id-with-spring-security)). We need to add a certain listener to our web.xml:

{% gist 553742 %}

And that's about it. Happy logging!
