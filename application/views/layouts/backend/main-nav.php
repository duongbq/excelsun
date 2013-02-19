<?php $first_segment = $this->uri->segment(1); ?>
<nav id="main-nav">
    <ul class="clearfix">
        <li class="<?php echo $first_segment == 'dashboard' ? 'active' : NULL; ?>">
            <?php echo anchor('dashboard', 'Dashboard'); ?>
        </li>
        <li class="<?php echo $first_segment == 'media' ? 'active' : NULL; ?>">
            <?php echo anchor('media/media_admin/list_video', 'Media'); ?>
        </li>
        <li class="<?php echo $first_segment == 'report' ? 'active' : NULL; ?>">
            <?php echo anchor('report', 'Reporting'); ?>
        </li>
        <li class="<?php echo $first_segment == 'shop' ? 'active' : NULL; ?>">
            <?php echo anchor('shop/admin_shop', 'Shop'); ?>
        </li>
        <li class="<?php echo $first_segment == 'blog' ? 'active' : NULL; ?>">
            <?php echo anchor('blog/admin_blog', 'Blog'); ?>
        </li>
        <li id="quick-links" class="fr">
            <a href="javascript:void(0);">
                <?php echo $this->csession->get('logged_user')->first_name; ?>
                <span>&darr;</span>
            </a>
            <ul>
                <li><?php echo anchor('profile/change_profile', 'Profile'); ?></li>
                <li><?php echo anchor('profile/change_profile/pwd', 'Password'); ?></li>
                <li><a href="<?php echo base_url(); ?>" target="_blank">View front-end</a></li>
                <li><?php echo anchor('auth/logout', 'Logout'); ?></li>
            </ul>
        </li>
    </ul>
</nav>
