<div style="display: none;">
    <div id="inline" style="width:600px; height:200px;overflow:auto;">
        <dl>
            <dt>Avatar</dt>
            <dd>
                <?php
                echo isset($avatar) && !is_null($avatar) ? img('uploads/avatar/' . $avatar) . br() : NULL;
                echo form_open_multipart(
                    NULL,
                    array('id' => 'avatar_form'),
                    array('current_url' => current_url())
                );
                ?>
                <div>
                    <div style="float: left;"><input type="file" name="userfile" size="30" accept="image/*"/></div>
                    <div>
                        <button onclick="submit_avatar_form();" type="submit" style="height: 24px; margin-left: 5px;">
                            Change avatar
                        </button>
                    </div>
                </div>
                <?php echo form_close(); ?>
            </dd>
        </dl>
    </div>
</div>



<script>
    function submit_avatar_form() {
        $('#avatar_form').attr('action', '<?php echo site_url('profile/change_avatar'); ?>');
        $('#avatar_form').submit();
    }

</script>

