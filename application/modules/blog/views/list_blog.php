<?php $module = $this->uri->segment(1); ?>
<div class="section" id="apropos">

    <div class="section-heading">
        <h1><strong><font color="#FFCC33">ExcelSun</font></strong>Blog</h1>
    </div>

    <div class="section-content">
        <div class="section-content-inner">

           <div style="text-align: right; color: #888888; font-size: x-small; margin-bottom: 10px;">
               <form action="<?php echo current_url(); ?>" method="get">
                   <input type="text" style="width: 300px;" name="search" value="<?php echo $this->input->get('search'); ?>" placeholder="Enter keyword..."/>
                   <button type="submit" class="btn_search">Search</button>
                   <a target="_blank" href="<?php echo site_url('blog/feed');?>" style="text-decoration: none;">Subscribe to RSS <img src="/assets/images/rss.png"/></a>
               </form>
           </div>



            <?php if (isset($blogs) && count($blogs) > 0): ?>

            <?php foreach ($blogs as $blog): ?>
                <h2><?php echo $blog->title; ?></h2>
                <span style="font-size: small; font-style: italic; font-weight: lighter;"><?php echo date('d-m-Y', strtotime($blog->created_date)); ?></span>
                <p align="justify">
                    <?php echo $blog->sumary; ?> <br/>
                    <?php echo anchor($module . '/' . mb_strtolower(url_title(removesign($blog->title))) . '-i' . $blog->id, 'Read more...'); ?>
                </p>
                <?php endforeach; ?>
            <div id="pagination"><?php echo isset($pagination) ? $pagination : NULL; ?></div>

            <?php else: ?>
            <h2>No records at this time...</h2>
            <?php endif; ?>




            <div class="clearboth"></div>
        </div>
    </div>
</div>

<script>

    function change_page(offset, per_page) {
        var current_uri = '<?php echo '/' . $module; ?>';
        var page = offset / per_page + 1;
        var url = current_uri + '/page-' + page + '<?php echo $this->config->item('url_suffix'); ?>';
        location.href = url;
        return;
    }

</script>