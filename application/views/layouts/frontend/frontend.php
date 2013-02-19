<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <?php
    echo meta(array(
        array('name' => 'description', 'content' => isset($meta_description) ? $meta_description : DEFAULT_DESCRIPTION),
        array('name' => 'keywords', 'content' => isset($meta_keywords) ? $meta_keywords : DEFAULT_KEYWORDS),
        array('name' => 'robots', 'content' => 'index,follow'),
        array('name' => 'Content-type', 'content' => 'text/html; charset=utf-8', 'type' => 'equiv')
    ));
    ?>
    <title><?php echo isset($title_for_layout) && $title_for_layout != '' ? $title_for_layout : DEFAULT_TITLE; ?></title>
    <?php echo link_tag('assets/styles/general.css'); ?>
<!--    --><?php //echo link_tag('assets/styles/prettyPhoto.css'); ?>
    <?php echo link_tag('assets/images/favicon.ico', 'shortcut icon', 'image/x-icon'); ?>

    <script type="text/javascript" src="/assets/scripts/jquery-1.9.0.min.js"></script>
    <!--    <script type="text/javascript" src="/assets/scripts/jquery.cycle.all.min.js"></script>-->
    <!--    <script type="text/javascript" src="/assets/scripts/jquery.prettyPhoto.js"></script>-->
    <!--    <script type="text/javascript" src="/assets/scripts/jquery.scrollTo-1.4.2-min.js"></script>-->
    <script type="text/javascript" src="/assets/scripts/cufon-yuibb38.js?v=1.09i"></script>
    <script type="text/javascript" src="/assets/scripts/League_Gothic_400.font.js"></script>
    <script type="text/javascript" src="/assets/scripts/Bauhaus93_400.font.js"></script>

    <!-- Custom -->
    <link rel="stylesheet" type="text/css" href="/assets/styles/custom.css"/>
    <link rel="stylesheet" type="text/css" href="/assets/styles/pagination.css"/>
    <!--    <script type="text/javascript" src="/assets/scripts/custom.js"></script>-->
    <!--    <script type="text/javascript" src="/assets/scripts/colorpicker.js"></script>-->
    <?php echo isset($css_for_layout) ? $css_for_layout : NULL; ?>
    <?php echo isset($js_for_layout) ? $js_for_layout : NULL; ?>
</head>

<body class="page-bg-type8">
<a name="top" id="top"></a>

<?php $this->load->view('layouts/frontend/changer'); ?>

<div id="pattern"></div>

<!-- begin of <#header> -->
<?php $this->load->view('layouts/frontend/header'); ?>
<!-- end of <#header> -->

<!-- begin of <#content> -->
<div id="content">
    <?php echo $content_for_layout; ?>
</div>
<!-- end of <#content> -->

<!-- begin of <#footer> -->
<?php $this->load->view('layouts/frontend/footer'); ?>
<!-- end of <#footer> -->

<script type="text/javascript">
    Cufon.now();
    $(document).ready(function () {
//        auto_hide_changer();
    });

    function auto_hide_changer() {
        var timeout = null;
        $("#style-changer").hover(function () {
                    if (timeout) {
                        clearTimeout(timeout);
                        timeout = null;
                    }
                    $(this).animate({ marginLeft:0 }, 'fast');
                },
                function () {
//                    var menuBar = $(this);
                    timeout = setTimeout(function () {
                        timeout = null;
                        $(this).animate({ marginLeft:-146 }, 'fast');
                    }, 3000);
                }
        );
    }

</script>

<!--<script type="text/javascript">-->
<!--    var _gaq = _gaq || [];-->
<!--    _gaq.push(['_setAccount', 'UA-2100567-9']);-->
<!--    _gaq.push(['_trackPageview']);-->
<!---->
<!--    (function () {-->
<!--        var ga = document.createElement('script');-->
<!--        ga.type = 'text/javascript';-->
<!--        ga.async = true;-->
<!--        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';-->
<!--        var s = document.getElementsByTagName('script')[0];-->
<!--        s.parentNode.insertBefore(ga, s);-->
<!--    })();-->
<!---->
<!--</script>-->

</body>
</html>