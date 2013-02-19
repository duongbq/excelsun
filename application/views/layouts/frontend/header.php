<div id="header">

    <div id="header-bg"></div>

    <div id="header-inner">

        <!-- begin of <#logo> -->
        <div id="logo">
            <?php echo anchor(base_url(), img('assets/images/content/logo.png')); ?>
        </div>
        <!-- end of <#logo> -->

        <!-- begin of <.navigation> -->
        <ul class="navigation">
            <li><?php echo anchor(base_url(), 'Home'); ?></li>
            <li><?php echo anchor('pages/about', 'About'); ?></li>
            <li><?php echo anchor('promotion', 'Promotion'); ?></li>
            <li><?php echo anchor('blog', 'Blog'); ?></li>
            <li><?php echo anchor('media', 'Media'); ?></li>
            <li><?php echo anchor('contact', 'Contact'); ?></li>
            <li><?php echo anchor('connection', 'Connection'); ?></li>
        </ul>
        <!-- end of <.navigation> -->
    </div>
</div>