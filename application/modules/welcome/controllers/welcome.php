<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Welcome extends CI_Controller
{


    function __construct()
    {
        parent::__construct();
        $this->load->library('layout');
    }

    function index()
    {
        $this->load->helper('url');
        $this->layout->title('Restful Web Service');
//        $this->layout->choose_layout('layouts/custom_layout');
        $this->layout->view('welcome_message');
    }

}

/* End of file welcome.php */
/* Location: ./system/application/controllers/welcome.php */