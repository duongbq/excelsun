<?php
$route['^blog$'] = 'blog/list_blog/1';
$route['^blog/page-(\d+)$'] = 'blog/list_blog/$1';
$route['blog/(:any)-i(\d+)'] = 'blog/view_blog_detail/$2';