<!-- Left column/section -->

<section class="grid_6 first">
    <div class="columns top">
        <div class="grid_6 first">
            <?php echo form_open_multipart('media/media_admin/new_video', 'class ="form widget"'); ?>
            <header><?php echo heading('New media', 2);?></header>

            <section>
                <?php echo isset($error) ? $error : NULL; ?>
                <fieldset>
                    <dl>
                        <dt></dt>
                        <dd>
                            <label>Title *</label>
                            <?php echo form_input(array('size' => 45, 'required' => 'required', 'name' => 'title', 'value' => set_value('title'))); ?>
                        </dd>

                        <dt></dt>
                        <dd>
                            <label>Separate tags with commas</label>
                            <?php echo form_input(array('size' => 45, 'name' => 'tags', 'value' => set_value('tags'))); ?>

                        </dd>

                        <dt></dt>
                        <dd>
                            <label>Description</label>
                            <?php echo form_textarea(array('style' => 'width: 450px;', 'name' => 'description', 'value' => set_value('description'))); ?>
                        </dd>
                        <dt></dt>
                        <dd>
                            <label>Media file*</label>
                            <?php echo form_upload(array('accept' => 'video/*', 'size' => 36, 'required' => 'required', 'name' => 'userfile', 'value' => set_value('userfile'))); ?>
                        </dd>

                    </dl>
                </fieldset>

                <hr/>
                <button class="button button-green" type="submit">Submit form</button>
                <button class="button button-gray" type="reset">Reset</button>
            </section>
            <?php echo form_close(); ?>
        </div>
    </div>

    <div class="clear">&nbsp;</div>

</section>

<!-- End of Left column/section -->

<!-- Right column/section -->
<?php $this->load->view('right_sidebar'); ?>
<!-- End of Right column/section -->

