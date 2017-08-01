<div class="ck_form ck_naked cta">
  <h2>"Maintaining AngularJS feels like Cobol 🤷‍♂️…"</h2>
  <p>
  You want to do AngularJS <em>the right way</em>.<br>
  Yet every blog post you see makes it look like your codebase is obsolete.
  Components? Lifecycle hooks? Controllers are dead?
  </p>

  <p>
  It would be great to work on a modern codebase again, but who has weeks for a rewrite?<br>
  Well, you can get your app back in shape, without pushing back all your deadlines!
  Imagine, upgrading smoothly along your regular tasks, no longer deep in legacy.
  </p>

  <p>
  Subscribe and get my free email course with steps for upgrading your AngularJS app
  to the latest 1.6 safely and without a rewrite.
  </p>

  <div class="ck_form_fields">

    <div id='ck_success_msg'  style='display:none;'>
      <p>Success! You rock. You&#x27;ll get some knowledge shipped to your inbox soon. Let&#x27;s do this!</p>
    </div>

    <!--  Form starts here  -->
    <form id="ck_subscribe_form" class="ck_subscribe_form" action="https://app.convertkit.com/landing_pages/{% if page.cta_form %}{{page.cta_form}}{% else %}7872{% endif %}/subscribe" data-remote="true">
      {% if page.cta_message %}
      <h2>{{ page.cta_message }}</h2>
      {% else %}
      <h2>Get the modernization email course!</h2>
      {% endif %}
      <input type="hidden" value="{&quot;form_style&quot;:&quot;naked&quot;,&quot;embed_style&quot;:&quot;inline&quot;,&quot;embed_trigger&quot;:&quot;scroll_percentage&quot;,&quot;scroll_percentage&quot;:&quot;70&quot;,&quot;delay_seconds&quot;:&quot;10&quot;,&quot;display_position&quot;:&quot;br&quot;,&quot;display_devices&quot;:&quot;all&quot;,&quot;days_no_show&quot;:&quot;15&quot;,&quot;converted_behavior&quot;:&quot;show&quot;}" id="ck_form_options"></input>
      <input type="hidden" name="id" value="{% if page.cta_form %}{{page.cta_form}}{% else %}7872{% endif %}" id="landing_page_id"></input>
      <div class="ck_errorArea">
        <div id="ck_error_msg" style="display:none">
          <p>There was an error submitting your subscription. Please try again.</p>
        </div>
      </div>
      <div class="ck_control_group ck_email_field_group">
        <label class="ck_label" for="ck_emailField" style="display: none">Email Address</label>
          <input type="text" name="first_name" class="ck_first_name" id="ck_firstNameField" placeholder="First Name"></input>
          <input type="email" name="email" class="ck_email_address" id="ck_emailField" placeholder="Email Address" required></input>
      </div>

      <button class="subscribe_button ck_subscribe_button btn fields" id='ck_subscribe_button'>
        Subscribe
      </button>
    </form>
  </div>

 </div>
