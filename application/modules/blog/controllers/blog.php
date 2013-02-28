<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/15/13
 * Time: 11:17 AM
 * To change this template use File | Settings | File Templates.
 * @property mixed layout
 */
class Blog extends Frontend_Controller
{
    function Blog()
    {
        parent::__construct();
        $this->load->model('Blog_model');
        $this->load->model('Custom_model');
    }

    function list_blog($page)
    {
        // $blog_business = $this->Custom_model->get_all_with_paging(array(
            // 'table_name' => 'blogs',
            // 'page' => $page,
            // 'per_page' => 3
        // ));
		$blog_business = $this->Custom_model->get_all(array(
            'table_name' => 'blogs',
            'pagination' => TRUE,
            'page' => $page,
            'per_page' => 3
        ));
		
        $view_data['blogs'] = $blog_business[0];
        $view_data['pagination'] = $blog_business[1];

        $this->layout->title('Blogs - ' . DEFAULT_TITLE);
        $this->layout->view('blog/list_blog', $view_data);
    }

    function view_blog_detail($id)
    {
        $blog = $this->Blog_model->get_blogs(array('id' => $id));
        $blog_meta = $this->Blog_model->get_blog_meta_tag($id);

        $view_data['blog'] = $blog[0];
        $view_data['tags'] = $this->Blog_model->get_tags_by_blog_id($id);
        $view_data['meta_keywords'] = !is_null($blog_meta) ? $blog_meta[0] : $blog_meta;
        $view_data['meta_description'] = !is_null($blog_meta) ? $blog_meta[1] : $blog_meta;
        //@todo : blog list with same tags
        $view_data['same_tags_blogs'] = $this->Blog_model->get_same_tags_blogs($id);
        //@todo : blog list with older created_date
        $view_data['recent_blogs'] = $this->Blog_model->get_recent_blogs($id);

        $this->layout->title($blog[0]->title . ' - ' . DEFAULT_TITLE);
        $this->layout->view('blog/view_blog_detail', $view_data);
    }

    function feed(){
        $this->load->helper('xml');
        $data['blogs'] = $this->Blog_model->get_blogs();
        header("Content-Type: application/rss+xml");
        $this->load->view('blog/feed', $data);
    }

}
