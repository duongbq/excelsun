<?php $current_account = $this->csession->get('logged_user'); ?>
<section class="grid_8 first top">

    <div class="widget profile">
        <?php $this->load->view('profile_header'); ?>
        <section>
            <?php echo form_open('profile/change_profile'); ?>
            <?php echo isset($error) ? $error : NULL; ?>
            <?php // echo heading('Details', 4); ?>
            <!--            <h4>Details</h4>-->
            <hr/>
            <fieldset>
                <dl>
                    <dt><label>First name *</label></dt>
                    <dd><input type="text" name="first_name" required="required"
                               value="<?php echo $current_account->first_name; ?>"/></dd>

                    <dt><label>Last name *</label></dt>
                    <dd><input type="text" name="last_name" required="required"
                               value="<?php echo $current_account->last_name; ?>"/></dd>

                    <dt><label>Date of birth</label></dt>
                    <dd><input type="date" name="dob" value="<?php echo $current_account->dob; ?>"/></dd>

                    <dt><label>Sex</label></dt>
                    <dd>
                        <?php echo form_radio('sex', 1, ($current_account->sex == 1) ? TRUE : FALSE); ?>Male
                        &nbsp;
                        <?php echo form_radio('sex', 0, ($current_account->sex == 0) ? TRUE : FALSE); ?>Female
                    </dd>

                    <dt><label>Email *</label></dt>
                    <dd><input type="text" name="email" required="required"
                               value="<?php echo $current_account->email; ?>"/></dd>

                    <dt><label>Username *</label></dt>
                    <dd>
                        <input readonly="readonly" type="text" name="username" required="required"
                               value="<?php echo $current_account->username; ?>"/>
                    </dd>
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
<?php $this->load->view('profile/avatar_form'); ?>

<script>
    $(document).ready(function () {
        $("#avatar").fancybox({
            'autoScale':false,
            'titlePosition':'inside',
            'transitionIn':'none',
            'transitionOut':'none'
        });
    });
</script>


