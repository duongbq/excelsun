<?php echo '<?xml version="1.0" encoding="utf-8"?>' . "\n"; ?>
<rss version="2.0"
     xmlns:dc="http://purl.org/dc/elements/1.1/"
     xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
     xmlns:admin="http://webns.net/mvcb/"
     xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
     xmlns:content="http://purl.org/rss/1.0/modules/content/">

    <channel>
        <title><?php echo 'Blogs - ' . DEFAULT_TITLE; ?></title>
        <description><![CDATA[ <?php echo DEFAULT_DESCRIPTION;?> ]]></description>
        <link><?php echo current_url(); ?></link>
        <copyright><?php echo base_url(); ?></copyright>
        <pubDate><?php echo gmdate("D, d M Y H:i:s \G\M\T", time());?></pubDate>
        <lastBuildDate><?php echo gmdate("D, d M Y H:i:s \G\M\T", time());?></lastBuildDate>

        <?php foreach($blogs as $blog): ?>
        <item>
            <title><?php echo xml_convert($blog->title); ?></title>
            <description><![CDATA[ <?php echo character_limiter(strip_tags($blog->sumary),200);?> ]]></description>
            <link><?php echo site_url('blog/'. mb_strtolower(url_title(removesign($blog->title))) . '-i' . $blog->id); ?></link>
            <pubDate><?php echo gmdate("D, d M Y H:i:s \G\M\T",strtotime($blog->created_date));?></pubDate>
        </item>
        <?php endforeach; ?>
    </channel>
</rss>