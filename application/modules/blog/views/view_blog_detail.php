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

            <iframe src="https://www.facebook.com/plugins/like.php?href=<?php echo current_url(); ?>"
                    scrolling="no" frameborder="0"
                    style="border:none; width:450px; height:60px"></iframe>

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
                    <?php foreach ($recent_blogs as $blog_item): ?>
                    <li style="margin-bottom: 5px;">
                        <?php echo anchor('blog/' . mb_strtolower(url_title(removesign($blog_item->title))) . '-i' . $blog_item->id, character_limiter(strip_tags($blog_item->title), 80)); ?>
                    </li>
                    <?php endforeach; ?>
                </ul>

                <h3>Related posts</h3>
                <ul>
                    <?php foreach ($same_tags_blogs as $blog_item): ?>
                    <li style="margin-bottom: 5px;">
                        <?php echo anchor('blog/' . mb_strtolower(url_title(removesign($blog_item->title))) . '-i' . $blog_item->id, character_limiter(strip_tags($blog_item->title), 80)); ?>
                    </li>
                    <?php endforeach; ?>
                </ul>
            </div>
            </p>


            <div class="clearboth"></div>
        </div>
    </div>
</div>