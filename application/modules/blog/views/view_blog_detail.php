<div class="section" id="apropos">

    <div class="section-heading">
        <h1><strong><font color="#FFCC33">ExcelSun</font></strong>Blog</h1>
    </div>

    <div class="section-content">
        <div class="section-content-inner">

            <h2><?php echo $blog->title; ?></h2>
            <span style="font-weight: normal; font-size: small;">
                <?php echo date('d-m-Y',strtotime($blog->created_date)); ?>
                Tags: <?php echo $tags; ?>
            </span>
            <div style="clear: both;">&nbsp;</div>
            <p align="justify"><?php echo $blog->sumary; ?></p>

<!--            <h3>Sous-titre</h3>-->

            <p align="justify" style="font-weight: normal;">
                <?php echo $blog->content; ?>
            </p>

<!--            <h3>Sous-titre</h3>-->
<!---->
<!--            <p align="justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam iaculis egestas laoreet.-->
<!--                Etiam faucibus massa sed risus lacinia in vulputate dolor imperdiet. Curabitur pharetra, purus a commodo-->
<!--                dignissim, sapien nulla tempus nisi, et varius nulla urna at arcu. Lorem ipsum dolor sit amet,-->
<!--                consectetur adipiscing elit. Aliquam iaculis egestas laoreet. Etiam faucibus massa sed risus lacinia in-->
<!--                vulputate dolor imperdiet. Curabitur pharetra, purus a commodo dignissim, sapien nulla tempus nisi, et-->
<!--                varius nulla urna at arcu.-->
<!--            </p>-->

            <div class="clearboth"></div>
        </div>
    </div>
</div>