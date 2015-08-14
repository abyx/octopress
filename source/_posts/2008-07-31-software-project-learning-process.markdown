---
date: '2008-07-31 23:36:04'
layout: post
slug: software-project-learning-process
status: publish
title: Software Project Learning Process
comments: true
wordpress_id: '8'
---

Recently, a new guy has joined my team and is in the process of taking over one of the systems that's currently in my control. The guy, as most of the other people in my workplace, is the product of the organization's own "[Java School](http://www.joelonsoftware.com/articles/ThePerilsofJavaSchools.html)" ("WHY?", you're yelling to yourself? That has to do with the special properties of my workplace, which can't really be disclosed).

Anyway, I've tried to write down the points I think a person must control before being able to really lead a project, and would really like feedback on these.

Here it is, the Software Project Learning Process:



	
  * Understand the project's version control and release management - be able to check it out and build it.

	
  * Be able to sketch the flow of the system.

	
  * _Read the code_ of the main parts.

	
  * Run the tests. If you're out of luck - find out exactly which ones are known not to pass and why.

	
  * Know how to deploy and run the project (especially relevant in legacy systems that are not changed often).

	
  * Meet your clients. If your project connects with others' (you receive input from Steve's system, say), meet them too.

	
  * Know your project's different input and output mediums (protocols with other systems, input file formats, etc).

	
  * Understand other resources in your project (special files used, the database scheme, etc).

	
  * Be able to tweak your project using its different configuration options.


These are obviously not ordered by importance, as that varies between projects. I have found this list helpful in the last couple of years whenever I've had to get someone new up and running with one of our systems.

Cheers!
