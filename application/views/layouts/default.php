<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><?php echo isset($title_for_layout) ? $title_for_layout : NULL; ?></title>
    <?php echo isset($css_for_layout) ? $css_for_layout : NULL; ?>
    <?php echo isset($js_for_layout) ? $js_for_layout : NULL; ?>
</head>
<body>
<?php echo $content_for_layout; ?>
</body>
</html>
