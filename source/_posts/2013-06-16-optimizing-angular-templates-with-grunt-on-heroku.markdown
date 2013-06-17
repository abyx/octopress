---
layout: post
title: "Optimizing Angular Templates with Grunt on Heroku"
date: 2013-06-16 22:37
comments: true
alias: /2013/06/16/optimizing-anagular-templates-with-grunt-on-heroku/
categories: 
- Programming
- angular
- angularjs
- heroku
---

So it's been a few months now of developing with AngularJS and we finally needed to do some optimizing. Specifically, we felt the need to bundle the dozens of separate HTML template files into a single file to save time on roundtrips to the server (especially with the latency heroku's servers are showing in Israel).

Some googling showed that the best solution would be to use [Grunt](http://gruntjs.com/) with [grunt-angular-templates](https://github.com/ericclemmons/grunt-angular-templates). Since we couldn't easily find a complete example for Grunt newbies, I thought I'd share what we came up with. It might not be perfect, but it seems to work!

First we created a `package.json` file with the needed grunt dependencies and made sure to add a `postinstall` step that runs grunt. Turns out that heroku's node buildpack runs that step after each deploy:

{% codeblock package.json lang:javascript %}
{
  "name": "MyApp",
  "version": "0.1.0",
  "dependencies": {
    "grunt": "~0.4.1",
    "grunt-cli": "~0.1.9",
    "grunt-contrib-jshint": "~0.1.1",
    "grunt-contrib-nodeunit": "~0.1.2",
    "grunt-angular-templates": "~0.3.8"
  },
  "scripts": {
    "postinstall": "./node_modules/grunt-cli/bin/grunt"
  }
}
{% endcodeblock %}

And then we just created a straightforward `Gruntfile.js` with the appropriate options for grunt-angular-templates specifying which files to bundle and where and the grunt boilerplate for telling it to run that task by default:

{% codeblock Gruntfile.js lang:javascript %}
module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    ngtemplates: {
        myapp: {
            options: {
                base: "web",
                module: "app",
            },
            src: "web/templates/**/*.html",
            dest: "web/js/templates.js"
        }
    }
  });

  // Load the plugin
  grunt.loadNpmTasks('grunt-angular-templates');

  // Default task
  grunt.registerTask('default', ['ngtemplates']);

};
{% endcodeblock %}

And that's it!

Also, if by any chance you, like us, don't use Node for the server but still want to use the node buildpack for grunt'ing stuff for the client-side, and still need some stuff for the server buildpack, there's a solution for you! There's a buildpack called [heroku-buildpack-multi](https://github.com/ddollar/heroku-buildpack-multi) that allows you to use multiple buildpacks for your project. Just switch your project to use it and then create a matching `.buildpacks` file. For example, for our Python tornado + Angular project it looks like:

{% codeblock .buildpacks %}
https://github.com/heroku/heroku-buildpack-python.git
https://github.com/heroku/heroku-buildpack-nodejs.git
{% endcodeblock %}

Have fun! For more in-depth Angular stuff you might find [this book](http://www.amazon.com/gp/product/B00CJLFF8K?ie=UTF8&camp=213733&creative=393177&creativeASIN=B00CJLFF8K&linkCode=shr&tag=thcodu02-20&qid=1371412376&sr=8-2&keywords=angularjs) useful.

<!-- Begin MailChimp Signup Form -->
<link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
       We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Subscribe to my mailing list for exclusive updates</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline">
    <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
</form>
</div>
<!--End mc_embed_signup-->
