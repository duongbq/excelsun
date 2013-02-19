<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/14/13
 * Time: 11:07 AM
 * To change this template use File | Settings | File Templates.
 */
class Contact extends Frontend_Controller
{
    function __construct()
    {
        parent::__construct();
    }

    function index()
    {
        $this->layout->view('contact_form');
    }

    function send_contact()
    {
        $view_data = array();
        if ($this->is_postback()) {
            $this->load->model('Contact_model');
            if (!$this->Contact_model->add_new_contact()) {
                $view_data['error'] = $this->Contact_model->get_last_message();
            } else {
                redirect(base_url());
            }
        }
        $this->layout->view('contact_form', $view_data);
    }

}
