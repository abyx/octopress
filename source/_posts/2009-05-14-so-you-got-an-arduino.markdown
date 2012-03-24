---
date: '2009-05-14 23:19:47'
layout: post
slug: so-you-got-an-arduino
status: publish
title: So You Got an Arduino
comments: true
wordpress_id: '42'
categories:
- Programming
- arduino
---

After playing around a bit with my new Arduino, I've gathered a list of a few things that I wish I knew when I started, as it would have saved some of my time. Hope it helps someone. Happy hacking!

#### There's a builtin LED
This one I didn't get right away. There's a reason most of the examples in the tutorial sections refer to LEDs on pin 13 - there's a small LED on the Duemilanove that's already connected to that pin. It shines in orange (just like the TX/RX LEDs) if you write to that pin, but, of course, one can connect something else to that pin to use it.

#### That little button is the RESET button
This one might just be me being an idiot. I thought that little push button was a general purpose one. Well it's not. It's a reset button - whenever it gets pressed it resets the sketch running to the start. Boy, did I spend a lot of time pressing it and trying to debug my code til I figured it out...

#### There are builtin "software" pull-up resistors
Once you get you should connect a push-button, you might notice that every tutorial says you should use a pull-up resistor. Well, it turns out you can simply use a software one on the Arduino, and there's no need to conenct one. After setting up the push-button pin as input:

    pinMode(buttonPin, INPUT);

Simply tell the Arduino you need a pull-up resistor connected to it:

    digitalWrite(buttonPin, HIGH);

For more information, read [here](http://www.arduino.cc/en/Tutorial/DigitalPins).

#### The "Serial" library doesn't really require a serial connection
Even though Duemilanoves and other new Arduino-boards only have a USB connection, it turns out that the Serial library can still be used. Whatever you write using it shows up in the Serial Monitor in the development IDE and you can send data to the Arduino using it too!


You should follow me on twitter [here](http://twitter.com/avivby).
