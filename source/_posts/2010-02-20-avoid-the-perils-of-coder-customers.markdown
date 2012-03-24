---
date: '2010-02-20 21:44:29'
layout: post
slug: avoid-the-perils-of-coder-customers
status: publish
title: Avoid the perils of coder customers
comments: true
wordpress_id: '132'
categories:
- Programming
- tips
---

﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿Coders are the worst customers ever. The sooner you wrap your head around that, the better. Actually, any customer that's technical is a bad customer, but nothing trumps coders. That fact is not intuitive, or at least wasn't for me, but it can be really painful to find it out by yourself. So here, I just saved you some agony.

Why are coders bad customers? First, let me say that even though coder-customers are a hard group to work with, they usually have really interesting problems to solve. After all, if it was simple they'd usually do it themselves. But, being coders, they think it's acceptable to tell you how to do your job.

When you work with coders, the usual ticket/email/water-cooler chat will be of the form "you need to add an option for specifying X of type Y instead of the current options". At this point they'll usually start telling you how to implement that and how easy it is. If you're like me, at this point your instinct will be to crank out the code and make your customer happy. Resist that urge like the plague!

Whenever I receive such a ticket, I dismiss everything in it. What I do next is come up to whoever suggested it, and ask "**What is it that you're trying to do?**" Usually, this will result in exactly the same technical do-this-and-that explanation. Take a deep breath and ask the question again. This will usually be enough, but sometimes may require a couple more tries. That's how you're supposed to gather requirements - **understand the problem at hand**.

The main advantage of being a pain-in-the-ass and making sure you understand what it is you're supposed to implement is because every coder should know exactly what his code is doing. A lot has been said about understanding the domain you're working in, and simply implementing things handed to you is not the way to become knowledgeable in your domain.

Furthermore, once you hear what people are trying to do you might think of a better way of doing it, you being fully immersed in the existing code. Actually, more often than not you'll see it's actually already possible to do it! And best of all, you might simply decide that's not a fair use of your code, and reject the ticket. How could you have made such a decision without knowing the actual problem you were asked to solve? No way.

Saying "no" to features is one of the most important design skills to master, and a tricky one. After all, turning to your keyboard, hacking the code and saying "presto!" is more fun at first. But that way of working leads to a code-base that you don't really know. I've seen systems that were driven this way by technical users. 3 years later, there were rogue database fields that no one knew why there were being updated, and weird log files in awkward formats. Whenever someone tried removing one of those he found out it broke some dusty cron-job that seemed to use it instead of doing something sane (and do I really need to mention the code was a tangled, convoluted mess?).

Ask why, mindfully consider and then decide. There's no really other way, unless you'd like to meet Code Cthulhu.

You should follow me on [twitter](http://bit.ly/aU2CaB).
