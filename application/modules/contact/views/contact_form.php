<div class="section" id="contact">

    <div class="section-heading">
        <h1>Contactez <strong>Excel<font color="#FFCC33">Sun</font></strong></h1>
    </div>

    <div class="section-content">
        <div class="section-content-inner clearfix">

            <div class="two-third sep-big">
                <h2>Send us a message</h2>

                <div class="clearfix" id="contact-form">
                    <?php echo isset($error) ? $error : NULL;?>

                    <!--                    <p>-->
                    <!--                        Donec sollicitudin aliquet dui, ut sodales sapien mattis sed. Phasellus ut imperdiet nibh. Morbi-->
                    <!--                        in felis a felis congue cursus. Nulla ullamcorper diam sit amet massa porttitor vulputate.-->
                    <!--                        Phasellus vel arcu at velit varius vestibulum.-->
                    <!--                    </p>-->

                    <?php echo form_open('contact/send_contact', array('id' => 'send_contact_form')); ?>

                    <div class="form-group text-field">
                        <label for="first_name">First name*</label>
                        <input type="text" name="first_name" id="first_name"
                               value="<?php echo set_value('first_name'); ?>"/>
                    </div>

                    <div class="form-group text-field">
                        <label for="last_name">Last name*</label>
                        <input type="text" name="last_name" id="last_name"
                               value="<?php echo set_value('last_name'); ?>"/>
                    </div>

                    <div class="clearboth"></div>

                    <div class="form-group text-field">
                        <label for="email">Email*</label>
                        <input type="text" name="email" id="email" value="<?php echo set_value('email'); ?>"/>
                    </div>

                    <div class="form-group text-field">
                        <label for="tel">Tel</label>
                        <input type="text" name="tel" id="tel" value="<?php echo set_value('tel'); ?>"/>
                    </div>

                    <div class="form-group">
                        <label for="message">Message*</label>
                        <textarea cols="4" rows="6" name="message"
                                  id="message"><?php echo set_value('message'); ?></textarea>
                    </div>

                    <!--                        captcha-->
                    <div class="form-group text-field">
                        <label for="security_code">Security code*</label>
                        <input type="text" name="security_code" id="security_code" value=""/>
                    </div>
                    <div class="form-group text-field">
                        <label for="security_code">&nbsp;</label>
                        <img src="/security_code" alt="Security code" style="float: left; height: 31px;"/>
                    </div>
                    <!--                        captcha-->

                    <div class="clearboth"></div>

                    <p>
                        <a class="button button-type2" href="javascript:void(0);"
                           onclick="document.getElementById('send_contact_form').submit(); return false;">
                            Send
                        </a>
                    </p>

                    <?php echo form_close(); ?>

                </div>
            </div>

            <div class="one-third">
                <h2>Adresse</h2>

                <div id="contact-info">

                    <p>Centre Excelsun Inc<br/>
                        405, rue du Sud, Cowansville, QC, J2K2X6<br/>
                        450-263-3555<br/>
                        <a href="mailto:info@excelsun.com">info@excelsun.com</a></p>

                    <div id="contact-map">
                        <iframe scrolling="no" frameborder="0"
                                src="http://maps.google.com/maps?hl=us&amp;q=excelsun&amp;ie=UTF8&amp;hq=excelsun&amp;hnear=&amp;radius=15000&amp;ll=45.205005,-72.746633&amp;spn=0.006295,0.006295&amp;output=embed"
                                marginwidth="0" marginheight="0" height="296px"></iframe>
                    </div>

                </div>

                <div id="social-network" class="clearfix">
                    <a href="http://www.facebook.com/people/Excelsun-Centre/100000075002476" target="_blank">
                        <img src="/assets/images/content/social_icon_facebook.png" alt="Facebook"/>
                    </a>
                    <a href="#" target="_blank">
                        <img src="/assets/images/content/social_icon_flicker.png" alt="Flicker"/>
                    </a>
                    <a href="#" target="_blank">
                        <img src="/assets/images/content/social_icon_linkedin.png" alt="Linkedin"/>
                    </a>
                    <a href="#" target="_blank">
                        <img src="/assets/images/content/social_icon_myspace.png" alt="Myspace"/>
                    </a>
                    <a href="http://twitter.com/CentreExcelSun" target="_blank">
                        <img src="/assets/images/content/social_icon_twitter.png" alt="Twitter"/>
                    </a>
                </div>

            </div>

            <div class="clearboth"></div>

        </div>
    </div>
</div>