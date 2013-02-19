<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/4/13
 * Time: 9:36 AM
 * To change this template use File | Settings | File Templates.
 */
class Frontend_Controller extends MX_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->set_up_layout();

    }

    private function set_up_layout()
    {
        $this->load->library('layout');
//        $this->layout->title(DEFAULT_TITLE);
        $this->layout->choose_layout('layouts/frontend/frontend');
    }
}
