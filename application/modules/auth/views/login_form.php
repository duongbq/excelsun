<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title><?php echo lang('auth.title'); ?></title>

    <?php echo link_tag('assets/admin/css/reset.css'); ?>
    <?php echo link_tag('assets/admin/css/style.css'); ?>
    <?php echo link_tag('assets/admin/css/messages.css'); ?>
    <?php echo link_tag('assets/admin/css/forms.css'); ?>
    <?php echo link_tag('assets/admin/css/tables.css'); ?>
</head>

<body class="login">
<!--Change language link-->
<!--        <div class="grid_8" style="float: right; margin-top: 10px;  margin-right: 20px;">
            <img src="/assets/images/vi.png" />
            &nbsp;
            <?php //echo anchor('#', img('assets/images/vi.png')); ?>
        </div>-->
<!--Change language link-->

<div class="login-box widget">
    <header><?php echo heading(lang('auth.header'), 2); ?></header>
    <section>

        <?php echo isset($error) ? $error : '<div class="message info closeable">' . lang('auth.message.info') . '</div>'; ?>

        <?php echo form_open('auth'); ?>
        <p>
            <?php echo form_input(array('placeholder' => lang('auth.username'), 'required' => 'required', 'class' => 'full', 'id' => 'username', 'name' => 'username', 'value' => set_value('username'))); ?>
        </p>

        <p>
            <?php echo form_password(array('placeholder' => lang('auth.password'), 'required' => 'required', 'class' => 'full', 'id' => 'password', 'name' => 'password')); ?>
        </p>

        <p class="clearfix">
                    <span class="fl">
                        <input type="checkbox" id="remember" class="" value="1" name="remember"/>
                        <label class="choice" for="remember"><?php echo lang('auth.remember'); ?></label>
                    </span>

            <button class="button button-gray fr" type="submit"><?php echo lang('auth.login'); ?></button>
        </p>
        <?php echo form_close(); ?>
        <ul>
            <li><a href="#"><?php echo lang('auth.forgot.password'); ?></a></li>
        </ul>
    </section>
</div>
</body>
</html>