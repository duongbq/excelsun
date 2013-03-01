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
        $this->load->helper('ckeditor');
    }

    function list_blog($page)
    {
        $blog_business = $this->Custom_model->get_all(array(
            'table_name' => 'blogs',
            'pagination' => TRUE,
            'page' => $page,
            'per_page' => 10
        ));

        $view_data['page'] = $page;
        $view_data['blogs'] = $blog_business[0];
        $view_data['pagination'] = $blog_business[1];

//        $this->layout->title('Blogs - ' . DEFAULT_TITLE);
        $this->layout->view('admin/list_blog', $view_data);
    }

    function new_blog(){

        $view_data = array();
        if ($this->is_postback()) {
            if (!$this->Blog_model->create_blog()) {
                $view_data['error'] = $this->Blog_model->get_last_messages();
            } else {
                redirect('blog/admin_blog/list_blog');
            }
        }

        $this->layout->view('blog/admin/blog_form', $view_data);
    }

}
