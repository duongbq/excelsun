<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/28/13
 * Time: 4:42 PM
 * To change this template use File | Settings | File Templates.
 */
class Admin_blog extends Backend_Controller
{
    function Admin_blog(){
        parent::__construct();
        $this->load->model('Blog_model');
        $this->load->model('Custom_model');
    }

    function list_blog($page)
    {
        $blog_business = $this->Custom_model->get_all(array(
            'table_name' => 'blogs',
            'pagination' => TRUE,
            'page' => $page,
            'per_page' => 10
        ));

        $view_data['blogs'] = $blog_business[0];
        $view_data['pagination'] = $blog_business[1];

//        $this->layout->title('Blogs - ' . DEFAULT_TITLE);
        $this->layout->view('admin/list_blog', $view_data);
    }

}
