<div class="section" id="apropos">

    <div class="section-heading">
        <h1><strong><font color="#FFCC33">ExcelSun</font></strong>Blog</h1>
    </div>

    <div class="section-content">
        <div class="section-content-inner">

            <h2><?php echo $blog->title; ?></h2>
            <span style="font-weight: normal; font-size: small;">
                <?php echo date('d-m-Y', strtotime($blog->created_date)); ?>
                Tags: <?php echo $tags; ?>
            </span>

            <div style="clear: both;">&nbsp;</div>
            <p align="justify"><?php echo $blog->sumary; ?></p>

            <!--            <h3>Sous-titre</h3>-->

            <p align="justify" style="font-weight: normal;">
                <!--                content-->
                <?php echo $blog->content; ?>
                <!--                content-->


            </p>

            <p align="justify" style="font-weight: normal;">

            <iframe
                    src="http://www.facebook.com/plugins/comments.php?href=<?php echo current_url(); ?>&permalink=1"
                    scrolling="no"
                    frameborder="0"
                    style="border:none;
                    overflow:hidden;
                    width:130px; height:16px;"
                    allowTransparency="true"></iframe>

            <div id="fb-root"></div>
            <script>(function (d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s);
                js.id = id;
                js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));</script>

            <div class="fb-comments" style="float: left;"
                 data-href="<?php echo current_url(); ?>"
                 data-width="470"
                 data-num-posts="10"></div>

            <div style="float: left; margin-left: 10px; font-weight: normal; font-size: small;">
                <h3>Recently posts</h3>
                <ul>
                    <li style="margin-bottom: 5px;"><a href="#">Using Comments to Prevent Execution</a></li>
                    <li style="margin-bottom: 5px;"><a href="#">Use my app inside Facebook.com.</a></li>
                    <li style="margin-bottom: 5px;"><a href="#">Bookmark my web app on Facebook mobile.</a></li>
                    <li style="margin-bottom: 5px;"><a href="#">Build a custom tab for Facebook Pages.</a></li>

<!--                    <li style="margin-bottom: 5px;">--><?php //echo anchor(site_url('blog'), 'View all..'); ?><!--</li>-->
                </ul>

                <h3>Related posts</h3>
                <ul>
                    <li style="margin-bottom: 5px;"><a href="#">Using Comments to Prevent Execution</a></li>
                    <li style="margin-bottom: 5px;"><a href="#">Use my app inside Facebook.com.</a></li>
                    <li style="margin-bottom: 5px;"><a href="#">Bookmark my web app on Facebook mobile.</a></li>
                    <li style="margin-bottom: 5px;"><a href="#">Build a custom tab for Facebook Pages.</a></li>
                </ul>
            </div>
            </p>


            <div class="clearboth"></div>
        </div>
    </div>
</div>