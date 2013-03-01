<!-- Main Section -->

<section class="column grid_6 first top">

    <div class="columns leading">
        <div class="grid_6 first leading">
            <div class="widget">
                <header><h2>Posts list</h2></header>
                <section class="no-padding">
                    <table class="datatable selectable no-border full">

                        <thead>
                        <tr>
                            <th style="width: 5%; text-align: left;">No.</th>
                            <th style="width: 65%; text-align: left;">Title</th>
                            <th style="width: 15%;">Date</th>
                            <th style="width: 15%;">Options</th>
                        </tr>
                        </thead>

                        <tbody style="text-align: center;">

                        <?php $i = get_real_no($page); ?>
                        <?php foreach($blogs as $index => $blog): ?>
                        <?php $i++; ?>
                        <tr>
                            <td style="text-align: left;"><?php echo $i; ?></td>
                            <td style="text-align: left;"><?php echo character_limiter(strip_tags($blog->title),100);?></td>
                            <td><?php echo date('d-m-Y H:i', strtotime($blog->created_date)); ?></td>
                            <td>
                                <a href="#"><img src="/assets/admin/images/view.png"/></a>
                                &nbsp;
                                <a href="#"><img src="/assets/admin/images/edit.png"/></a>
                                &nbsp;
                                <a href="#"><img src="/assets/admin/images/trash.png"/></a>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="4" style="text-align: center; height: 10px;">
                                <link rel="stylesheet" type="text/css" href="/assets/admin/css/pagination.css"/>
                                <div id="pagination"><?php echo isset($pagination) ? $pagination : NULL; ?></div>
                            </td>
                        </tr>
                        </tfoot>
                    </table>

                </section>
            </div>
        </div>
    </div>
    <div class="clear">&nbsp;</div>

</section>
<script>

    function change_page(offset, per_page) {
        var current_uri = '/blog/admin_blog';
        var page = offset / per_page + 1;
        var url = current_uri + '/page-' + page + '<?php echo $this->config->item('url_suffix'); ?>';
        location.href = url;
        return;
    }

</script>
<!-- Main Section End -->

<?php $this->load->view('right_sidebar');?>