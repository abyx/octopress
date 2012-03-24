---
date: '2009-02-26 23:37:51'
layout: post
slug: sending-sms-using-google-calendar-and-the-python-api
status: publish
title: Sending SMS using Google Calendar's python API
comments: true
wordpress_id: '17'
---

Soon another semester will start. And, like every semester, I received the list of assignments that are due, with their deadlines. Up till now I used to type into Google Calendar each deadline and set SMS reminders, to make sure I won't forget to hand the assignment, but this time I realized I've had enough of this, and don't feel like entering 30 different tasks over and over again, set the sms reminders etc.

So I figured _'Google has an API for everything, why not automate it?'_ So I opened their [tutorial](http://code.google.com/apis/calendar/docs/1.0/developers_guide_python.html) and started reading. Just about all the information was there, other then information on setting a reminder's type (pop up, sms, email etc').

I've read the python API code, and couldn't find a reference for this. Googling for it I saw a few people mentioning it and saying the easiest solution is setting the default reminder type to SMS and then using the samples in the tutorial.

After looking a little harder I saw the JavaScript API let's one set this type (in the API it's 'method'), so I ran a javascript test and sniffed it just to make sure it's a simple attribute. After seeing that is the case I came to the conclusion that all that's needed to set the 'method' of a reminder is this:

    reminder = gdata.calendar.Reminder(minutes='40')
    reminder._attributes['method'] = 'method'
    reminder.method = 'sms'
    event.when[0].reminder.append(reminder)

Those two bold lines do the trick, where method can be 'all', 'sms', 'email' and 'alert' (meaning a pop-up).

Happy SMSing!

You should follow me on twitter [here](http://twitter.com/avivby).
