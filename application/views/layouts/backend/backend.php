<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><?php echo isset($title_for_layout) ? $title_for_layout : NULL; ?></title>
    <!--        <link rel="icon" href="/assets/images/favicon.ico" type="image/x-icon" />-->
    <?php echo link_tag('assets/images/favicon.ico', 'icon', 'image/x-icon'); ?>
    <?php echo link_tag('assets/admin/css/reset.css'); ?>
    <?php echo link_tag('assets/admin/css/style.css'); ?>
    <?php echo link_tag('assets/admin/css/messages.css'); ?>
    <?php echo link_tag('assets/admin/css/forms.css'); ?>
    <?php echo link_tag('assets/admin/css/tables.css'); ?>

    <!--[if lt IE 8]>
    <link rel="stylesheet" media="screen" href="/assets/admin/css/ie.css"/>
    <![endif]-->

    <!-- jquerytools -->
    <script src="/assets/admin/js/jquery.tools.min.js"></script>
    <script src="/assets/admin/js/jquery.ui.min.js"></script>
    <script src="/assets/admin/js/jquery.flot.js"></script>

    <script type="text/javascript" src="/assets/admin/js/global.js"></script>

    <!--[if lt IE 9]>
    <script type="text/javascript" src="/assets/admin/js/html5.js"></script>
    <script type="text/javascript" src="/assets/admin/js/PIE.js"></script>
    <script type="text/javascript" src="/assets/admin/js/IE9.js"></script>
    <script type="text/javascript" src="/assets/admin/js/ie.js"></script>
    <script type="text/javascript" src="/assets/admin/js/excanvas.js"></script>
    <![endif]-->

    <?php echo isset($css_for_layout) ? $css_for_layout : NULL; ?>
    <?php echo isset($js_for_layout) ? $js_for_layout : NULL; ?>

</head>
<body>

<div id="wrapper">
    <header id="page-header">
        <div class="wrapper">
            <?php echo heading('ExcelSun Control panel', 1); ?>
            <?php $this->load->view('layouts/backend/main-nav'); ?>
        </div>
        <div id="page-subheader">
            <div class="wrapper">
                <?php $this->load->view('layouts/backend/sub-nav'); ?>
            </div>
        </div>
    </header>

    <section id="content">
        <div class="wrapper">
            <?php echo $content_for_layout; ?>
            <div class="clear"></div>
        </div>
        <div id="push"></div>
    </section>

</div>
<?php $this->load->view('layouts/backend/footer'); ?>
</body>
</html>
