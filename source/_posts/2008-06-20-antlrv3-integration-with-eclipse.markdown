---
date: '2008-06-20 13:49:15'
layout: post
slug: antlrv3-integration-with-eclipse
status: publish
title: ANTLRv3 Integration with Eclipse
comments: true
wordpress_id: '5'
---

I've been working on a pet project of mine, [junit-converter](http://junit-converter.sf.net), recently. It's intended to help people migrate from JUnit 3 to JUnit 4, by adding required annotations and such, but it's far from perfect. junit-converter is based on TestNG's converter that uses Java's Doclet.

For those who aren't familiar with it, Doclet is something that allows you to process annotations added to javadoc comments and things like that, and it has some code-parsing capabilities that are being used in the TestNG converter.

Now, almost a year after publishing the first junit-converter version that's based on the Doclet processing I've come to the decision that there has to be a better way for doing this. I've considered many options that I will write about some other time, but have finally come to the result that [Antlr](http://www.antlr.org) seems like the best candidate out there.

I've been using it for a few weeks now and had some difficulties getting it to work pragmatically with eclipse. The main problem with antlr (and anything else that generates code automatically) is that eclipse isn't aware of the changes and because of that doesn't compile the right files etc'. At the beginning I used to manually run the antlr compiler after every change I've made to the grammar and then refresh the files that were generated in eclipse. This of course was really annoying.

Later, I created an ANT build.xml file that parses the grammar only when needed and ran it manually, which was a bit simpler, but still no winner there.

Then, at last, I came up with the most comfortable configuration so far. I've added to my project another builder (under build preferences), an ant builder. It used my build.xml file and I configured eclipse to build using it every time I save (just like it does with its builtin compiler). After making a few tweaks so it won't compile unless needed it was pretty fast and not annoying (considering the grammar isn't where the majority of the changes are anyway).

So, just in case someone else wants an already ready build.xml file for this purpose I'm attaching mine. Notice that I'm running antlr using the ant execute task as the built-in task in ant doesn't support antlr 3 and I didn't want to add another dependency to my code for the published task on antlr's site.

I hope this helps someone, and if anyone has a better way of doing this I'd like to hear about it!




    
    <span style="color:#a65700;"><</span><span style="color:#5f5035;">target</span> <span style="color:#274796;">name</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">compile</span><span style="color:#0000e6;">"</span> <span style="color:#274796;">depends</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">compile-grammar</span><span style="color:#0000e6;">"</span><span style="color:#a65700;">></span>
        <span style="color:#a65700;"><</span><span style="color:#5f5035;">javac</span> <span style="color:#274796;">srcdir</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">${src}</span><span style="color:#0000e6;">"</span> <span style="color:#274796;">destdir</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">${build}</span><span style="color:#0000e6;">"</span><span style="color:#a65700;">></span>
            <span style="color:#a65700;"><</span><span style="color:#5f5035;">classpath</span> <span style="color:#274796;">refid</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">classpath.base</span><span style="color:#0000e6;">"</span><span style="color:#a65700;">/></span>
        <span style="color:#a65700;"></</span><span style="color:#5f5035;">javac</span><span style="color:#a65700;">></span>
    <span style="color:#a65700;"></</span><span style="color:#5f5035;">target</span><span style="color:#a65700;">></span>
    
    <span style="color:#a65700;"><</span><span style="color:#5f5035;">target</span> <span style="color:#274796;">name</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">compile-grammar</span><span style="color:#0000e6;">"</span> <span style="color:#274796;">depends</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">-check_grammar_needs_compile</span><span style="color:#0000e6;">"</span>
            <span style="color:#274796;">if</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">grammarBuildRequired</span><span style="color:#0000e6;">"</span><span style="color:#a65700;">></span>
        <span style="color:#a65700;"><</span><span style="color:#5f5035;">java</span> <span style="color:#274796;">classname</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">org.antlr.Tool</span><span style="color:#0000e6;">"</span> <span style="color:#274796;">failonerror</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">true</span><span style="color:#0000e6;">"</span><span style="color:#a65700;">></span>
            <span style="color:#a65700;"><</span><span style="color:#5f5035;">arg</span> <span style="color:#274796;">value</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">${grammar-file}</span><span style="color:#0000e6;">"</span><span style="color:#a65700;">/></span>
            <span style="color:#a65700;"><</span><span style="color:#5f5035;">classpath</span> <span style="color:#274796;">refid</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">classpath.antlr</span><span style="color:#0000e6;">"</span><span style="color:#a65700;">/></span>
        <span style="color:#a65700;"></</span><span style="color:#5f5035;">java</span><span style="color:#a65700;">></span>
    <span style="color:#a65700;"></</span><span style="color:#5f5035;">target</span><span style="color:#a65700;">></span>
    
    <span style="color:#a65700;"><</span><span style="color:#5f5035;">target</span> <span style="color:#274796;">name</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">-check_grammar_needs_compile</span><span style="color:#0000e6;">"</span><span style="color:#a65700;">></span>
        <span style="color:#a65700;"><</span><span style="color:#5f5035;">uptodate</span> <span style="color:#274796;">property</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">grammarBuildRequired</span><span style="color:#0000e6;">"</span> <span style="color:#274796;">targetfile</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">${grammar-file}</span><span style="color:#0000e6;">"</span>
            <span style="color:#274796;">srcfile</span><span style="color:#808030;">=</span><span style="color:#0000e6;">"</span><span style="color:#0000e6;">${grammar-java-file}</span><span style="color:#0000e6;">"</span><span style="color:#a65700;">/></span>
    <span style="color:#a65700;"></</span><span style="color:#5f5035;">target</span><span style="color:#a65700;">></span>



