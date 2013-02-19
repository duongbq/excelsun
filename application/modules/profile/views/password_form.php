<section class="grid_8 first top">

    <div class="widget profile">
        <?php $this->load->view('profile_header'); ?>
        <section>
            <?php echo form_open('profile/change_profile/TRUE'); ?>
            <?php echo isset($error) ? $error : NULL; ?>
            <hr/>
            <fieldset>
                <dl>
                    <dt><label>Current password *</label></dt>
                    <dd><?php echo form_password(array('required' => 'required', 'name' => 'current_password')); ?> </dd>

                    <dt><label>New password *</label></dt>
                    <dd><?php echo form_password(array('required' => 'required', 'name' => 'new_password')); ?> </dd>

                    <dt><label>Confirm new password *</label></dt>
                    <dd><?php echo form_password(array('required' => 'required', 'name' => 'conf_new_password')); ?> </dd>

                </dl>
            </fieldset>

            <hr/>
            <button class="button button-green" type="submit">Submit form</button>
            <button class="button button-gray" type="reset">Reset</button>
            <div class="clear"></div>
            <?php echo form_close(); ?>
        </section>
    </div>

</section>
