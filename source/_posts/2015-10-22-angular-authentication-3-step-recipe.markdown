---
layout: post
title: "Angular Authentication: 3 step recipe"
date: 2015-10-22 18:26:44 +0300
comments: true
facebook:
    image: /images/ng-codelord.png
---

Authentication seems like something that literally 100% of people using Angular would want to do. Yet you need to bake something on your own not knowing if your approach is right. Angular doesn’t come with any baked support for authentication. (Did that surprise you? It surprised me the first time I heard.)

But I have some good news for you: getting started with authentication is pretty easy. Here’s my basic recipe.

Say you have a simple username/password login. To login you make a request to the server which then either sets a cookie for you or returns some token you need to add to all your following requests.

To get started you need to take care of just 3 things:

1. Logging in
2. Passing credentials in every request
3. Redirecting to login when the session expires

Let’s dig in.

# Logging in

This is pretty straightforward. All you need to do is make a request that 99% of the time looks like this:

`$http.post('/login', {user: user, password: password})`

And that’s that.

# Passing credentials

Depending on how your authentication works this will change a bit. If the server sets a cookie in the response to a successful login request, you’re done.

In other cases you get a token from your server. Then you need to make sure future requests use it. Your code will probably look something like this:

```javascript
angular.module('app').factory('Authenticator', function($http) {
  return {
    login: function login(user, password) {
      return $http.post('/login',
                        {user: user, password: password})
        .then(function(response) {
          $http.defaults.headers.common['X-My-Auth-Header'] = response.data.token;
      });
    }
  };
});
```

This makes sure that once you receive a good token you’ll pass that token along with all your future requests. Simple as that!

# Redirecting to login

All your requests now pass their authentication token/cookie. Everything is *fine*.

But, eventually it will stop working, e.g. your sessions expire after 2 hours. What will happen if the browser was open the whole time?

Ideally, the next time you make a request, the server will respond with a 401 status code. That will let you know that you’re no longer authenticated.

Now, you just need to take the user back to the login page. Angular has a nifty tool just for this purpose: [HTTP interceptors](https://docs.angularjs.org/api/ng/service/$http#interceptors). These let you write code that executes whenever you get a certain response.

```javascript
angular.module('app').factory('AuthInterceptor', function($state, $q) {
  return {
    responseError: function responseError(rejection) {
      if (rejection.status === 401 && rejection.config.url !== '/login') {
        $state.go('login');
      }
      return $q.reject(rejection);
    }
  };
});

angular.module('app').config(function($httpProvider) {
  $httpProvider.interceptors.push('AuthInterceptor');
});
```

What’s going on here? We’re creating an interceptor that looks at every failed response. If that response has the status code of 401 (unauthorized), we take the user to the login screen so he’ll… log in.

Two details you should take note of:

- We’re explicitly not redirecting if the `/login` request itself returned 401. That’s because in that situation you’re probably already in the login screen and want to show a “Bad password” message and not reload the screen :)
- Be careful to return `$q.reject(rejection)`. If you don’t reject the return value, Angular would think you recovered from the error.

# Done.

I bet this was simpler than you expected. The *key takeaway* here is that your Angular app is never supposed to make a decision about if you are logged in or not. That decision is left up to your API.

That’s great separation of concerns and it really makes things simpler on the client side.

# “Wait! What about {some feature}?”

This is the basic recipe. With it you’ve got a working system you can actually start using *right now*.

There are endless tweaks to make: add a log out button, redirect back to where you were after login, special admin-only pages, persisting tokens in local storage, etc. I’ll be posting guides to some of these soon. Leave a comment if you’d like me to expand on any specific feature.

<!-- Begin MailChimp Signup Form -->
<div id="mc_embed_signup" class="cta">
<form action="http://codelord.us6.list-manage.com/subscribe/post?u=78b36f07d7d2e7e91eb8deee3&amp;id=c9a8d439c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <label for="mce-EMAIL">Get the next authentication guides, prepare for 2.0 and write maintainble Angular!</label>
    <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required style="display: inline"><!--
    --><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" style="display: inline">
    <input type="hidden" value="" name="SIGNUP_URL" class="email" id="mce-SIGNUP_URL">
    <div class="promise">~3 mails a month, unsubscribe anytime, no spam, promise!</div>
</form>
</div>
<script type="text/javascript">
document.getElementById('mce-SIGNUP_URL').value = document.location.href;
</script>
<!--End mc_embed_signup-->
