
<!-- Left column/section -->

<section class="grid_6 first">
    <div class="columns top">
        <div class="grid_6 first">
            <?php echo form_open_multipart('', 'class ="form widget"'); ?>
            <header><?php echo heading('New post', 2);?></header>

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
                            <label>Sumary *</label>
                            <?php echo form_input(array('multiple' => TRUE,'size' => 45, 'name' => 'sumary', 'value' => set_value('sumary'))); ?>
                        </dd>
                        <dt></dt>
                        <dd>
                            <label>Content *</label>
                            <?php echo form_textarea(array('name' => 'content', 'value' => set_value('content'))); ?>
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

