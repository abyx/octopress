---
date: '2009-03-27 16:27:53'
layout: post
slug: new-version-of-junitconverter-is-out
status: publish
title: New version of JUnitConverter is out
comments: true
wordpress_id: '18'
categories:
- Programming
- junit
---

I just uploaded the latest version of [JUnitConverter](http://junit-converter.sourceforge.net/) (yeah, I'm no big on design), and thought it would be the right chance to talk about it here.

In the summer of 2007 we, at my workplace, decided to upgrade our (non-legacy) code-bases to use JUnit 4 as part of a move to make people more aware of tests and like writing tests more.

I did some of the organizing work beforehand and saw that most of the migration work is dumb - delete that line, add an annotation there, etc. Not wanting people to get the feeling the that "testing is a dumb, routine, thing" I set out to write something to make things easier and more automated.

After some googling, I stumbled upon TestNG's junit converter which converts junit tests to TestNG tests. Needing a fast solution, I hacked on its code to make it convert junit 3 tests to junit 4 tests and was done with it. The tool was used in our effort and helped (although it wasn't perfect).

During the year and half that have passed since, I've continued working on junit-converter as a pet project. Wanting it to be smarter, and reduce the amount of needed work even more, I came to the conclusion that the smartest thing to do would be to use some Java parsing library (instead of using Doclet). I came across many different options, most of which lacking in strength or very cumbersome. Eventually, I decided using Antlr would be the best choice.

I developed JUC in my spare time, enjoying the different things I wanted to try out (it was done almost fully TDD with very high coverage, and I was always fascinated with antlr). Lately, I thought I'm not doing it justice by not updating the site (a large part is because sourceforge is so not welcoming in the admin mode), so I spent the last few hours tidying things up and creating a new release and uploaded it.

I think it's a good tool for anyone who wants to upgrade his tests, but also can be a good place to see how working with Antlr and Java can be done. Actually, it's one of the most interesting projects I've had the chance to hack with in the last few years.

Congratulations JUnitConverter!
