---
layout: page
title: "Modern AngularJS Migration Guide"
comments: false
sharing: false
footer: false
cta_message: "Be the first to learn when it's out (soon!)"
cta_form: 226957
style: |
    html {
        border: none;
    }

    header {
        display: none;
    }

    footer {
        display: none;
    }

    body {
        background: rgba(29, 211, 228, 0.05);
    }

    body > nav {
        display: none;
    }

    h2 {
        line-height: 1.3em;
        color: #1dd3e4;
        text-align: center;
        margin-bottom: 1rem;
    }

    article p, article h2, article > ul {
        max-width: 28rem;
        margin-right: auto;
        margin-left: auto;
    }

    article p {
        text-align: justify;
    }

    ul {
        list-style-type: circle;
    }

    .ck_form_container {
        display: none !important;
    }

    .hero {
        margin-top: 2em;
    }

    .hero .hero-intro .header {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .hero .hero-intro .header .book-image {
        background-image: url(/images/mamg_cover.png);
        height: 344px;
        width: 267px;
        background-size: cover;
        flex-shrink: 0;
    }

    .hero:hover .hero-intro .header .book-image {
        transform: rotate(10deg);
        transition: 0.15s all linear;
    }

    .hero .hero-intro .header h1 {
        font-size: 2.5rem;
        line-height: 1.3em;
        color: #1dd3e4;
        padding-right: 0.8em;
        margin: 0;
    }

    .hero .buttons {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 2em;
    }

    .hero .buttons a:first-child {
        margin-right: 1em;
    }

    .cta-btn {
        background: #1dd3e4;
        border: 1px solid #1dd3e4;
        border-radius: 4px;
        font-size: 1.5rem;
        color: white;
        padding: 0.3em 0.5em;
        cursor: pointer;
        display: inline-block;
        transition: 0.15s all linear;
    }


    .cta-btn:hover {
        transform: scale(1.1);
        filter: brightness(1.1);
    }

    .packages {
        padding-top: 2em;
    }

    .packages .package {
        border: 1px solid #1dd3e4;
        border-radius: 4px;
        padding: 2em 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-top: 2em;
        background-color: white;
    }

    .packages .package h3 {
        color: #1dd3e4;
        margin: 0 0 1em;
        font-size: 2rem;
        font-weight: bold;
        text-align: center;
    }

    .packages .package ul {
        max-width: 80%;
    }

    .strike {
        text-decoration: line-through;
        text-decoration-color: red;
        -webkit-text-decoration-color: red;
    }

    .sample {
        display: flex;
        flex-direction: column;
    }

    .sample .cta-btn {
        align-self: center;
    }

    .author {
        margin: 2em 0;
    }

    .author .group {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .author .group .author-image {
        background-image: url(/images/aviv_thumb.jpg);
        background-size: cover;
        width: 200px;
        height: 200px;
        border-radius: 100%;
        max-width: 15vw;
        max-height: 15vw;
        flex-shrink: 0;
        flex-grow: 0;
        margin: 0 2em 0 1em;
    }

    .author .group .author-bio h2 {
        margin-top: 0;
        text-align: left;
    }

    .author .group .author-bio p {
        margin: 0;
    }
---

<div class="hero">
    <div class="hero-intro">
        <div class="header">
            <h1>
                Upgrade to<br>
                <em>AngularJS 1.6</em><br>
                Without a Rewrite
            </h1>
            <div class="book-image"></div>
        </div>
        <div class="buttons">
            <a class="cta-btn" href="#packages">Buy Now</a>
            <a class="cta-btn" href="#sample">Get a Free Sample</a>
        </div>
    </div>
</div>

## You've been maintaining this AngularJS project for a while and it seems to be getting obsolete by the day

You keep hearing about components, and they sound useful, but you’re not sure how to start using them in your existing project, alongside all your controllers and directives.
You worked hard to master AngularJS, yet now even in 1.x the standards are changing:  
"Controllers are dead”  
 "Don't use $scope”  
“Avoid two-way bindings”  
You see this and can’t help but wonder whether _your_ AngularJS is still useful, or is it a dying dialect?

## Keeping up with the old way of doing things is taking a daily toll on your team

It's becoming increasingly harder to find references and people that use AngularJS like you do.
You come across a bug in a library you're using - and hey, there's an updated version that fixes it!
But that simple update becomes a nightmare when you realize it requires updating your AngularJS version, and you fear what that upgrade may break.

## “What exactly is Angular 2 improving upon so much that I need to upgrade?”

What's worse is that you keep hearing about Angular 4 (yeah, 2 is _so 2016_), and don't want to be left out with a bunch of legacy code.
Yet, moving to it seems crazy - it looks nothing like your code.  
And Angular 4 comes with a bunch of questions:  
Should you learn TypeScript?  
Change all your tooling and build system?  
Find alternative packages to replace those you're currently using?

And worse of all, is Angular 4 even going to be popular, or will you spend time and effort learning it just to find yourself in the same spot a year from now?
It feels like a gamble.
You don't need the "new shiny", you need to ship features fast.

It'd be great if your app was once again something you're proud of—a modern codebase with the latest 1.x standards where it's easy to get stuff done...
but you don't know how to get there without a big, long rewrite.

## What if you could work on a modern and clean AngularJS project?

Banging out components, reaping the benefits of better performance and standard design.
You'd get work done faster and just imagine getting there while sticking to your existing deadlines, making your bosses pleased?

Yeah, upgrading your project can feel like a big unknown, with no clear steps to follow, and way too many questions, but it doesn't have to be.

## Learn how to upgrade your project to the latest AngularJS 1.6, with my no-fluff book

Get the **Modern AngularJS Migration Guide** and…

- Update to the latest AngularJS and dependencies safely.
- Understand the conceptual changes AngularJS went through.
- Master components, their new lifecycle hooks, and how they play along with one-way data flow.
- Follow a tried and tested path, with clear guidance.
- Learn all about the changes along 1.0, 1.2, 1.3, 1.4 to 1.6.
- Get the safe and small refactoring steps to get from obsolete controllers to swanky, isolated components.
- See how components affect your unit tests and routing definitions.
- Have a codebase that's future-proof and compliant with a transition to Angular 4, should you ever choose to move to it later on.

## Get a step by step guide for migrating to a modern codebase as you keep working

Imagine: answers on Stack Overflow actually being relevant, free performance improvements from latest updates, all feasible without risk and a big rewrite break.

To learn the quickest and safest way to work on a modern and maintainable codebase again - buy the **Modern AngularJS Migration Guide**.
Then you'll master the gradual approach for transitioning even the bigger projects, cool as a cucumber, and at your own pace.

<div class="packages" id="packages">

    <div class="package">
        <h3>The Complete Consulting Package</h3>

        <ul>
            <li>The detailed <strong>migration guide</strong> (95 page PDF)</li>
            <li>A <strong>consulting session</strong> with the author to plan your tailored migration (<span class="strike">$800</span> value)</li>
            <li>Email availability for questions for 2 months</li>
            <li>Get a triest and tested migration path</li>
            <li>Upgrade your app on-the-go</li>
        </ul>

        <button class="cta-btn">Buy Now for <span class="strike">$600</span> $500</button>
    </div>

    <div class="package">
        <h3>Just the Book</h3>

        <ul>
            <li>The detailed <strong>migration guide</strong> (95 page PDF)</li>
            <li>Get a triest and tested migration path</li>
            <li>Upgrade your app on-the-go</li>
        </ul>

        <button class="cta-btn">Buy Now for <span class="strike">$49</span> $39</button>
    </div>

    <div class="package">
        <h3>Corporate Team Package</h3>

        <ul>
            <li>Everything from the <em>Complete Consulting Package</em></li>
            <li>License for <strong>20 developers</strong></li>
            <li>Get your whole team on the same page</li>
        </ul>

        <button class="cta-btn">Buy Now for <span class="strike">$1999</span> $1499</button>
    </div>

</div>

<div class="sample" id="sample">

    <h2>Get a Free Chapter</h2>

    <p>
        Not convinced this book's right for you yet?
        That's ok.
        You can get a sample chapter free directly to your inbox.
    </p>

    <button class="cta-btn">Get Your Free Sample</button>

</div>

<div class="author">
    <div class="group">
        <div class="author-image"></div>
        <div class="author-bio">
            <h2>About the Author</h2>
            <p>
                Hey there, my name's Aviv Ben-Yosef.
                As part of my consulting business, I've helped dozens of companies with their AngularJS projects over the last 4+ years.
                With my courses, trainings and articles I've literally helped over a million developers, and have one of the biggest AngularJS newsletter, with over 6,000 subscribers.
            </p>
        </div>
    </div>
</div>

{% render_partial _posts/_partials/cta.markdown %}
